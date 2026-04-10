import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/course_bloc.dart';
import '../models/course.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<CourseBloc>().add(LoadCourses());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseBloc, CourseState>(
      listener: (context, state) {
        if (state is CourseError) {
          showFToast(
            context: context,
            variant: .destructive,
            icon: Icon(FIcons.circleX),
            title: Text('Error'),
            description: Text(state.message),
          );
        }
      },
      builder: (context, state) {
        if (state is CourseLoading) {
          return const Center(child: FCircularProgress());
        } else if (state is CoursesLoaded) {
          final filteredCourses = state.courses.where((course) {
            return course.name.toLowerCase().contains(
              _searchQuery.toLowerCase(),
            );
          }).toList();

          return FScaffold(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with search and add button
                  Row(
                    children: [
                      Expanded(
                        child: FTextField(
                          prefixBuilder: (context, style, variants) => Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                              right: 8.0,
                            ),
                            child: const Icon(FIcons.search),
                          ),
                          onSubmit: (value) {
                            setState(() {
                              _searchQuery = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      FButton(
                        onPress: () => showFPersistentSheet(
                          context: context,
                          style: const .delta(flingVelocity: 700),
                          side: .rtl,
                          builder: (context, controller) =>
                              _buildCourseForm(controller: controller),
                        ),
                        suffix: const Icon(Icons.add),
                        child: const Text('Add Course'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Courses list
                  Expanded(child: _buildCoursesList(filteredCourses)),
                ],
              ),
            ),
          );
        } else {
          return const FScaffold(
            child: Center(child: Text('Failed to load courses')),
          );
        }
      },
    );
  }

  Widget _buildCoursesList(List<Course> courses) {
    if (courses.isEmpty) {
      return const Center(child: Text('No courses found'));
    }

    return FItemGroup.builder(
      itemBuilder: (context, index) {
        final course = courses[index];
        return FItem(
          prefix: FAvatar.raw(child: Text(course.name[0].toUpperCase())),
          title: Text(course.name),
          subtitle: Text(course.isActive ? 'Active' : 'Inactive'),
          suffix: Row(
            mainAxisSize: .min,
            spacing: 8,
            children: [
              FButton(
                child: Icon(FIcons.eye),
                onPress: () => _showCourseDetails(course),
              ),
              FButton(
                child: Icon(FIcons.pencil),
                onPress: () => showFPersistentSheet(
                  context: context,
                  style: const .delta(flingVelocity: 700),
                  side: .rtl,
                  builder: (context, controller) =>
                      _buildCourseForm(controller: controller, course: course),
                ),
              ),
              FButton(
                child: Icon(FIcons.trash),
                onPress: () => _deleteCourse(course),
              ),
            ],
          ),
        );
      },
      count: courses.length,
      divider: .full,
    );
  }

  Widget _buildCourseForm({
    Course? course,
    required FPersistentSheetController controller,
  }) {
    final isEditing = course != null;
    final formKey = GlobalKey<FormState>();
    String name = isEditing ? course.name : '';
    bool isActive = isEditing ? course.isActive : true;

    return FSheets(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.theme.colors.background,
          borderRadius: context.theme.style.borderRadius.md,
          border: .all(color: context.theme.colors.border),
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: .center,
            spacing: 16,
            children: [
              Text(
                isEditing ? 'Edit Course' : 'Add New Course',
                style: context.theme.typography.xl,
              ),
              FTextFormField(
                control: .managed(initial: TextEditingValue(text: name)),
                hint: 'Jhon Doe',
                autovalidateMode: .onUserInteraction,
                validator: (value) =>
                    value!.trim().isEmpty ? 'Name is required' : null,
                onSaved: (newValue) => name = newValue!,
              ),
              FSelect<bool>.rich(
                control: .managed(initial: isActive),
                hint: 'Select a fruit',
                format: (s) => s ? 'Active' : 'Inactive',
                children: [
                  .item(title: const Text('Active'), value: true),
                  .item(title: const Text('Inactive'), value: false),
                ],
                validator: (value) => value == null ? 'Select an item' : null,
                onSaved: (newValue) => isActive = newValue!,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: FButton(
                      onPress: () {
                        controller.hide();
                      },
                      variant: .outline,
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FButton(
                      onPress: () {
                        if (!formKey.currentState!.validate()) return;

                        formKey.currentState!.save();

                        final updatedCourse = isEditing
                            ? course.copyWith(
                                name: name.trim(),
                                isActive: isActive,
                              )
                            : Course(
                                id: '',
                                name: name.trim(),
                                isActive: isActive,
                              );

                        if (isEditing) {
                          context.read<CourseBloc>().add(
                            UpdateCourse(updatedCourse.id, updatedCourse),
                          );
                        } else {
                          context.read<CourseBloc>().add(
                            CreateCourse(updatedCourse),
                          );
                        }

                        controller.hide();
                      },
                      child: Text(isEditing ? 'Update' : 'Add'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteCourse(Course course) {
    showFDialog(
      context: context,
      builder: (context, style, animation) => FDialog(
        title: const Text('Delete Course'),
        body: Text('Are you sure you want to delete "${course.name}"?'),
        actions: [
          FButton(
            onPress: () => context.pop(),
            variant: .outline,
            child: const Text('Cancel'),
          ),
          FButton(
            onPress: () {
              context.read<CourseBloc>().add(DeleteCourse(course.id));
              context.pop();
            },
            variant: .destructive,
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showCourseDetails(Course course) {
    showFDialog(
      context: context,
      builder: (context, style, animation) => FDialog(
        title: Text('Detail Course'),
        body: FItemGroup(
          style: const .delta(spacing: 4),
          intrinsicWidth: null,
          divider: .full,
          children: [
            .item(title: const Text('Name'), details: Text(course.name)),
            .item(
              title: const Text('Status'),
              details: Text(course.isActive ? 'Active' : 'Inactive'),
            ),
          ],
        ),
        actions: [
          FButton(onPress: () => context.pop(), child: const Text('Close')),
        ],
      ),
    );
  }
}

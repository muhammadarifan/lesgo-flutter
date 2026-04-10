import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/student_bloc.dart';
import '../models/student.dart';
import '../enums/gender_enum.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<StudentBloc>().add(LoadStudents());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentBloc, StudentState>(
      listener: (context, state) {
        if (state is StudentError) {
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
        if (state is StudentLoading) {
          return const Center(child: FCircularProgress());
        } else if (state is StudentsLoaded) {
          final filteredStudents = state.students.where((student) {
            return student.name.toLowerCase().contains(
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
                              _buildStudentForm(controller: controller),
                        ),
                        suffix: const Icon(Icons.add),
                        child: const Text('Add Student'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Students list
                  Expanded(child: _buildStudentsList(filteredStudents)),
                ],
              ),
            ),
          );
        } else {
          return const FScaffold(
            child: Center(child: Text('Failed to load students')),
          );
        }
      },
    );
  }

  Widget _buildStudentsList(List<Student> students) {
    if (students.isEmpty) {
      return const Center(child: Text('No students found'));
    }

    return FItemGroup.builder(
      itemBuilder: (context, index) {
        final student = students[index];
        return FItem(
          prefix: FAvatar.raw(child: Text(student.name[0].toUpperCase())),
          title: Text(student.name),
          subtitle: Text(student.gender.displayName),
          suffix: Row(
            mainAxisSize: .min,
            spacing: 8,
            children: [
              FSwitch(
                value: student.isActive,
                onChange: (value) {
                  context.read<StudentBloc>().add(
                    UpdateStudent(
                      student.id,
                      student.copyWith(isActive: value),
                    ),
                  );
                },
              ),
              FButton(
                child: Icon(FIcons.eye),
                onPress: () => _showStudentDetails(student),
              ),
              FButton(
                child: Icon(FIcons.pencil),
                onPress: () => showFPersistentSheet(
                  context: context,
                  style: const .delta(flingVelocity: 700),
                  side: .rtl,
                  builder: (context, controller) => _buildStudentForm(
                    controller: controller,
                    student: student,
                  ),
                ),
              ),
              FButton(
                child: Icon(Icons.delete),
                onPress: () => _deleteStudent(student),
              ),
            ],
          ),
        );
      },
      count: students.length,
    );
  }

  Widget _buildStudentForm({
    Student? student,
    required FPersistentSheetController controller,
  }) {
    final isEditing = student != null;
    final formKey = GlobalKey<FormState>();
    String name = isEditing ? student.name : '';
    GenderEnum gender = isEditing ? student.gender : GenderEnum.male;
    bool isActive = isEditing ? student.isActive : true;

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
                isEditing ? 'Edit Student' : 'Add New Student',
                style: context.theme.typography.xl,
              ),
              FTextFormField(
                control: .managed(initial: TextEditingValue(text: name)),
                hint: 'Name',
                autovalidateMode: .onUserInteraction,
                validator: (value) =>
                    value!.trim().isEmpty ? 'Name is required' : null,
                onSaved: (newValue) => name = newValue!,
              ),
              FSelect<GenderEnum>.rich(
                control: .managed(initial: gender),
                hint: 'Select gender',
                format: (g) => g.displayName,
                children: GenderEnum.values
                    .map(
                      (g) => FSelectItem.item(
                        title: Text(g.displayName),
                        value: g,
                      ),
                    )
                    .toList(),
                validator: (value) => value == null ? 'Select gender' : null,
                onSaved: (newValue) => gender = newValue!,
              ),
              FSelect<bool>.rich(
                control: .managed(initial: isActive),
                hint: 'Select status',
                format: (s) => s ? 'Active' : 'Inactive',
                children: [
                  FSelectItem.item(title: const Text('Active'), value: true),
                  FSelectItem.item(title: const Text('Inactive'), value: false),
                ],
                validator: (value) => value == null ? 'Select status' : null,
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

                        final updatedStudent = isEditing
                            ? student.copyWith(
                                name: name.trim(),
                                gender: gender,
                                isActive: isActive,
                              )
                            : Student(
                                id: '',
                                name: name.trim(),
                                gender: gender,
                                isActive: isActive,
                              );

                        if (isEditing) {
                          context.read<StudentBloc>().add(
                            UpdateStudent(updatedStudent.id, updatedStudent),
                          );
                        } else {
                          context.read<StudentBloc>().add(
                            CreateStudent(updatedStudent),
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

  void _deleteStudent(Student student) {
    showFDialog(
      context: context,
      builder: (context, style, animation) => FDialog(
        title: const Text('Delete Student'),
        body: Text('Are you sure you want to delete "${student.name}"?'),
        actions: [
          FButton(
            onPress: () => context.pop(),
            variant: .outline,
            child: const Text('Cancel'),
          ),
          FButton(
            onPress: () {
              context.read<StudentBloc>().add(DeleteStudent(student.id));
              context.pop();
            },
            variant: .destructive,
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showStudentDetails(Student student) {
    showFDialog(
      context: context,
      builder: (context, style, animation) => FDialog(
        title: Text('Detail Student'),
        body: FItemGroup(
          style: const .delta(spacing: 4),
          intrinsicWidth: null,
          divider: .full,
          children: [
            .item(title: const Text('Name'), details: Text(student.name)),
            .item(
              title: const Text('Gender'),
              details: Text(student.gender.displayName),
            ),
            .item(
              title: const Text('Status'),
              details: Text(student.isActive ? 'Active' : 'Inactive'),
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

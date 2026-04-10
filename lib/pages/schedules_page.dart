import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../blocs/schedule_bloc.dart';
import '../blocs/course_bloc.dart';
import '../blocs/tutor_bloc.dart';
import '../blocs/student_bloc.dart';
import '../models/schedule.dart';
import '../models/course.dart';
import '../models/tutor.dart';
import '../models/student.dart';

class SchedulesPage extends StatefulWidget {
  const SchedulesPage({super.key});

  @override
  State<SchedulesPage> createState() => _SchedulesPageState();
}

class _SchedulesPageState extends State<SchedulesPage> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<ScheduleBloc>().add(LoadSchedules());
    context.read<CourseBloc>().add(LoadCourses());
    context.read<TutorBloc>().add(LoadTutors());
    context.read<StudentBloc>().add(LoadStudents());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ScheduleBloc, ScheduleState>(
          listener: (context, state) {
            if (state is ScheduleError) {
              showFToast(
                context: context,
                variant: .destructive,
                icon: Icon(FIcons.circleX),
                title: Text('Error'),
                description: Text(state.message),
              );
            }
          },
        ),
        BlocListener<CourseBloc, CourseState>(
          listener: (context, state) {
            if (state is CourseError) {
              showFToast(
                context: context,
                variant: .destructive,
                icon: Icon(FIcons.circleX),
                title: Text('Course Error'),
                description: Text(state.message),
              );
            }
          },
        ),
        BlocListener<TutorBloc, TutorState>(
          listener: (context, state) {
            if (state is TutorError) {
              showFToast(
                context: context,
                variant: .destructive,
                icon: Icon(FIcons.circleX),
                title: Text('Tutor Error'),
                description: Text(state.message),
              );
            }
          },
        ),
        BlocListener<StudentBloc, StudentState>(
          listener: (context, state) {
            if (state is StudentError) {
              showFToast(
                context: context,
                variant: .destructive,
                icon: Icon(FIcons.circleX),
                title: Text('Student Error'),
                description: Text(state.message),
              );
            }
          },
        ),
      ],
      child: BlocConsumer<ScheduleBloc, ScheduleState>(
        listener: (context, state) {
          // Schedule-specific listener if needed
        },
        builder: (context, state) {
          if (state is ScheduleLoading) {
            return const Center(child: FCircularProgress());
          } else if (state is SchedulesLoaded) {
            final filteredSchedules = _filterSchedules(state.schedules);
            return FScaffold(
              child: Padding(
                padding: const .all(16.0),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    // Header with search and add button
                    Row(
                      children: [
                        Expanded(
                          child: FTextField(
                            prefixBuilder: (context, style, variants) =>
                                Padding(
                                  padding: const .only(left: 16.0, right: 8.0),
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
                                _buildScheduleForm(controller: controller),
                          ),
                          suffix: const Icon(Icons.add),
                          child: const Text('Add Schedule'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Schedules list
                    Expanded(child: _buildSchedulesList(filteredSchedules)),
                  ],
                ),
              ),
            );
          } else {
            return const FScaffold(
              child: Center(child: Text('Failed to load schedules')),
            );
          }
        },
      ),
    );
  }

  List<Schedule> _filterSchedules(List<Schedule> schedules) {
    return schedules.where((schedule) {
      return [
        schedule.courseObject?.name.toLowerCase().contains(
              _searchQuery.toLowerCase(),
            ) ??
            false,
        schedule.tutorObject?.name.toLowerCase().contains(
              _searchQuery.toLowerCase(),
            ) ??
            false,
        schedule.studentObjects.any(
          (student) =>
              student.name.toLowerCase().contains(_searchQuery.toLowerCase()),
        ),
      ].any((element) => element);
    }).toList();
  }

  Widget _buildSchedulesList(List<Schedule> schedules) {
    if (schedules.isEmpty) {
      return const Center(child: Text('No schedules found'));
    }

    return FItemGroup.builder(
      itemBuilder: (context, index) {
        final schedule = schedules[index];
        return FItem(
          prefix: FAvatar.raw(
            child: Text(
              schedule.id.isNotEmpty ? schedule.id[0].toUpperCase() : 'S',
            ),
          ),
          title: Text('Schedule ${schedule.courseObject?.name}'),
          subtitle: Text(
            '${_formatDate(schedule.date)} ${_formatTime(schedule.startTime)} - ${_formatTime(schedule.endTime)}',
          ),
          suffix: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              FSwitch(
                value: schedule.isActive,
                onChange: (value) {
                  context.read<ScheduleBloc>().add(
                    UpdateSchedule(
                      schedule.id,
                      schedule.copyWith(isActive: value),
                    ),
                  );
                },
              ),
              FButton(
                child: Icon(FIcons.eye),
                onPress: () => _showScheduleDetails(schedule),
              ),
              FButton(
                child: Icon(FIcons.pencil),
                onPress: () => showFPersistentSheet(
                  context: context,
                  style: const .delta(flingVelocity: 700),
                  side: .rtl,
                  builder: (context, controller) => _buildScheduleForm(
                    controller: controller,
                    schedule: schedule,
                  ),
                ),
              ),
              FButton(
                child: Icon(FIcons.trash),
                onPress: () => _deleteSchedule(schedule),
              ),
            ],
          ),
        );
      },
      count: schedules.length,
      divider: .full,
    );
  }

  Widget _buildScheduleForm({
    Schedule? schedule,
    required FPersistentSheetController controller,
  }) {
    final isEditing = schedule != null;
    final formKey = GlobalKey<FormState>();
    String courseId = isEditing ? schedule.course : '';
    String tutorId = isEditing ? schedule.tutor : '';
    List<String> studentIds = isEditing ? List.from(schedule.students) : [];
    DateTime date = isEditing && schedule.date.isNotEmpty
        ? DateTime.tryParse(schedule.date) ?? DateTime.now()
        : DateTime.now();
    DateTime startTime = isEditing && schedule.startTime.isNotEmpty
        ? DateTime.tryParse(schedule.startTime) ?? DateTime.now()
        : DateTime.now();
    DateTime endTime = isEditing && schedule.endTime.isNotEmpty
        ? DateTime.tryParse(schedule.endTime) ?? DateTime.now()
        : DateTime.now();
    bool isActive = isEditing ? schedule.isActive : true;

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
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 16,
            children: [
              Text(
                isEditing ? 'Edit Schedule' : 'Add New Schedule',
                style: context.theme.typography.xl,
              ),
              // Course Selection
              BlocBuilder<CourseBloc, CourseState>(
                builder: (context, courseState) {
                  if (courseState is CoursesLoaded) {
                    final activeCourses = courseState.courses
                        .where((c) => c.isActive)
                        .toList();
                    Course? selectedCourse;
                    if (courseId.isNotEmpty) {
                      try {
                        selectedCourse = activeCourses.firstWhere(
                          (c) => c.id == courseId,
                        );
                      } catch (e) {
                        selectedCourse = null;
                      }
                    }

                    return FSelect<Course>.rich(
                      control: .managed(initial: selectedCourse),
                      hint: 'Select Course',
                      format: (c) => c.name,
                      children: activeCourses
                          .map(
                            (course) => FSelectItem.item(
                              title: Text(course.name),
                              value: course,
                            ),
                          )
                          .toList(),
                      validator: (value) =>
                          value == null ? 'Course is required' : null,
                      onSaved: (newValue) => courseId = newValue!.id,
                    );
                  }
                  return FSelect<Course>.rich(
                    control: .managed(),
                    hint: 'Loading courses...',
                    format: (c) => c.name,
                    children: [],
                  );
                },
              ),
              // Tutor Selection
              BlocBuilder<TutorBloc, TutorState>(
                builder: (context, tutorState) {
                  if (tutorState is TutorsLoaded) {
                    final activeTutors = tutorState.tutors
                        .where((t) => t.isActive)
                        .toList();
                    Tutor? selectedTutor;
                    if (tutorId.isNotEmpty) {
                      try {
                        selectedTutor = activeTutors.firstWhere(
                          (t) => t.id == tutorId,
                        );
                      } catch (e) {
                        selectedTutor = null;
                      }
                    }

                    return FSelect<Tutor>.rich(
                      control: .managed(initial: selectedTutor),
                      hint: 'Select Tutor',
                      format: (t) => t.name,
                      children: activeTutors
                          .map(
                            (tutor) => FSelectItem.item(
                              title: Text(tutor.name),
                              value: tutor,
                            ),
                          )
                          .toList(),
                      validator: (value) =>
                          value == null ? 'Tutor is required' : null,
                      onSaved: (newValue) => tutorId = newValue!.id,
                    );
                  }
                  return FSelect<Tutor>.rich(
                    control: .managed(),
                    hint: 'Loading tutors...',
                    format: (t) => t.name,
                    children: [],
                  );
                },
              ),
              // Students Multi-Selection
              BlocBuilder<StudentBloc, StudentState>(
                builder: (context, studentState) {
                  if (studentState is StudentsLoaded) {
                    final activeStudents = studentState.students
                        .where((s) => s.isActive)
                        .toList();
                    final selectedStudents = activeStudents
                        .where((s) => studentIds.contains(s.id))
                        .toList();

                    return FMultiSelect<Student>.rich(
                      control: .managed(initial: selectedStudents.toSet()),
                      hint: const Text('Select Students'),
                      format: (Student student) => Text(student.name),
                      children: activeStudents
                          .map(
                            (student) => FSelectItem.item(
                              title: Text(student.name),
                              value: student,
                            ),
                          )
                          .toList(),
                      validator: (value) => (value.isEmpty)
                          ? 'At least one student is required'
                          : null,
                      onSaved: (newValue) =>
                          studentIds = newValue.map((s) => s.id).toList(),
                    );
                  }
                  return FMultiSelect<Student>.rich(
                    control: .managed(),
                    hint: const Text('Loading students...'),
                    format: (Student student) => Text(student.name),
                    children: [],
                  );
                },
              ),
              FDateField.calendar(
                control: .managed(initial: date),
                hint: 'Select Date',
                autovalidateMode: .onUserInteraction,
              ),
              FTimeField.picker(
                control: .managed(initial: FTime.fromDateTime(startTime)),
                hint: 'Select Start Time',
                autovalidateMode: .onUserInteraction,
              ),
              FTimeField.picker(
                control: .managed(initial: FTime.fromDateTime(endTime)),
                hint: 'Select End Time',
                autovalidateMode: AutovalidateMode.onUserInteraction,
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

                        // Combine date and time into ISO strings
                        final dateString = DateFormat(
                          'yyyy-MM-dd',
                        ).format(date);
                        final startTimeString = DateFormat(
                          "yyyy-MM-ddTHH:mm:ss",
                        ).format(startTime);
                        final endTimeString = DateFormat(
                          "yyyy-MM-ddTHH:mm:ss",
                        ).format(endTime);

                        final updatedSchedule = isEditing
                            ? schedule.copyWith(
                                course: courseId,
                                tutor: tutorId,
                                students: studentIds,
                                date: dateString,
                                startTime: startTimeString,
                                endTime: endTimeString,
                                isActive: isActive,
                              )
                            : Schedule(
                                id: '',
                                course: courseId,
                                tutor: tutorId,
                                students: studentIds,
                                date: dateString,
                                startTime: startTimeString,
                                endTime: endTimeString,
                                isActive: isActive,
                              );

                        if (isEditing) {
                          context.read<ScheduleBloc>().add(
                            UpdateSchedule(updatedSchedule.id, updatedSchedule),
                          );
                        } else {
                          context.read<ScheduleBloc>().add(
                            CreateSchedule(updatedSchedule),
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

  void _deleteSchedule(Schedule schedule) {
    showFDialog(
      context: context,
      builder: (context, style, animation) => FDialog(
        title: const Text('Delete Schedule'),
        body: Text('Are you sure you want to delete this schedule?'),
        actions: [
          FButton(
            onPress: () => context.pop(),
            variant: .outline,
            child: const Text('Cancel'),
          ),
          FButton(
            onPress: () {
              context.read<ScheduleBloc>().add(DeleteSchedule(schedule.id));
              context.pop();
            },
            variant: .destructive,
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showScheduleDetails(Schedule schedule) {
    showFDialog(
      context: context,
      builder: (context, style, animation) => FDialog(
        title: Text('Schedule Details'),
        body: FItemGroup(
          style: const .delta(spacing: 4),
          intrinsicWidth: null,
          divider: .full,
          children: [
            .item(
              title: const Text('Course'),
              details: Text(schedule.courseObject?.name ?? ''),
            ),
            .item(
              title: const Text('Tutor'),
              details: Text(schedule.tutorObject?.name ?? ''),
            ),
            .item(
              title: const Text('Students'),
              details: Text(
                schedule.studentObjects.isEmpty
                    ? 'No students'
                    : schedule.studentObjects.map((e) => e.name).join(', '),
              ),
            ),
            .item(
              title: const Text('Date'),
              details: Text(_formatDate(schedule.date)),
            ),
            .item(
              title: const Text('Start Time'),
              details: Text(_formatTime(schedule.startTime)),
            ),
            .item(
              title: const Text('End Time'),
              details: Text(_formatTime(schedule.endTime)),
            ),
            .item(
              title: const Text('Status'),
              details: Text(schedule.isActive ? 'Active' : 'Inactive'),
            ),
          ],
        ),
        actions: [
          FButton(onPress: () => context.pop(), child: const Text('Close')),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final dateTime = DateTime.parse(dateString);
      return DateFormat('dd MMMM yyyy').format(dateTime);
    } catch (e) {
      return dateString;
    }
  }

  String _formatTime(String timeString) {
    try {
      final dateTime = DateTime.parse(timeString);
      return DateFormat('hh:mm a').format(dateTime);
    } catch (e) {
      return timeString;
    }
  }
}

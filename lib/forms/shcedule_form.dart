import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:lesgo_flutter/blocs/course_bloc.dart';
import 'package:lesgo_flutter/blocs/schedule_bloc.dart';
import 'package:lesgo_flutter/blocs/student_bloc.dart';
import 'package:lesgo_flutter/blocs/tutor_bloc.dart';
import 'package:lesgo_flutter/models/course/course.dart';
import 'package:lesgo_flutter/models/schedule/schedule.dart';
import 'package:lesgo_flutter/models/student/student.dart';
import 'package:lesgo_flutter/models/tutor/tutor.dart';

class ShceduleForm extends HookWidget {
  const ShceduleForm({super.key, this.schedule, required this.controller});

  final Schedule? schedule;
  final FPersistentSheetController controller;

  @override
  Widget build(BuildContext context) {
    final isEditing = schedule != null;
    final formKey = GlobalKey<FormState>();
    String courseId = isEditing ? schedule!.courseId : '';
    String tutorId = isEditing ? schedule!.tutorId : '';
    List<String> studentIds = isEditing ? List.from(schedule!.students) : [];
    DateTime date = isEditing ? schedule!.date : DateTime.now();
    DateTime startTime = isEditing ? schedule!.startTime : DateTime.now();
    DateTime endTime = isEditing ? schedule!.endTime : DateTime.now();
    bool isActive = isEditing ? schedule!.isActive : true;

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
                        .where((t) => (t).isActive)
                        .toList();
                    Tutor? selectedTutor;
                    if (tutorId.isNotEmpty) {
                      try {
                        selectedTutor = activeTutors.firstWhere(
                          (t) => (t).id == tutorId,
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
                      onSaved: (newValue) => tutorId = newValue?.id ?? '',
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
                        .where((s) => (s).isActive)
                        .toList();
                    final selectedStudents = activeStudents
                        .where(
                          (s) => (s).id != null && studentIds.contains((s).id),
                        )
                        .toList();

                    return FMultiSelect<Student>.rich(
                      control: .managed(initial: selectedStudents.toSet()),
                      hint: const Text('Select Students'),
                      format: (Student student) => Text(student.name),
                      children: activeStudents
                          .map(
                            (student) => FSelectItem.item(
                              title: Text((student).name),
                              value: student,
                            ),
                          )
                          .toList(),
                      validator: (value) => (value.isEmpty)
                          ? 'At least one student is required'
                          : null,
                      onSaved: (newValue) =>
                          studentIds = newValue.map((s) => s.id ?? '').toList(),
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

                        final updatedSchedule = isEditing
                            ? schedule!.copyWith(
                                courseId: courseId,
                                tutorId: tutorId,
                                studentIds: studentIds,
                                date: date,
                                startTime: startTime,
                                endTime: endTime,
                                isActive: isActive,
                              )
                            : Schedule.create(
                                courseId: courseId,
                                tutorId: tutorId,
                                roomId: '',
                                studentIds: studentIds,
                                date: date,
                                startTime: startTime,
                                endTime: endTime,
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
}

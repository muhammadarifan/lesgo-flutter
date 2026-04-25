import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lesgo_flutter/models/schedule/schedule.dart';
import '../blocs/schedule_bloc.dart';
import '../blocs/course_bloc.dart';
import '../blocs/tutor_bloc.dart';
import '../blocs/student_bloc.dart';

class SchedulesPage extends StatefulHookWidget {
  const SchedulesPage({super.key});

  @override
  State<SchedulesPage> createState() => _SchedulesPageState();
}

class _SchedulesPageState extends State<SchedulesPage> {
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
      child: FScaffold(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: FLineCalendar(),
            ),
            Expanded(child: _buildScheduleList()),
          ],
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
              details: Text(schedule.course?.name ?? ''),
            ),
            .item(
              title: const Text('Tutor'),
              details: Text(schedule.tutor?.name ?? ''),
            ),
            .item(
              title: const Text('Students'),
              details: Text(
                schedule.students.isEmpty
                    ? 'No students'
                    : schedule.students.map((e) => e.name).join(', '),
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

  String _formatDate(DateTime dateTime) {
    try {
      return DateFormat('dd MMMM yyyy').format(dateTime);
    } catch (e) {
      return dateTime.toString();
    }
  }

  String _formatTime(DateTime dateTime) {
    try {
      return DateFormat('hh:mm a').format(dateTime);
    } catch (e) {
      return dateTime.toString();
    }
  }

  Widget _buildScheduleList() {
    return FCard(
      child: BlocBuilder<TutorBloc, TutorState>(
        builder: (context, state) {
          if (state is TutorsLoaded) {
            return Expanded(
              child: ListView.separated(
                itemCount: state.tutors.length,
                itemBuilder: (context, index) => Text(state.tutors[index].name),
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              ),
            );
          }
          return const Center(child: FCircularProgress());
        },
      ),
    );
  }
}

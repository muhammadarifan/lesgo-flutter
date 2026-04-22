import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lesgo_flutter/models/schedule/schedule.dart';
import '../blocs/schedule_bloc.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    context.read<ScheduleBloc>().add(LoadSchedules());
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
      ],
      child: BlocBuilder<ScheduleBloc, ScheduleState>(
        builder: (context, state) {
          if (state is ScheduleLoading) {
            return const Center(child: FCircularProgress());
          } else if (state is SchedulesLoaded) {
            final schedulesForDate = _getSchedulesForDate(
              state.schedules,
              _selectedDate,
            );
            return FScaffold(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Calendar
                    FCalendar(
                      control: FCalendarControl.managedDate(
                        initial: _selectedDate,
                      ),
                      onPress: (date) {
                        setState(() {
                          _selectedDate = date;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    // Schedules for selected date
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Schedules for ${_formatDate(_selectedDate)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: _buildSchedulesList(schedulesForDate),
                          ),
                        ],
                      ),
                    ),
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

  List<Schedule> _getSchedulesForDate(List<Schedule> schedules, DateTime date) {
    return schedules.where((schedule) {
      return schedule.date.year == date.year &&
          schedule.date.month == date.month &&
          schedule.date.day == date.day;
    }).toList()..sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  Widget _buildSchedulesList(List<Schedule> schedules) {
    if (schedules.isEmpty) {
      return const Center(child: Text('No schedules for this date'));
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
          title: Text(schedule.course?.name ?? 'Unknown Course'),
          subtitle: Text(
            '${_formatTime(schedule.startTime)} - ${_formatTime(schedule.endTime)}',
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
            ],
          ),
        );
      },
      count: schedules.length,
      divider: .full,
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
}

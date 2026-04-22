import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesgo_flutter/models/schedule/schedule.dart';
import 'package:lesgo_flutter/repositories/schedule_repository.dart';

// Events
abstract class ScheduleEvent {}

class LoadSchedules extends ScheduleEvent {}

class LoadScheduleCount extends ScheduleEvent {}

class LoadSchedule extends ScheduleEvent {
  final String id;
  LoadSchedule(this.id);
}

class CreateSchedule extends ScheduleEvent {
  final Schedule schedule;
  CreateSchedule(this.schedule);
}

class UpdateSchedule extends ScheduleEvent {
  final String id;
  final Schedule schedule;
  UpdateSchedule(this.id, this.schedule);
}

class DeleteSchedule extends ScheduleEvent {
  final String id;
  DeleteSchedule(this.id);
}

// States
abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class SchedulesLoaded extends ScheduleState {
  final List<Schedule> schedules;
  SchedulesLoaded(this.schedules);
}

class ScheduleLoaded extends ScheduleState {
  final Schedule schedule;
  ScheduleLoaded(this.schedule);
}

class ScheduleCountLoaded extends ScheduleState {
  final int count;
  ScheduleCountLoaded(this.count);
}

class ScheduleError extends ScheduleState {
  final String message;
  ScheduleError(this.message);
}

// Bloc
class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository repository;

  ScheduleBloc(this.repository) : super(ScheduleInitial()) {
    on<LoadSchedules>(_onLoadSchedules);
    on<LoadScheduleCount>(_onLoadScheduleCount);
    on<LoadSchedule>(_onLoadSchedule);
    on<CreateSchedule>(_onCreateSchedule);
    on<UpdateSchedule>(_onUpdateSchedule);
    on<DeleteSchedule>(_onDeleteSchedule);
  }

  Future<void> _onLoadSchedules(
    LoadSchedules event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoading());
    try {
      final schedules = await repository.getAll();
      emit(SchedulesLoaded(schedules));
    } catch (e) {
      emit(ScheduleError(e.toString()));
    }
  }

  Future<void> _onLoadScheduleCount(
    LoadScheduleCount event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoading());
    try {
      final count = await repository.getCount();
      emit(ScheduleCountLoaded(count));
    } catch (e) {
      emit(ScheduleError(e.toString()));
    }
  }

  Future<void> _onLoadSchedule(
    LoadSchedule event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoading());
    try {
      final schedule = await repository.getById(event.id);
      emit(ScheduleLoaded(schedule));
    } catch (e) {
      emit(ScheduleError(e.toString()));
    }
  }

  Future<void> _onCreateSchedule(
    CreateSchedule event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoading());
    try {
      final schedule = await repository.create(event.schedule);
      emit(ScheduleLoaded(schedule));
      add(LoadSchedules());
    } catch (e) {
      emit(ScheduleError(e.toString()));
    }
  }

  Future<void> _onUpdateSchedule(
    UpdateSchedule event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoading());
    try {
      final schedule = await repository.update(event.id, event.schedule);
      emit(ScheduleLoaded(schedule));
      add(LoadSchedules());
    } catch (e) {
      emit(ScheduleError(e.toString()));
    }
  }

  Future<void> _onDeleteSchedule(
    DeleteSchedule event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoading());
    try {
      await repository.delete(event.id);
      add(LoadSchedules());
    } catch (e) {
      emit(ScheduleError(e.toString()));
    }
  }
}

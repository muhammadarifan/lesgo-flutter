import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesgo_flutter/models/tutor.dart';
import 'package:lesgo_flutter/repositories/tutor_repository.dart';

// Events
abstract class TutorEvent {}

class LoadTutors extends TutorEvent {}

class LoadTutor extends TutorEvent {
  final String id;
  LoadTutor(this.id);
}

class CreateTutor extends TutorEvent {
  final Tutor tutor;
  CreateTutor(this.tutor);
}

class UpdateTutor extends TutorEvent {
  final String id;
  final Tutor tutor;
  UpdateTutor(this.id, this.tutor);
}

class DeleteTutor extends TutorEvent {
  final String id;
  DeleteTutor(this.id);
}

// States
abstract class TutorState {}

class TutorInitial extends TutorState {}

class TutorLoading extends TutorState {}

class TutorsLoaded extends TutorState {
  final List<Tutor> tutors;
  TutorsLoaded(this.tutors);
}

class TutorLoaded extends TutorState {
  final Tutor tutor;
  TutorLoaded(this.tutor);
}

class TutorError extends TutorState {
  final String message;
  TutorError(this.message);
}

// Bloc
class TutorBloc extends Bloc<TutorEvent, TutorState> {
  final TutorRepository repository;

  TutorBloc(this.repository) : super(TutorInitial()) {
    on<LoadTutors>(_onLoadTutors);
    on<LoadTutor>(_onLoadTutor);
    on<CreateTutor>(_onCreateTutor);
    on<UpdateTutor>(_onUpdateTutor);
    on<DeleteTutor>(_onDeleteTutor);
  }

  Future<void> _onLoadTutors(LoadTutors event, Emitter<TutorState> emit) async {
    emit(TutorLoading());
    try {
      final tutors = await repository.getAll();
      emit(TutorsLoaded(tutors));
    } catch (e) {
      emit(TutorError(e.toString()));
    }
  }

  Future<void> _onLoadTutor(LoadTutor event, Emitter<TutorState> emit) async {
    emit(TutorLoading());
    try {
      final tutor = await repository.getById(event.id);
      emit(TutorLoaded(tutor));
    } catch (e) {
      emit(TutorError(e.toString()));
    }
  }

  Future<void> _onCreateTutor(
    CreateTutor event,
    Emitter<TutorState> emit,
  ) async {
    emit(TutorLoading());
    try {
      final tutor = await repository.create(event.tutor);
      emit(TutorLoaded(tutor));
      add(LoadTutors());
    } catch (e) {
      emit(TutorError(e.toString()));
    }
  }

  Future<void> _onUpdateTutor(
    UpdateTutor event,
    Emitter<TutorState> emit,
  ) async {
    emit(TutorLoading());
    try {
      final tutor = await repository.update(event.id, event.tutor);
      emit(TutorLoaded(tutor));
      add(LoadTutors());
    } catch (e) {
      emit(TutorError(e.toString()));
    }
  }

  Future<void> _onDeleteTutor(
    DeleteTutor event,
    Emitter<TutorState> emit,
  ) async {
    emit(TutorLoading());
    try {
      await repository.delete(event.id);
      add(LoadTutors());
    } catch (e) {
      emit(TutorError(e.toString()));
    }
  }
}

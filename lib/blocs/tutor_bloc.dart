import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesgo_flutter/models/tutor.dart';
import 'package:lesgo_flutter/repositories/tutor_repository.dart';

// Events
abstract class TutorEvent {}

class LoadTutors extends TutorEvent {}

class LoadTutorCount extends TutorEvent {}

class PaginateTutors extends TutorEvent {
  final int page;
  final int limit;
  final String? search;

  PaginateTutors({this.page = 1, this.limit = 5, this.search});
}

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
  final int totalItems;
  final int totalPages;
  final int currentPage;
  final int perPage;
  final bool hasMore;

  TutorsLoaded(
    this.tutors, {
    required this.totalItems,
    required this.totalPages,
    required this.currentPage,
    required this.perPage,
    required this.hasMore,
  });

  TutorsLoaded.initial(this.tutors)
    : totalItems = tutors.length,
      totalPages = 1,
      currentPage = 1,
      perPage = tutors.length,
      hasMore = false;
}

class TutorLoaded extends TutorState {
  final Tutor tutor;
  TutorLoaded(this.tutor);
}

class TutorCountLoaded extends TutorState {
  final int count;
  TutorCountLoaded(this.count);
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
    on<LoadTutorCount>(_onLoadTutorCount);
    on<PaginateTutors>(_onPaginateTutors);
    on<LoadTutor>(_onLoadTutor);
    on<CreateTutor>(_onCreateTutor);
    on<UpdateTutor>(_onUpdateTutor);
    on<DeleteTutor>(_onDeleteTutor);
  }

  Future<void> _onLoadTutors(LoadTutors event, Emitter<TutorState> emit) async {
    emit(TutorLoading());
    try {
      final result = await repository.paginate();
      emit(
        TutorsLoaded(
          result['items'] as List<Tutor>,
          totalItems: result['totalItems'] as int,
          totalPages: result['totalPages'] as int,
          currentPage: result['page'] as int,
          perPage: result['perPage'] as int,
          hasMore: (result['page'] as int) < (result['totalPages'] as int),
        ),
      );
    } catch (e) {
      emit(TutorError(e.toString()));
    }
  }

  Future<void> _onPaginateTutors(
    PaginateTutors event,
    Emitter<TutorState> emit,
  ) async {
    emit(TutorLoading());
    try {
      final result = await repository.paginate(
        page: event.page,
        limit: event.limit,
        search: event.search,
      );
      emit(
        TutorsLoaded(
          result['items'] as List<Tutor>,
          totalItems: result['totalItems'] as int,
          totalPages: result['totalPages'] as int,
          currentPage: result['page'] as int,
          perPage: result['perPage'] as int,
          hasMore: (result['page'] as int) < (result['totalPages'] as int),
        ),
      );
    } catch (e) {
      emit(TutorError(e.toString()));
    }
  }

  Future<void> _onLoadTutorCount(
    LoadTutorCount event,
    Emitter<TutorState> emit,
  ) async {
    emit(TutorLoading());
    try {
      final count = await repository.getCount();
      emit(TutorCountLoaded(count));
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

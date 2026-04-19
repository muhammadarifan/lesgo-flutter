import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesgo_flutter/models/course_place.dart';
import 'package:lesgo_flutter/repositories/course_place_repository.dart';

// Events
abstract class CoursePlaceEvent {}

class LoadCoursePlace extends CoursePlaceEvent {
  final String id;
  LoadCoursePlace(this.id);
}

class CreateCoursePlace extends CoursePlaceEvent {
  final CoursePlace coursePlace;
  CreateCoursePlace(this.coursePlace);
}

// States
abstract class CoursePlaceState {}

class CoursePlaceInitial extends CoursePlaceState {}

class CoursePlaceLoading extends CoursePlaceState {}

class CoursePlaceLoaded extends CoursePlaceState {
  final CoursePlace coursePlace;
  CoursePlaceLoaded(this.coursePlace);
}

class CoursePlaceError extends CoursePlaceState {
  final String message;
  CoursePlaceError(this.message);
}

// Bloc
class CoursePlaceBloc extends Bloc<CoursePlaceEvent, CoursePlaceState> {
  final CoursePlaceRepository repository;

  CoursePlaceBloc(this.repository) : super(CoursePlaceInitial()) {
    on<LoadCoursePlace>(_onLoadCoursePlace);
    on<CreateCoursePlace>(_onCreateCoursePlace);
  }

  Future<void> _onLoadCoursePlace(
    LoadCoursePlace event,
    Emitter<CoursePlaceState> emit,
  ) async {
    emit(CoursePlaceLoading());
    try {
      final coursePlace = await repository.getById(event.id);
      emit(CoursePlaceLoaded(coursePlace));
    } catch (e) {
      emit(CoursePlaceError(e.toString()));
    }
  }

  Future<void> _onCreateCoursePlace(
    CreateCoursePlace event,
    Emitter<CoursePlaceState> emit,
  ) async {
    emit(CoursePlaceLoading());
    try {
      final coursePlace = await repository.create(event.coursePlace);
      emit(CoursePlaceLoaded(coursePlace));
    } catch (e) {
      emit(CoursePlaceError(e.toString()));
    }
  }
}

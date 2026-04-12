import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesgo_flutter/models/course.dart';
import 'package:lesgo_flutter/repositories/course_repository.dart';

// Events
abstract class CourseEvent {}

class LoadCourses extends CourseEvent {}

class LoadCourseCount extends CourseEvent {}

class LoadCourse extends CourseEvent {
  final String id;
  LoadCourse(this.id);
}

class CreateCourse extends CourseEvent {
  final Course course;
  CreateCourse(this.course);
}

class UpdateCourse extends CourseEvent {
  final String id;
  final Course course;
  UpdateCourse(this.id, this.course);
}

class DeleteCourse extends CourseEvent {
  final String id;
  DeleteCourse(this.id);
}

// States
abstract class CourseState {}

class CourseInitial extends CourseState {}

class CourseLoading extends CourseState {}

class CoursesLoaded extends CourseState {
  final List<Course> courses;
  CoursesLoaded(this.courses);
}

class CourseLoaded extends CourseState {
  final Course course;
  CourseLoaded(this.course);
}

class CourseCountLoaded extends CourseState {
  final int count;
  CourseCountLoaded(this.count);
}

class CourseError extends CourseState {
  final String message;
  CourseError(this.message);
}

// Bloc
class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final CourseRepository repository;

  CourseBloc(this.repository) : super(CourseInitial()) {
    on<LoadCourses>(_onLoadCourses);
    on<LoadCourseCount>(_onLoadCourseCount);
    on<LoadCourse>(_onLoadCourse);
    on<CreateCourse>(_onCreateCourse);
    on<UpdateCourse>(_onUpdateCourse);
    on<DeleteCourse>(_onDeleteCourse);
  }

  Future<void> _onLoadCourses(
    LoadCourses event,
    Emitter<CourseState> emit,
  ) async {
    emit(CourseLoading());
    try {
      final courses = await repository.getAll();
      emit(CoursesLoaded(courses));
    } catch (e, s) {
      debugPrint('$e\n$s');
      emit(CourseError(e.toString()));
    }
  }

  Future<void> _onLoadCourseCount(
    LoadCourseCount event,
    Emitter<CourseState> emit,
  ) async {
    emit(CourseLoading());
    try {
      final count = await repository.getCount();
      emit(CourseCountLoaded(count));
    } catch (e) {
      emit(CourseError(e.toString()));
    }
  }

  Future<void> _onLoadCourse(
    LoadCourse event,
    Emitter<CourseState> emit,
  ) async {
    emit(CourseLoading());
    try {
      final course = await repository.getById(event.id);
      emit(CourseLoaded(course));
    } catch (e) {
      emit(CourseError(e.toString()));
    }
  }

  Future<void> _onCreateCourse(
    CreateCourse event,
    Emitter<CourseState> emit,
  ) async {
    emit(CourseLoading());
    try {
      final course = await repository.create(event.course);
      emit(CourseLoaded(course));
      add(LoadCourses());
    } catch (e) {
      emit(CourseError(e.toString()));
    }
  }

  Future<void> _onUpdateCourse(
    UpdateCourse event,
    Emitter<CourseState> emit,
  ) async {
    emit(CourseLoading());
    try {
      final course = await repository.update(event.id, event.course);
      emit(CourseLoaded(course));
      add(LoadCourses());
    } catch (e) {
      emit(CourseError(e.toString()));
    }
  }

  Future<void> _onDeleteCourse(
    DeleteCourse event,
    Emitter<CourseState> emit,
  ) async {
    emit(CourseLoading());
    try {
      await repository.delete(event.id);
      add(LoadCourses());
    } catch (e) {
      emit(CourseError(e.toString()));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesgo_flutter/models/course/course.dart';
import 'package:lesgo_flutter/repositories/course_repository.dart';

// Events
abstract class CourseEvent {}

class LoadCourses extends CourseEvent {}

class PaginateCourses extends CourseEvent {
  final int page;
  final int limit;
  final String? search;

  PaginateCourses({this.page = 1, this.limit = 5, this.search});
}

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
  final int totalItems;
  final int totalPages;
  final int currentPage;
  final int perPage;
  final bool hasMore;

  CoursesLoaded(
    this.courses, {
    required this.totalItems,
    required this.totalPages,
    required this.currentPage,
    required this.perPage,
    required this.hasMore,
  });

  CoursesLoaded.initial(this.courses)
    : totalItems = courses.length,
      totalPages = 1,
      currentPage = 1,
      perPage = courses.length,
      hasMore = false;
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
    on<PaginateCourses>(_onPaginateCourses);
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
      final result = await repository.paginate();
      emit(
        CoursesLoaded(
          result['items'] as List<Course>,
          totalItems: result['totalItems'] as int,
          totalPages: result['totalPages'] as int,
          currentPage: result['page'] as int,
          perPage: result['perPage'] as int,
          hasMore: (result['page'] as int) < (result['totalPages'] as int),
        ),
      );
    } catch (e, s) {
      debugPrint('$e\n$s');
      emit(CourseError(e.toString()));
    }
  }

  Future<void> _onPaginateCourses(
    PaginateCourses event,
    Emitter<CourseState> emit,
  ) async {
    emit(CourseLoading());
    try {
      final result = await repository.paginate(
        page: event.page,
        limit: event.limit,
        search: event.search,
      );
      emit(
        CoursesLoaded(
          result['items'] as List<Course>,
          totalItems: result['totalItems'] as int,
          totalPages: result['totalPages'] as int,
          currentPage: result['page'] as int,
          perPage: result['perPage'] as int,
          hasMore: (result['page'] as int) < (result['totalPages'] as int),
        ),
      );
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

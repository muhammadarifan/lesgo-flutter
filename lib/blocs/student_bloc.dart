import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesgo_flutter/models/student.dart';
import 'package:lesgo_flutter/repositories/student_repository.dart';

// Events
abstract class StudentEvent {}

class LoadStudents extends StudentEvent {}

class LoadStudentCount extends StudentEvent {}

class LoadStudent extends StudentEvent {
  final String id;
  LoadStudent(this.id);
}

class CreateStudent extends StudentEvent {
  final Student student;
  CreateStudent(this.student);
}

class UpdateStudent extends StudentEvent {
  final String id;
  final Student student;
  UpdateStudent(this.id, this.student);
}

class DeleteStudent extends StudentEvent {
  final String id;
  DeleteStudent(this.id);
}

// States
abstract class StudentState {}

class StudentInitial extends StudentState {}

class StudentLoading extends StudentState {}

class StudentsLoaded extends StudentState {
  final List<Student> students;
  StudentsLoaded(this.students);
}

class StudentLoaded extends StudentState {
  final Student student;
  StudentLoaded(this.student);
}

class StudentCountLoaded extends StudentState {
  final int count;
  StudentCountLoaded(this.count);
}

class StudentError extends StudentState {
  final String message;
  StudentError(this.message);
}

// Bloc
class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final StudentRepository repository;

  StudentBloc(this.repository) : super(StudentInitial()) {
    on<LoadStudents>(_onLoadStudents);
    on<LoadStudentCount>(_onLoadStudentCount);
    on<LoadStudent>(_onLoadStudent);
    on<CreateStudent>(_onCreateStudent);
    on<UpdateStudent>(_onUpdateStudent);
    on<DeleteStudent>(_onDeleteStudent);
  }

  Future<void> _onLoadStudents(
    LoadStudents event,
    Emitter<StudentState> emit,
  ) async {
    emit(StudentLoading());
    try {
      final students = await repository.getAll();
      emit(StudentsLoaded(students));
    } catch (e) {
      emit(StudentError(e.toString()));
    }
  }

  Future<void> _onLoadStudentCount(
    LoadStudentCount event,
    Emitter<StudentState> emit,
  ) async {
    emit(StudentLoading());
    try {
      final count = await repository.getCount();
      emit(StudentCountLoaded(count));
    } catch (e) {
      emit(StudentError(e.toString()));
    }
  }

  Future<void> _onLoadStudent(
    LoadStudent event,
    Emitter<StudentState> emit,
  ) async {
    emit(StudentLoading());
    try {
      final student = await repository.getById(event.id);
      emit(StudentLoaded(student));
    } catch (e) {
      emit(StudentError(e.toString()));
    }
  }

  Future<void> _onCreateStudent(
    CreateStudent event,
    Emitter<StudentState> emit,
  ) async {
    emit(StudentLoading());
    try {
      final student = await repository.create(event.student);
      emit(StudentLoaded(student));
      add(LoadStudents());
    } catch (e) {
      emit(StudentError(e.toString()));
    }
  }

  Future<void> _onUpdateStudent(
    UpdateStudent event,
    Emitter<StudentState> emit,
  ) async {
    emit(StudentLoading());
    try {
      final student = await repository.update(event.id, event.student);
      emit(StudentLoaded(student));
      add(LoadStudents());
    } catch (e) {
      emit(StudentError(e.toString()));
    }
  }

  Future<void> _onDeleteStudent(
    DeleteStudent event,
    Emitter<StudentState> emit,
  ) async {
    emit(StudentLoading());
    try {
      await repository.delete(event.id);
      add(LoadStudents());
    } catch (e) {
      emit(StudentError(e.toString()));
    }
  }
}

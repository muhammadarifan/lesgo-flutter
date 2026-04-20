import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesgo_flutter/models/room/room.dart';
import 'package:lesgo_flutter/repositories/room_repository.dart';

// Events
abstract class RoomEvent {}

class LoadRooms extends RoomEvent {}

class LoadRoomCount extends RoomEvent {}

class PaginateRooms extends RoomEvent {
  final int page;
  final int limit;
  final String? search;

  PaginateRooms({this.page = 1, this.limit = 5, this.search});
}

class LoadRoom extends RoomEvent {
  final String id;
  LoadRoom(this.id);
}

class CreateRoom extends RoomEvent {
  final Room room;
  CreateRoom(this.room);
}

class UpdateRoom extends RoomEvent {
  final String id;
  final Room room;
  UpdateRoom(this.id, this.room);
}

class DeleteRoom extends RoomEvent {
  final String id;
  DeleteRoom(this.id);
}

// States
abstract class RoomState {}

class RoomInitial extends RoomState {}

class RoomLoading extends RoomState {}

class RoomsLoaded extends RoomState {
  final List<Room> rooms;
  final int totalItems;
  final int totalPages;
  final int currentPage;
  final int perPage;
  final bool hasMore;

  RoomsLoaded(
    this.rooms, {
    required this.totalItems,
    required this.totalPages,
    required this.currentPage,
    required this.perPage,
    required this.hasMore,
  });

  RoomsLoaded.initial(this.rooms)
    : totalItems = rooms.length,
      totalPages = 1,
      currentPage = 1,
      perPage = rooms.length,
      hasMore = false;
}

class RoomLoaded extends RoomState {
  final Room room;
  RoomLoaded(this.room);
}

class RoomCountLoaded extends RoomState {
  final int count;
  RoomCountLoaded(this.count);
}

class RoomError extends RoomState {
  final String message;
  RoomError(this.message);
}

// Bloc
class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final RoomRepository repository;

  RoomBloc(this.repository) : super(RoomInitial()) {
    on<LoadRooms>(_onLoadRooms);
    on<LoadRoomCount>(_onLoadRoomCount);
    on<PaginateRooms>(_onPaginateRooms);
    on<LoadRoom>(_onLoadRoom);
    on<CreateRoom>(_onCreateRoom);
    on<UpdateRoom>(_onUpdateRoom);
    on<DeleteRoom>(_onDeleteRoom);
  }

  Future<void> _onLoadRooms(LoadRooms event, Emitter<RoomState> emit) async {
    emit(RoomLoading());
    try {
      final result = await repository.paginate();
      emit(
        RoomsLoaded(
          result['items'] as List<Room>,
          totalItems: result['totalItems'] as int,
          totalPages: result['totalPages'] as int,
          currentPage: result['page'] as int,
          perPage: result['perPage'] as int,
          hasMore: (result['page'] as int) < (result['totalPages'] as int),
        ),
      );
    } catch (e, s) {
      debugPrint('$e\n$s');
      emit(RoomError(e.toString()));
    }
  }

  Future<void> _onPaginateRooms(
    PaginateRooms event,
    Emitter<RoomState> emit,
  ) async {
    emit(RoomLoading());
    try {
      final result = await repository.paginate(
        page: event.page,
        limit: event.limit,
        search: event.search,
      );
      emit(
        RoomsLoaded(
          result['items'] as List<Room>,
          totalItems: result['totalItems'] as int,
          totalPages: result['totalPages'] as int,
          currentPage: result['page'] as int,
          perPage: result['perPage'] as int,
          hasMore: (result['page'] as int) < (result['totalPages'] as int),
        ),
      );
    } catch (e, s) {
      debugPrint('$e\n$s');
      emit(RoomError(e.toString()));
    }
  }

  Future<void> _onLoadRoomCount(
    LoadRoomCount event,
    Emitter<RoomState> emit,
  ) async {
    emit(RoomLoading());
    try {
      final count = await repository.getCount();
      emit(RoomCountLoaded(count));
    } catch (e) {
      emit(RoomError(e.toString()));
    }
  }

  Future<void> _onLoadRoom(LoadRoom event, Emitter<RoomState> emit) async {
    emit(RoomLoading());
    try {
      final room = await repository.getById(event.id);
      emit(RoomLoaded(room));
    } catch (e) {
      emit(RoomError(e.toString()));
    }
  }

  Future<void> _onCreateRoom(CreateRoom event, Emitter<RoomState> emit) async {
    emit(RoomLoading());
    try {
      final room = await repository.create(event.room);
      emit(RoomLoaded(room));
      add(LoadRooms());
    } catch (e) {
      emit(RoomError(e.toString()));
    }
  }

  Future<void> _onUpdateRoom(UpdateRoom event, Emitter<RoomState> emit) async {
    emit(RoomLoading());
    try {
      final room = await repository.update(event.id, event.room);
      emit(RoomLoaded(room));
      add(LoadRooms());
    } catch (e) {
      emit(RoomError(e.toString()));
    }
  }

  Future<void> _onDeleteRoom(DeleteRoom event, Emitter<RoomState> emit) async {
    emit(RoomLoading());
    try {
      await repository.delete(event.id);
      add(LoadRooms());
    } catch (e) {
      emit(RoomError(e.toString()));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lesgo_flutter/models/room/room.dart';
import '../blocs/room_bloc.dart';

class RoomsPage extends StatefulWidget {
  const RoomsPage({super.key});

  @override
  State<RoomsPage> createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  String _searchQuery = '';
  final List<FPersistentSheetController> _controllers = [];

  @override
  void initState() {
    super.initState();
    context.read<RoomBloc>().add(LoadRooms());
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoomBloc, RoomState>(
      listener: (context, state) {
        if (state is RoomError) {
          showFToast(
            context: context,
            variant: .destructive,
            icon: Icon(FIcons.circleX),
            title: Text('Error'),
            description: Text(state.message),
          );
        }
      },
      builder: (context, state) {
        if (state is RoomLoading) {
          return const Center(child: FCircularProgress());
        } else if (state is RoomsLoaded) {
          final filteredRooms = _filter(state.rooms);

          return FScaffold(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with search and add button
                  Row(
                    children: [
                      Expanded(
                        child: FTextField(
                          prefixBuilder: (context, style, variants) => Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                              right: 8.0,
                            ),
                            child: const Icon(FIcons.search),
                          ),
                          onSubmit: (value) {
                            setState(() {
                              _searchQuery = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      FButton(
                        onPress: () => showFPersistentSheet(
                          context: context,
                          style: const .delta(flingVelocity: 700),
                          side: .rtl,
                          builder: (context, controller) =>
                              _buildRoomForm(controller: controller),
                        ),
                        suffix: const Icon(Icons.add),
                        child: const Text('Add Room'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Rooms list
                  Expanded(child: _buildRoomsList(filteredRooms)),
                ],
              ),
            ),
          );
        } else {
          return const FScaffold(
            child: Center(child: Text('Failed to load rooms')),
          );
        }
      },
    );
  }

  List<Room> _filter(List<Room> rooms) {
    final filteredRooms = rooms.where((room) {
      return [
        room.name.toLowerCase().contains(_searchQuery.toLowerCase()),
        room.coursePlace.toLowerCase().contains(_searchQuery.toLowerCase()),
      ].any((element) => element == true);
    }).toList();

    return filteredRooms;
  }

  Widget _buildRoomsList(List<Room> rooms) {
    if (rooms.isEmpty) {
      return const Center(child: Text('No rooms found'));
    }

    return FItemGroup.builder(
      itemBuilder: (context, index) {
        final room = rooms[index];
        return FItem(
          prefix: FAvatar.raw(child: Text(room.name[0].toUpperCase())),
          title: Text(room.name),
          subtitle: Text('Course Place: ${room.coursePlace}'),
          suffix: Row(
            mainAxisSize: .min,
            spacing: 8,
            children: [
              FButton(
                child: Icon(FIcons.eye),
                onPress: () => _showRoomDetails(room),
              ),
              FButton(
                child: Icon(FIcons.pencil),
                onPress: () {
                  final controller = showFPersistentSheet(
                    context: context,
                    style: const .delta(flingVelocity: 700),
                    side: .rtl,
                    builder: (context, controller) =>
                        _buildRoomForm(controller: controller, room: room),
                  );
                  _controllers.add(controller);
                },
              ),
              FButton(
                child: Icon(FIcons.trash),
                onPress: () => _deleteRoom(room),
              ),
            ],
          ),
        );
      },
      count: rooms.length,
      divider: .full,
    );
  }

  Widget _buildRoomForm({
    Room? room,
    required FPersistentSheetController controller,
  }) {
    final isEditing = room != null;
    final formKey = GlobalKey<FormState>();
    String name = isEditing ? (room.name) : '';
    String coursePlace = isEditing ? (room.coursePlace) : '';

    return FSheets(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.theme.colors.background,
          borderRadius: context.theme.style.borderRadius.md,
          border: .all(color: context.theme.colors.border),
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: .center,
            spacing: 16,
            children: [
              Text(
                isEditing ? 'Edit Room' : 'Add New Room',
                style: context.theme.typography.xl,
              ),
              FTextFormField(
                control: .managed(initial: TextEditingValue(text: name)),
                label: const Text('Name'),
                hint: 'Room 101',
                autovalidateMode: .onUserInteraction,
                validator: (value) =>
                    value!.trim().isEmpty ? 'Name is required' : null,
                onSaved: (newValue) => name = newValue!,
              ),
              FTextFormField(
                control: .managed(initial: TextEditingValue(text: coursePlace)),
                label: const Text('Course Place'),
                hint: 'Main Building',
                autovalidateMode: .onUserInteraction,
                validator: (value) =>
                    value!.trim().isEmpty ? 'Course Place is required' : null,
                onSaved: (newValue) => coursePlace = newValue!,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: FButton(
                      onPress: () {
                        controller.hide();
                      },
                      variant: .outline,
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FButton(
                      onPress: () {
                        if (!formKey.currentState!.validate()) return;

                        formKey.currentState!.save();

                        final updatedRoom = isEditing
                            ? room.copyWith(
                                name: name.trim(),
                                coursePlace: coursePlace.trim(),
                              )
                            : Room.create(
                                name: name.trim(),
                              ).copyWith(coursePlace: coursePlace.trim());

                        if (isEditing) {
                          context.read<RoomBloc>().add(
                            UpdateRoom(updatedRoom.id, updatedRoom),
                          );
                        } else {
                          context.read<RoomBloc>().add(CreateRoom(updatedRoom));
                        }

                        controller.hide();
                      },
                      child: Text(isEditing ? 'Update' : 'Add'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteRoom(Room room) {
    showFDialog(
      context: context,
      builder: (context, style, animation) => FDialog(
        title: const Text('Delete Room'),
        body: Text('Are you sure you want to delete "${room.name}"?'),
        actions: [
          FButton(
            onPress: () => context.pop(),
            variant: .outline,
            child: const Text('Cancel'),
          ),
          FButton(
            onPress: () {
              context.read<RoomBloc>().add(DeleteRoom(room.id));
              context.pop();
            },
            variant: .destructive,
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showRoomDetails(Room room) {
    showFDialog(
      context: context,
      builder: (context, style, animation) => FDialog(
        title: Text('Detail Room'),
        body: FItemGroup(
          style: const .delta(spacing: 4),
          intrinsicWidth: null,
          divider: .full,
          children: [
            .item(title: const Text('Name'), details: Text(room.name)),
            .item(
              title: const Text('Course Place'),
              details: Text(room.coursePlace),
            ),
            .item(
              title: const Text('Created'),
              details: Text(room.created.toString()),
            ),
            if (room.updated != null)
              .item(
                title: const Text('Updated'),
                details: Text(room.updated.toString()),
              ),
          ],
        ),
        actions: [
          FButton(onPress: () => context.pop(), child: const Text('Close')),
        ],
      ),
    );
  }
}

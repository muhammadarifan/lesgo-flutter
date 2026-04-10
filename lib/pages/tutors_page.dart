import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/tutor_bloc.dart';
import '../models/tutor.dart';
import '../enums/gender_enum.dart';

class TutorsPage extends StatefulWidget {
  const TutorsPage({super.key});

  @override
  State<TutorsPage> createState() => _TutorsPageState();
}

class _TutorsPageState extends State<TutorsPage> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<TutorBloc>().add(LoadTutors());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TutorBloc, TutorState>(
      listener: (context, state) {
        if (state is TutorError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is TutorLoading) {
          return const Center(child: FCircularProgress());
        } else if (state is TutorsLoaded) {
          final filteredTutors = state.tutors.where((tutor) {
            return tutor.name.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ) ||
                tutor.email.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ) ||
                tutor.address.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                );
          }).toList();

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
                        child: Material(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Search tutors...',
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _searchQuery = value;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      FButton(
                        onPress: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => _buildTutorForm(),
                          );
                        },
                        suffix: const Icon(Icons.add),
                        child: const Text('Add Tutor'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Tutors list
                  Expanded(child: _buildTutorsList(filteredTutors)),
                ],
              ),
            ),
          );
        } else {
          return const FScaffold(
            child: Center(child: Text('Failed to load tutors')),
          );
        }
      },
    );
  }

  Widget _buildTutorsList(List<Tutor> tutors) {
    if (tutors.isEmpty) {
      return const Center(child: Text('No tutors found'));
    }

    return FItemGroup.builder(
      itemBuilder: (context, index) {
        final tutor = tutors[index];
        return FItem(
          prefix: FAvatar.raw(child: Text(tutor.name[0].toUpperCase())),
          title: Text(tutor.name),
          subtitle: Text(
            '${tutor.gender.displayName} • ${tutor.isActive ? 'Active' : 'Inactive'}',
          ),
          details: Text(tutor.email),
          suffix: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FButton(
                child: Icon(Icons.edit),
                onPress: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => _buildTutorForm(tutor),
                  );
                },
              ),
              FButton(
                child: Icon(Icons.delete),
                onPress: () => _deleteTutor(tutor),
              ),
            ],
          ),
          onPress: () => _showTutorDetails(tutor),
        );
      },
      count: tutors.length,
    );
  }

  Widget _buildTutorForm([Tutor? tutor]) {
    final isEditing = tutor != null;
    String name = isEditing ? tutor!.name : '';
    String email = isEditing ? tutor!.email : '';
    String phone = isEditing ? tutor!.phone : '';
    String address = isEditing ? tutor!.address : '';
    GenderEnum gender = isEditing ? tutor!.gender : GenderEnum.male;
    bool isActive = isEditing ? tutor!.isActive : true;

    return FCard(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isEditing ? 'Edit Tutor' : 'Add New Tutor',
              style: context.theme.typography.xl,
            ),
            const SizedBox(height: 16),
            Material(
              child: TextFormField(
                initialValue: name,
                onChanged: (value) => name = value,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Material(
              child: TextFormField(
                initialValue: email,
                onChanged: (value) => email = value,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(height: 16),
            Material(
              child: TextFormField(
                initialValue: phone,
                onChanged: (value) => phone = value,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
            ),
            const SizedBox(height: 16),
            Material(
              child: TextFormField(
                initialValue: address,
                onChanged: (value) => address = value,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Material(
              child: DropdownButtonFormField<GenderEnum>(
                value: gender,
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
                items: GenderEnum.values.map((g) {
                  return DropdownMenuItem(value: g, child: Text(g.displayName));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    gender = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            Material(
              child: DropdownButtonFormField<bool>(
                value: isActive,
                decoration: const InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: true, child: Text('Active')),
                  DropdownMenuItem(value: false, child: Text('Inactive')),
                ],
                onChanged: (value) {
                  setState(() {
                    isActive = value!;
                  });
                },
              ),
            ),

            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: FButton(
                    onPress: () {
                      Navigator.of(context).pop();
                    },
                    variant: .outline,
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FButton(
                    onPress: () {
                      final updatedTutor = isEditing
                          ? tutor!.copyWith(
                              name: name.trim(),
                              email: email.trim(),
                              phone: phone.trim(),
                              address: address.trim(),
                              gender: gender,
                              isActive: isActive,
                            )
                          : Tutor(
                              id: '',
                              name: name.trim(),
                              email: email.trim(),
                              phone: phone.trim(),
                              address: address.trim(),
                              gender: gender,
                              isActive: isActive,
                            );

                      if (isEditing) {
                        context.read<TutorBloc>().add(
                          UpdateTutor(updatedTutor.id, updatedTutor),
                        );
                      } else {
                        context.read<TutorBloc>().add(
                          CreateTutor(updatedTutor),
                        );
                      }

                      Navigator.of(context).pop();
                    },
                    child: Text(isEditing ? 'Update' : 'Add'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _deleteTutor(Tutor tutor) {
    showDialog(
      context: context,
      builder: (context) => FDialog(
        title: const Text('Delete Tutor'),
        body: Text('Are you sure you want to delete "${tutor.name}"?'),
        actions: [
          FButton(
            onPress: () => Navigator.of(context).pop(),
            variant: .outline,
            child: const Text('Cancel'),
          ),
          FButton(
            onPress: () {
              context.read<TutorBloc>().add(DeleteTutor(tutor.id));
              Navigator.of(context).pop();
            },
            variant: .destructive,
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showTutorDetails(Tutor tutor) {
    showDialog(
      context: context,
      builder: (context) => FDialog(
        title: Text(tutor.name),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${tutor.email}'),
            Text('Phone: ${tutor.phone}'),
            Text('Address: ${tutor.address}'),
            Text('Gender: ${tutor.gender.displayName}'),
            Text('Status: ${tutor.isActive ? 'Active' : 'Inactive'}'),
          ],
        ),
        actions: [
          FButton(
            onPress: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

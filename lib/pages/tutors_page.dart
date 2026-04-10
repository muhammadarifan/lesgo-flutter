import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
                              _buildTutorForm(controller: controller),
                        ),
                        suffix: const Icon(Icons.add),
                        child: const Text('Add Tutor'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Tutors list
                  Expanded(child: _buildTutorsList(context, filteredTutors)),
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

  Widget _buildTutorsList(BuildContext parentContext, List<Tutor> tutors) {
    if (tutors.isEmpty) {
      return const Center(child: Text('No tutors found'));
    }

    return FItemGroup.builder(
      itemBuilder: (context, index) {
        final tutor = tutors[index];
        return FItem(
          prefix: FAvatar.raw(child: Icon(FIcons.user)),
          title: Text(tutor.name),
          subtitle: Text('${tutor.email} - ${tutor.phone}'),
          suffix: Row(
            mainAxisSize: .min,
            spacing: 8,
            children: [
              FSwitch(
                value: tutor.isActive,
                onChange: (value) {
                  context.read<TutorBloc>().add(
                    UpdateTutor(tutor.id, tutor.copyWith(isActive: value)),
                  );
                },
              ),
              FButton(
                child: Icon(FIcons.eye),
                onPress: () => _showTutorDetails(tutor),
              ),
              FButton(
                child: Icon(FIcons.pencil),
                onPress: () => showFPersistentSheet(
                  context: parentContext,
                  style: const .delta(flingVelocity: 700),
                  side: .rtl,
                  builder: (context, controller) =>
                      _buildTutorForm(controller: controller, tutor: tutor),
                ),
              ),
              FButton(
                child: Icon(Icons.delete),
                onPress: () => _deleteTutor(tutor),
              ),
            ],
          ),
        );
      },
      count: tutors.length,
    );
  }

  Widget _buildTutorForm({
    Tutor? tutor,
    required FPersistentSheetController controller,
  }) {
    final isEditing = tutor != null;
    final formKey = GlobalKey<FormState>();
    String name = isEditing ? tutor.name : '';
    String email = isEditing ? tutor.email : '';
    String phone = isEditing ? tutor.phone : '';
    String address = isEditing ? tutor.address : '';
    GenderEnum gender = isEditing ? tutor.gender : GenderEnum.male;
    bool isActive = isEditing ? tutor.isActive : true;

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
                isEditing ? 'Edit Tutor' : 'Add New Tutor',
                style: context.theme.typography.xl,
              ),
              FTextFormField(
                control: .managed(initial: TextEditingValue(text: name)),
                hint: 'Name',
                autovalidateMode: .onUserInteraction,
                validator: (value) =>
                    value!.trim().isEmpty ? 'Name is required' : null,
                onSaved: (newValue) => name = newValue!,
              ),
              FTextFormField(
                control: .managed(initial: TextEditingValue(text: email)),
                hint: 'Email',
                autovalidateMode: .onUserInteraction,
                validator: (value) =>
                    value!.trim().isEmpty ? 'Email is required' : null,
                onSaved: (newValue) => email = newValue!,
              ),
              FTextFormField(
                control: .managed(initial: TextEditingValue(text: phone)),
                hint: 'Phone',
                autovalidateMode: .onUserInteraction,
                validator: (value) =>
                    value!.trim().isEmpty ? 'Phone is required' : null,
                onSaved: (newValue) => phone = newValue!,
              ),
              FTextFormField(
                control: .managed(initial: TextEditingValue(text: address)),
                hint: 'Address',
                autovalidateMode: .onUserInteraction,
                validator: (value) =>
                    value!.trim().isEmpty ? 'Address is required' : null,
                onSaved: (newValue) => address = newValue!,
              ),
              FSelect<GenderEnum>.rich(
                control: .managed(initial: gender),
                hint: 'Select gender',
                format: (g) => g.displayName,
                children: GenderEnum.values
                    .map(
                      (g) => FSelectItem.item(
                        title: Text(g.displayName),
                        value: g,
                      ),
                    )
                    .toList(),
                validator: (value) => value == null ? 'Select gender' : null,
                onSaved: (newValue) => gender = newValue!,
              ),
              FSelect<bool>.rich(
                control: .managed(initial: isActive),
                hint: 'Select status',
                format: (s) => s ? 'Active' : 'Inactive',
                children: [
                  FSelectItem.item(title: const Text('Active'), value: true),
                  FSelectItem.item(title: const Text('Inactive'), value: false),
                ],
                validator: (value) => value == null ? 'Select status' : null,
                onSaved: (newValue) => isActive = newValue!,
              ),

              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: FButton(
                      onPress: () => controller.hide(),
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

                        final updatedTutor = isEditing
                            ? tutor.copyWith(
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

  void _deleteTutor(Tutor tutor) {
    showFDialog(
      context: context,
      builder: (context, style, animation) => FDialog(
        title: const Text('Delete Tutor'),
        body: Text('Are you sure you want to delete "${tutor.name}"?'),
        actions: [
          FButton(
            onPress: () => context.pop(),
            variant: .outline,
            child: const Text('Cancel'),
          ),
          FButton(
            onPress: () {
              context.read<TutorBloc>().add(DeleteTutor(tutor.id));
              context.pop();
            },
            variant: .destructive,
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showTutorDetails(Tutor tutor) {
    showFDialog(
      context: context,
      builder: (context, style, animation) => FDialog(
        title: Text('Detail Tutor'),
        body: FItemGroup(
          style: const .delta(spacing: 4),
          intrinsicWidth: null,
          divider: .full,
          children: [
            .item(title: const Text('Name'), details: Text(tutor.name)),
            .item(title: const Text('Email'), details: Text(tutor.email)),
            .item(title: const Text('Phone'), details: Text(tutor.phone)),
            .item(title: const Text('Address'), details: Text(tutor.address)),
            .item(
              title: const Text('Gender'),
              details: Text(tutor.gender.displayName),
            ),
            .item(
              title: const Text('Status'),
              details: Text(tutor.isActive ? 'Active' : 'Inactive'),
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

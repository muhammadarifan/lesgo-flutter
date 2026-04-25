import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:lesgo_flutter/blocs/tutor_bloc.dart';
import 'package:lesgo_flutter/enums/gender_enum.dart';
import 'package:lesgo_flutter/models/tutor/tutor.dart';

class TutorForm extends HookWidget {
  const TutorForm({super.key, this.tutor, required this.controller});

  final Tutor? tutor;
  final FPersistentSheetController controller;

  @override
  Widget build(BuildContext context) {
    final isEditing = tutor != null;
    final formKey = GlobalKey<FormState>();
    String name = isEditing ? tutor!.name : '';
    String? email = isEditing ? tutor!.email : '';
    String? phone = isEditing ? tutor!.phone : '';
    String? address = isEditing ? tutor!.address : '';
    GenderEnum gender = isEditing ? tutor!.gender : GenderEnum.male;
    bool isActive = isEditing ? tutor!.isActive : true;

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
                control: .managed(initial: TextEditingValue(text: email ?? '')),
                hint: 'Email',
                autovalidateMode: .onUserInteraction,
                validator: (value) =>
                    value!.trim().isEmpty ? 'Email is required' : null,
                onSaved: (newValue) => email = newValue!,
              ),
              FTextFormField(
                control: .managed(initial: TextEditingValue(text: phone ?? '')),
                hint: 'Phone',
                autovalidateMode: .onUserInteraction,
                validator: (value) =>
                    value!.trim().isEmpty ? 'Phone is required' : null,
                onSaved: (newValue) => phone = newValue!,
              ),
              FTextFormField(
                control: .managed(
                  initial: TextEditingValue(text: address ?? ''),
                ),
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
                            ? tutor!.copyWith(
                                name: name.trim(),
                                email: email?.trim(),
                                phone: phone?.trim(),
                                address: address?.trim(),
                                gender: gender,
                                isActive: isActive,
                              )
                            : Tutor.create(
                                name: name.trim(),
                                email: email?.trim() ?? '',
                                phone: phone?.trim() ?? '',
                                address: address?.trim() ?? '',
                                gender: gender,
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
}

import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/auth_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  String email = '';
  String name = '';
  String password = '';
  String coursePlaceName = '';
  String coursePlaceAddress = '';
  String passwordConfirm = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.go('/');
        } else if (state is AuthError) {
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
        return FScaffold(
          child: Center(
            child: Container(
              width: 400,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: context.theme.colors.background,
                borderRadius: context.theme.style.borderRadius.md,
                border: Border.all(color: context.theme.colors.border),
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 16,
                  children: [
                    Text('Register', style: context.theme.typography.xl2),
                    FTextFormField(
                      control: .managed(initial: TextEditingValue(text: email)),
                      hint: 'Email',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                          value!.trim().isEmpty ? 'Email is required' : null,
                      onSaved: (newValue) => email = newValue!,
                    ),
                    FTextFormField(
                      control: .managed(initial: TextEditingValue(text: name)),
                      hint: 'Name',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                          value!.trim().isEmpty ? 'Name is required' : null,
                      onSaved: (newValue) => name = newValue!,
                    ),
                    FTextFormField(
                      control: .managed(
                        initial: TextEditingValue(text: coursePlaceName),
                      ),
                      hint: 'Nama Tempat Les',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => value!.trim().isEmpty
                          ? 'Business name is required'
                          : null,
                      onSaved: (newValue) => coursePlaceName = newValue!,
                    ),
                    FTextFormField.multiline(
                      control: .managed(
                        initial: TextEditingValue(text: coursePlaceAddress),
                      ),
                      hint: 'Alamat Tempat Les',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => value!.trim().isEmpty
                          ? 'Business address is required'
                          : null,
                      onSaved: (newValue) => coursePlaceAddress = newValue!,
                    ),
                    FTextFormField.password(
                      control: .managed(
                        initial: TextEditingValue(text: password),
                      ),
                      hint: 'Password',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                          value!.trim().isEmpty ? 'Password is required' : null,
                      onSaved: (newValue) => password = newValue!.trim(),
                    ),
                    FTextFormField.password(
                      control: .managed(
                        initial: TextEditingValue(text: passwordConfirm),
                      ),
                      hint: 'Confirm Password',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => value!.trim().isEmpty
                          ? 'Confirmation is required'
                          : null,
                      onSaved: (newValue) => passwordConfirm = newValue!.trim(),
                    ),
                    if (state is AuthLoading)
                      const FCircularProgress()
                    else
                      FButton(
                        onPress: () {
                          if (!formKey.currentState!.validate()) return;
                          formKey.currentState!.save();
                          if (password != passwordConfirm) {
                            showFToast(
                              context: context,
                              variant: .destructive,
                              icon: Icon(FIcons.circleX),
                              title: Text('Error'),
                              description: Text('Passwords do not match'),
                            );
                            return;
                          }
                          context.read<AuthBloc>().add(
                            Register(
                              email.trim(),
                              password,
                              name.trim(),
                              coursePlaceName.trim(),
                              coursePlaceAddress.trim(),
                            ),
                          );
                        },
                        child: const Text('Register'),
                      ),
                    FButton(
                      onPress: () => context.go('/login'),
                      variant: .ghost,
                      child: const Text('Already have an account? Login'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

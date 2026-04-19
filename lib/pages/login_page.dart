import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();

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
                    Text('Login', style: context.theme.typography.xl2),
                    FTextFormField(
                      control: .managed(controller: emailTextEditingController),
                      hint: 'Email',
                      label: Text('Email'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                          value!.trim().isEmpty ? 'Email is required' : null,
                    ),
                    FTextFormField.password(
                      control: .managed(
                        controller: passwordTextEditingController,
                      ),
                      hint: 'Password',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                          value!.trim().isEmpty ? 'Password is required' : null,
                    ),
                    if (state is AuthLoading)
                      const FCircularProgress()
                    else
                      FButton(
                        onPress: () {
                          if (!formKey.currentState!.validate()) return;

                          final email = emailTextEditingController.text;
                          final password = passwordTextEditingController.text;

                          context.read<AuthBloc>().add(
                            Login(email.trim(), password),
                          );
                        },
                        child: const Text('Login'),
                      ),
                    FButton(
                      onPress: () => context.go('/register'),
                      variant: .ghost,
                      child: const Text('Don\'t have an account? Register'),
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

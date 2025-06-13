import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/auth/presentation/bloc/auth_cubit.dart';
import '../core/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController(text: 'test@email.com');
  final _passwordController = TextEditingController(text: 'password123');
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final yellow = AppColors.yellow;
    final bgColor = AppColors.background;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white, size: 28),
          onPressed: () => context.go('/welcome'),
        ),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (blocContext, state) async {
          if (state is AuthAuthenticated) {
            try {
              // Add a small delay to ensure all state updates are complete
              await Future.delayed(const Duration(milliseconds: 100));
              if (mounted) {
                // Use addPostFrameCallback to ensure navigation happens after the current frame
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.go('/main');
                });
              }
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Navigation error: $e')));
              }
            }
          } else if (state is AuthError) {
            if (mounted) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const SizedBox(height: 16),
                  Text('Sign in', style: theme.textTheme.headlineLarge),
                  const SizedBox(height: 40),
                  Text(
                    'Email',
                    style: TextStyle(
                      color: yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextField(
                    controller: _emailController,
                    style: theme.textTheme.bodyLarge,
                    decoration: InputDecoration(
                      hintText: 'email@email.com',
                      hintStyle: theme.textTheme.bodyLarge?.copyWith(
                        color: AppColors.white,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: yellow, width: 1.5),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: yellow, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'Password',
                    style: TextStyle(
                      color: yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: theme.textTheme.bodyLarge,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: yellow,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: yellow, width: 1.5),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: yellow, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<AuthCubit>().login(
                          _emailController.text,
                          _passwordController.text,
                        );
                      },
                      child: const Text('Continue'),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Can't sign in?",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.white70,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Recover password',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: yellow,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

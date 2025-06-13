import 'package:go_router/go_router.dart';
import '../screens/splash_screen.dart';
import '../screens/welcome_screen.dart';
import '../screens/login_screen.dart';
import '../screens/main_shell_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/collection/presentation/bloc/collection_cubit.dart';
import '../screens/bottle_detail_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/main',
      builder: (context, state) => const MainShellScreen(),
    ),
    GoRoute(
      path: '/bottle/:id',
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id']!);
        if (id == null) {
          return const Scaffold(body: Center(child: Text('Invalid bottle id')));
        }
        final cubit = context.read<CollectionCubit>();
        final collectionState = cubit.state;
        if (collectionState is CollectionLoaded) {
          final bottle = collectionState.bottles.firstWhere(
            (b) => b.id == id,
            orElse: () => throw Exception('Bottle not found'),
          );
          return BottleDetailScreen(bottle: bottle);
        } else {
          // If not loaded, show a loading indicator or error
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    ),
    GoRoute(
      path: '/test',
      builder: (context, state) => const Scaffold(
        body: Center(
          child: Text('Test Screen', style: TextStyle(fontSize: 32)),
        ),
      ),
    ),
  ],
);

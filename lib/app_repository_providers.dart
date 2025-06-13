import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'features/auth/data/datasources/auth_local_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/login_usecase.dart';

class AppRepositoryProviders extends StatelessWidget {
  final Widget child;
  const AppRepositoryProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthLocalDataSource()),
        RepositoryProvider(
          create: (context) =>
              AuthRepositoryImpl(context.read<AuthLocalDataSource>()),
        ),
        RepositoryProvider(
          create: (context) => LoginUseCase(context.read<AuthRepositoryImpl>()),
        ),
      ],
      child: child,
    );
  }
}

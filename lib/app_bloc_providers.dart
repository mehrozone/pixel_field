import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'features/auth/presentation/bloc/auth_cubit.dart';
import 'features/collection/presentation/bloc/collection_cubit.dart';
import 'features/auth/domain/usecases/login_usecase.dart';

class AppBlocProviders extends StatelessWidget {
  final Widget child;
  const AppBlocProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return AuthCubit(context.read<LoginUseCase>());
          },
        ),
        BlocProvider(
          create: (context) {
            return CollectionCubit();
          },
        ),
      ],
      child: child,
    );
  }
}

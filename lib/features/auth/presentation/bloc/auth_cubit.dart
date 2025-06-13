import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/entities/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  AuthCubit(this.loginUseCase) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      final user = await loginUseCase(email, password);
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthError('Invalid email or password'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void logout() {
    emit(AuthInitial());
  }
}

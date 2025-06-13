import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;
  LoginUseCase(this.repository);

  Future<User?> call(String email, String password) async {
    final user = await repository.authenticate(email, password);
    return user;
  }
}

import '../entities/user.dart';

abstract class AuthRepository {
  Future<User?> authenticate(String email, String password);
}

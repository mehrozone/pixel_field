import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../../domain/entities/user.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;
  AuthRepositoryImpl(this.localDataSource);

  @override
  Future<User?> authenticate(String email, String password) async {
    final userModel = await localDataSource.authenticate(email, password);
    if (userModel != null) {
      final user = User(email: userModel.email);
      return user;
    }
    return null;
  }
}

import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/user_model.dart';

class AuthLocalDataSource {
  List<UserModel> _users = [];
  bool _loaded = false;

  Future<void> loadUsers() async {
    if (_loaded) return;
    final String data = await rootBundle.loadString('assets/mock_users.json');
    final List<dynamic> jsonList = json.decode(data);
    _users = jsonList.map((e) => UserModel.fromJson(e)).toList();
    _loaded = true;
  }

  Future<UserModel?> authenticate(String email, String password) async {
    await loadUsers();
    try {
      final user = _users.firstWhere(
        (user) => user.email == email && user.password == password,
      );
      return user;
    } catch (_) {
      return null;
    }
  }
}

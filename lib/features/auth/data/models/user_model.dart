class UserModel {
  final String email;
  final String password;

  UserModel({required this.email, required this.password});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}

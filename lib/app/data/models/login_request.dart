import 'dart:convert';

class LoginRequest {
  String email;
  String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory LoginRequest.fromMap(Map<String, dynamic> map) {
    return LoginRequest(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginRequest.fromJson(String source) => LoginRequest.fromMap(json.decode(source));
}

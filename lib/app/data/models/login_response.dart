import 'dart:convert';

class LoginResponse {
  final String userId;
  final String fullName;
  final String email;

  LoginResponse({
    required this.userId,
    required this.fullName,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'fullName': fullName,
      'email': email,
    };
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      userId: map['userId'] ?? '',
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromJson(String source) => LoginResponse.fromMap(json.decode(source));
}

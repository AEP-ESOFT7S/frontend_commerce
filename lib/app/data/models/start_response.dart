import 'dart:convert';

class StartResponse {
  String userName;
  String fullName;
  String? avatar;
  String? branch;
  String loginToken;
  DateTime expiresAt;

  StartResponse({
    required this.expiresAt,
    required this.fullName,
    this.avatar,
    this.branch,
    required this.loginToken,
    required this.userName,
  });

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'fullName': fullName,
      'avatar': avatar,
      'branch': branch,
      'loginToken': loginToken,
      'expiresAt': expiresAt.millisecondsSinceEpoch,
    };
  }

  factory StartResponse.fromMap(Map<String, dynamic> map) {
    return StartResponse(
      userName: map['userName'] ?? '',
      fullName: map['fullName'] ?? '',
      avatar: map['avatar'] ?? '',
      branch: map['branch'] ?? '',
      loginToken: map['loginToken'] ?? '',
      expiresAt: DateTime.parse(map['expiresAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory StartResponse.fromJson(String source) => StartResponse.fromMap(json.decode(source));
}

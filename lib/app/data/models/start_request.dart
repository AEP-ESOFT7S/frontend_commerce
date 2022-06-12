import 'dart:convert';

class StartRequest {
  String userName;

  StartRequest(this.userName);

  Map<String, dynamic> toMap() {
    return {
      'username': userName,
    };
  }

  factory StartRequest.fromMap(Map<String, dynamic> map) {
    return StartRequest(
      map['username'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StartRequest.fromJson(String source) => StartRequest.fromMap(json.decode(source));
}

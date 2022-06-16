import 'dart:convert';

class Polling {
  String id;
  String orderId;
  String code;
  String fullCode;
  DateTime createdAt;

  Polling({
    required this.id,
    required this.orderId,
    required this.code,
    required this.fullCode,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderId': orderId,
      'code': code,
      'fullCode': fullCode,
      'createdAt': createdAt.toString(),
    };
  }

  factory Polling.fromMap(Map<String, dynamic> map) {
    return Polling(
      id: map['id'] ?? '',
      orderId: map['orderId'] ?? '',
      code: map['code'] ?? '',
      fullCode: map['fullCode'] ?? '',
      createdAt: DateTime.parse(map['createdAt']).toLocal(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Polling.fromJson(String source) => Polling.fromMap(json.decode(source));
}

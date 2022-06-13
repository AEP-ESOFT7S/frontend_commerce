import 'dart:convert';

class PollingResponse {
  String id;
  String orderId;
  String code;
  String fullCode;
  DateTime createdAt;

  PollingResponse({
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
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory PollingResponse.fromMap(Map<String, dynamic> map) {
    return PollingResponse(
      id: map['id'] ?? '',
      orderId: map['orderId'] ?? '',
      code: map['code'] ?? '',
      fullCode: map['fullCode'] ?? '',
      createdAt: DateTime(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PollingResponse.fromJson(String source) => PollingResponse.fromMap(json.decode(source));
}

import 'dart:convert';

class Order {
  final String id;
  final String displayId;
  final double benefits;
  final double deliveryFee;
  final double orderAmount;
  final double subTotal;
  final double additionalFees;
  final double latitude;
  final double longitude;
  final String streetName;
  final String formattedAddress;
  final String streetNumber;
  final String city;
  final String postalCode;
  final String neighborhood;
  final String complement;

  Order({
    required this.id,
    required this.displayId,
    required this.benefits,
    required this.deliveryFee,
    required this.orderAmount,
    required this.subTotal,
    required this.additionalFees,
    required this.latitude,
    required this.longitude,
    required this.streetName,
    required this.formattedAddress,
    required this.streetNumber,
    required this.city,
    required this.postalCode,
    required this.neighborhood,
    required this.complement,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'displayId': displayId,
      'benefits': benefits,
      'deliveryFee': deliveryFee,
      'orderAmount': orderAmount,
      'subTotal': subTotal,
      'additionalFees': additionalFees,
      'latitude': latitude,
      'longitude': longitude,
      'streetName': streetName,
      'formattedAddress': formattedAddress,
      'streetNumber': streetNumber,
      'city': city,
      'postalCode': postalCode,
      'neighborhood': neighborhood,
      'complement': complement,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] ?? '',
      displayId: map['displayId'] ?? '',
      benefits: map['benefits']?.toDouble() ?? 0.0,
      deliveryFee: map['deliveryFee']?.toDouble() ?? 0.0,
      orderAmount: map['orderAmount']?.toDouble() ?? 0.0,
      subTotal: map['subTotal']?.toDouble() ?? 0.0,
      additionalFees: map['additionalFees']?.toDouble() ?? 0.0,
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
      streetName: map['streetName'] ?? '',
      formattedAddress: map['formattedAddress'] ?? '',
      streetNumber: map['streetNumber'] ?? '',
      city: map['city'] ?? '',
      postalCode: map['postalCode'] ?? '',
      neighborhood: map['neighborhood'] ?? '',
      complement: map['complement'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}

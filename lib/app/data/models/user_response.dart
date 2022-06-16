// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserResponse {
  final String id;
  final String phone;
  final String cep;
  final String city;
  final String neighborhood;
  final String address;
  final String number;
  final String complement;
  final String email;
  final String password;
  final String type;
  // COMMERCE
  final String cnpj;
  final String corporateName;
  String? clientId;
  String? clientSecret;
  String? merchantId;

  UserResponse({
    required this.id,
    required this.phone,
    required this.cep,
    required this.city,
    required this.neighborhood,
    required this.address,
    required this.number,
    required this.complement,
    required this.email,
    required this.password,
    required this.type,
    required this.cnpj,
    required this.corporateName,
    this.clientId,
    this.clientSecret,
    this.merchantId,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'phone': phone,
      'cep': cep,
      'city': city,
      'neighborhood': neighborhood,
      'address': address,
      'number': number,
      'complement': complement,
      'email': email,
      'password': password,
      'type': type,
      'cnpj': cnpj,
      'corporateName': corporateName,
      'clientId': clientId,
      'clientSecret': clientSecret,
      'merchantId': merchantId,
    };
  }

  factory UserResponse.fromMap(Map<String, dynamic> map) {
    return UserResponse(
      id: map['_id'] ?? '',
      phone: map['phone'] ?? '',
      cep: map['cep'] ?? '',
      city: map['city'] ?? '',
      neighborhood: map['neighborhood'] ?? '',
      address: map['address'] ?? '',
      number: map['number'] ?? '',
      complement: map['complement'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      type: map['type'] ?? '',
      cnpj: map['cnpj'] ?? '',
      corporateName: map['corporateName'] ?? '',
      clientId: map['clientId'],
      clientSecret: map['clientSecret'],
      merchantId: map['merchantId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserResponse.fromJson(String source) => UserResponse.fromMap(json.decode(source));
}

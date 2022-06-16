import 'dart:convert';

class UserRequest {
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

  UserRequest({
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

  factory UserRequest.fromMap(Map<String, dynamic> map) {
    return UserRequest(
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

  factory UserRequest.fromJson(String source) => UserRequest.fromMap(json.decode(source));
}

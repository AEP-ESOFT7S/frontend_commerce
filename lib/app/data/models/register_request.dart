// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RegisterRequest {
  final String firstName;
  final String lastName;
  final String cpf;
  final String phone;
  final String cep;
  final String city;
  final String neighborhood;
  final String address;
  final String number;
  final String complement;
  final String email;
  final String password;
  String? clientId;
  String? clientSecret;
  String? merchantId;
  final String type;

  RegisterRequest({
    required this.firstName,
    required this.lastName,
    required this.cpf,
    required this.phone,
    required this.cep,
    required this.city,
    required this.neighborhood,
    required this.address,
    required this.number,
    required this.complement,
    required this.email,
    required this.password,
    this.clientId,
    this.clientSecret,
    this.merchantId,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'cpf': cpf,
      'phone': phone,
      'cep': cep,
      'city': city,
      'neighborhood': neighborhood,
      'address': address,
      'number': number,
      'complement': complement,
      'email': email,
      'password': password,
      'clientId': clientId,
      'clientSecret': clientSecret,
      'merchantId': merchantId,
      'type': type,
    };
  }

  factory RegisterRequest.fromMap(Map<String, dynamic> map) {
    return RegisterRequest(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      cpf: map['cpf'] as String,
      phone: map['phone'] as String,
      cep: map['cep'] as String,
      city: map['city'] as String,
      neighborhood: map['neighborhood'] as String,
      address: map['address'] as String,
      number: map['number'] as String,
      complement: map['complement'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      clientId: map['clientId'] != null ? map['clientId'] as String : null,
      clientSecret: map['clientSecret'] != null ? map['clientSecret'] as String : null,
      merchantId: map['merchantId'] != null ? map['merchantId'] as String : null,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterRequest.fromJson(String source) =>
      RegisterRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RegisterRequest {
  final String firstName;
  final String lastName;
  final String cep;
  final String city;
  final String neighborhood;
  final String address;
  final String number;
  final String complement;
  final String email;
  final String password;

  RegisterRequest({
    required this.firstName,
    required this.lastName,
    required this.cep,
    required this.city,
    required this.neighborhood,
    required this.address,
    required this.number,
    required this.complement,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'cep': cep,
      'city': city,
      'neighborhood': neighborhood,
      'address': address,
      'number': number,
      'complement': complement,
      'email': email,
      'password': password,
    };
  }

  factory RegisterRequest.fromMap(Map<String, dynamic> map) {
    return RegisterRequest(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      cep: map['cep'] as String,
      city: map['city'] as String,
      neighborhood: map['neighborhood'] as String,
      address: map['address'] as String,
      number: map['number'] as String,
      complement: map['complement'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterRequest.fromJson(String source) =>
      RegisterRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}

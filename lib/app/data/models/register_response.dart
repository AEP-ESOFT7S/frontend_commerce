import 'dart:convert';

class RegisterResponse {
  final String id;
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

  RegisterResponse({
    required this.id,
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
    return {
      '_id': id,
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

  factory RegisterResponse.fromMap(Map<String, dynamic> map) {
    return RegisterResponse(
      id: map['_id'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      cep: map['cep'] ?? '',
      city: map['city'] ?? '',
      neighborhood: map['neighborhood'] ?? '',
      address: map['address'] ?? '',
      number: map['number'] ?? '',
      complement: map['complement'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterResponse.fromJson(String source) => RegisterResponse.fromMap(json.decode(source));
}

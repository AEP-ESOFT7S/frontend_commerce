import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:verydeli_commerce/app/data/models/register_request.dart';
import 'package:verydeli_commerce/app/data/models/register_response.dart';
import 'package:verydeli_commerce/app/modules/account/account_repository.dart';

class AccountController extends GetxController {
  final _storage = GetStorage();

  final AccountRepository _accountRepository = AccountRepository();

  final TextEditingController clientIdController = TextEditingController();
  final TextEditingController clientSecretController = TextEditingController();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController neighborhoodController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController complementController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void onInit() async {
    // final credentials = await _storage.read('credentials');

    // if (credentials != null) {
    //   final credential = IFoodCredentials.fromJson(credentials);

    //   clientIdController.text = credential.clientId;
    //   clientSecretController.text = credential.clientSecret;
    // }

    final String user = _storage.read('userData');

    final json = RegisterResponse.fromJson(user);

    firstNameController.text = json.firstName;
    lastNameController.text = json.lastName;
    cpfController.text = json.cpf;
    phoneController.text = json.phone;
    cepController.text = json.cep;
    cityController.text = json.city;
    neighborhoodController.text = json.neighborhood;
    addressController.text = json.address;
    numberController.text = json.number;
    complementController.text = json.complement;
    emailController.text = json.email;
    clientIdController.text = json.clientId!;
    clientSecretController.text = json.clientSecret!;

    super.onInit();
  }

  final _index = 1.obs;
  int get getCurrentIndex => _index.value;
  set setCurrentIndex(int value) => _index.value = value;

  final _darkMode = false.obs;
  bool get getIsDarkMode => _darkMode.value;
  set setIsDarkMode(bool value) => _darkMode.value = value;

  Future<void> saveIfoodCredentials() async {
    IFoodCredentials credentials = IFoodCredentials(
        clientId: clientIdController.text, clientSecret: clientSecretController.text);
    if (credentials.clientId.isNotEmpty && credentials.clientSecret.isNotEmpty) {
      final String user = _storage.read('userData');

      RegisterResponse jsonResponse = RegisterResponse.fromJson(user);
      RegisterRequest jsonRequest = RegisterRequest.fromJson(user);

      jsonResponse.clientId = credentials.clientId;
      jsonResponse.clientSecret = credentials.clientSecret;
      jsonRequest.clientId = credentials.clientId;
      jsonRequest.clientSecret = credentials.clientSecret;

      await _accountRepository.saveCredentials(jsonResponse.id, jsonRequest.toJson()).then((value) {
        _storage.write('userData', jsonResponse);
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(value.message)));
      }).catchError((_) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(_.message)));
      });
    }
  }
}

class IFoodCredentials {
  String clientId;
  String clientSecret;

  IFoodCredentials({
    required this.clientId,
    required this.clientSecret,
  });

  Map<String, dynamic> toMap() {
    return {
      'clientId': clientId,
      'clientSecret': clientSecret,
    };
  }

  factory IFoodCredentials.fromMap(Map<String, dynamic> map) {
    return IFoodCredentials(
      clientId: map['clientId'] ?? '',
      clientSecret: map['clientSecret'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory IFoodCredentials.fromJson(String source) => IFoodCredentials.fromMap(json.decode(source));
}

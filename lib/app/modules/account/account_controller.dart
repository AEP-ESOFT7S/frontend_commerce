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
  final TextEditingController merchantIdController = TextEditingController();

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

  final _isEnableCredentialIfood = false.obs;
  bool get getIsEnableCredentialIfood => _isEnableCredentialIfood.value;
  set setIsEnableCredentialIfood(bool value) => _isEnableCredentialIfood.value = value;

  @override
  void onInit() async {
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
    clientIdController.text = json.clientId ?? '';
    clientSecretController.text = json.clientSecret ?? '';
    merchantIdController.text = json.merchantId ?? '';

    super.onInit();
  }

  final _index = 1.obs;
  int get getCurrentIndex => _index.value;
  set setCurrentIndex(int value) => _index.value = value;

  final _darkMode = false.obs;
  bool get getIsDarkMode => _darkMode.value;
  set setIsDarkMode(bool value) => _darkMode.value = value;

  Future<void> saveIfoodCredentials() async {
    if (clientIdController.text.isNotEmpty &&
        clientSecretController.text.isNotEmpty &&
        merchantIdController.text.isNotEmpty) {
      final String user = _storage.read('userData');

      RegisterResponse jsonResponse = RegisterResponse.fromJson(user);
      RegisterRequest jsonRequest = RegisterRequest.fromJson(user);

      jsonResponse.clientId = clientIdController.text;
      jsonResponse.clientSecret = clientSecretController.text;
      jsonResponse.merchantId = merchantIdController.text;
      jsonRequest.clientId = clientIdController.text;
      jsonRequest.clientSecret = clientSecretController.text;
      jsonRequest.merchantId = merchantIdController.text;

      await _accountRepository.saveCredentials(jsonResponse.id, jsonRequest.toJson()).then((value) {
        _storage.write('userData', jsonResponse.toJson());
        setIsEnableCredentialIfood = false;
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

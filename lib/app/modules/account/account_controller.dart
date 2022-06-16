import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:verydeli_commerce/app/data/models/user_request.dart';
import 'package:verydeli_commerce/app/data/models/user_response.dart';
import 'package:verydeli_commerce/app/modules/account/account_repository.dart';

class AccountController extends GetxController {
  final _storage = GetStorage();

  final AccountRepository _accountRepository = AccountRepository();

  final TextEditingController corporateNameController = TextEditingController();
  final TextEditingController cnpjController = TextEditingController();
  final TextEditingController clientIdController = TextEditingController();
  final TextEditingController clientSecretController = TextEditingController();
  final TextEditingController merchantIdController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController neighborhoodController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController complementController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final _isEnableEditCredentialIfood = false.obs;
  bool get getIsEnableEditCredentialIfood => _isEnableEditCredentialIfood.value;
  set setIsEnableEditCredentialIfood(bool value) => _isEnableEditCredentialIfood.value = value;

  @override
  void onInit() async {
    final String user = _storage.read('userData');

    final json = UserResponse.fromJson(user);

    corporateNameController.text = json.corporateName;
    cnpjController.text = json.cnpj;
    clientIdController.text = json.clientId ?? '';
    clientSecretController.text = json.clientSecret ?? '';
    merchantIdController.text = json.merchantId ?? '';

    phoneController.text = json.phone;
    cepController.text = json.cep;
    cityController.text = json.city;
    neighborhoodController.text = json.neighborhood;
    addressController.text = json.address;
    numberController.text = json.number;
    complementController.text = json.complement;
    emailController.text = json.email;

    super.onInit();
  }

  final _index = 1.obs;
  int get getCurrentIndex => _index.value;
  set setCurrentIndex(int value) => _index.value = value;

  final _darkMode = false.obs;
  bool get getIsDarkMode => _darkMode.value;
  set setIsDarkMode(bool value) => _darkMode.value = value;

  Future<void> saveIfoodCredentials() async {
    final String user = _storage.read('userData');

    UserResponse jsonResponse = UserResponse.fromJson(user);
    UserRequest jsonRequest = UserRequest.fromJson(user);

    jsonResponse.clientId = clientIdController.text;
    jsonResponse.clientSecret = clientSecretController.text;
    jsonResponse.merchantId = merchantIdController.text;

    jsonRequest.clientId = clientIdController.text;
    jsonRequest.clientSecret = clientSecretController.text;
    jsonRequest.merchantId = merchantIdController.text;

    await _accountRepository
        .saveCredentials(jsonResponse.email, jsonRequest.toJson())
        .then((value) {
      _storage.write('userData', jsonResponse.toJson());
      setIsEnableEditCredentialIfood = false;
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(value.message)));
    }).catchError((_) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(_.message)));
    });
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

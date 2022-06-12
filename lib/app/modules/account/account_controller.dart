import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AccountController extends GetxController {
  final _storage = GetStorage();

  final TextEditingController clientIdController = TextEditingController();
  final TextEditingController clientSecretController = TextEditingController();

  @override
  void onInit() async {
    final credentials = await _storage.read('credentials');

    if (credentials != null) {
      final credential = IFoodCredentials.fromJson(credentials);

      clientIdController.text = credential.clientId;
      clientSecretController.text = credential.clientSecret;
    }

    super.onInit();
  }

  final _index = 1.obs;
  int get getCurrentIndex => _index.value;
  set setCurrentIndex(int value) => _index.value = value;

  final _darkMode = false.obs;
  bool get getIsDarkMode => _darkMode.value;
  set setIsDarkMode(bool value) => _darkMode.value = value;

  Future<String> saveIfoodCredentials() async {
    IFoodCredentials credentials = IFoodCredentials(
        clientId: clientIdController.text, clientSecret: clientSecretController.text);
    await _storage.write('credentials', credentials.toJson());
    return 'Salvo!';
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

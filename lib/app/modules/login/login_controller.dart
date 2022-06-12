import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _isObscure = true.obs;

  bool get getIsObscure => _isObscure.value;
  set setIsObscure(bool value) => _isObscure.value = value;
}

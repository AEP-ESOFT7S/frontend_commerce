import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verydeli_commerce/app/data/models/user_request.dart';
import 'package:verydeli_commerce/app/modules/register/register_repository.dart';

class RegisterController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RegisterRepository _registerRepository = RegisterRepository();

  final TextEditingController corporateNameController = TextEditingController();
  final TextEditingController cnpjController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController neighborhoodController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController complementController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  Future<void> register() async {
    if (formKey.currentState!.validate()) {
      final user = UserRequest(
        corporateName: corporateNameController.text,
        cnpj: cnpjController.text.replaceAll(RegExp("[^0-9]"), ""),
        phone: phoneController.text,
        cep: cepController.text,
        city: cityController.text,
        neighborhood: neighborhoodController.text,
        address: addressController.text,
        number: numberController.text,
        complement: complementController.text,
        email: emailController.text,
        password: passwordController.text,
        type: 'merchant',
      );

      await _registerRepository.register(user.toJson()).then((value) {
        Get.offAllNamed('/login');
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(value.message)));
      }).catchError((error) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(error.message)));
      });
    }
  }
}

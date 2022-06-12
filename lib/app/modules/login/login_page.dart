import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verydeli_commerce/app/modules/login/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(child: Text('Verydeli', style: TextStyle(fontSize: 28))),
                const Center(
                  child: Text('comércio', style: TextStyle(fontSize: 16, color: Colors.grey)),
                ),
                const SizedBox(height: 50),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(labelText: 'Email'),
                  // validator: (value) => validateEmail(value!),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => TextFormField(
                    decoration: const InputDecoration(labelText: 'Senha'),
                    // validator: (value) => validateNotNull(value!),
                    obscureText: controller.getIsObscure,
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      Get.offAllNamed('/home');
                    }
                  },
                  child: const Text('Conectar'),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Get.toNamed('/register'),
                    child: const Text('criar uma conta'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validateNotNull(String value) {
    if (value.isNotEmpty) {
      return null;
    } else {
      return 'Este campo não pode ser vázio!';
    }
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Este campo não pode ser vázio!';
    } else if (value.isEmail) {
      return null;
    } else {
      return 'Insira um email válido!';
    }
  }
}

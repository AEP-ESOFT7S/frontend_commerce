import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:verydeli_commerce/app/modules/register/register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            children: [
              TextFormField(
                controller: controller.corporateNameController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(labelText: 'Razão Social'),
                validator: (value) => validateNotNull(value!),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.cnpjController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'CNPJ'),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CnpjInputFormatter(),
                ],
                validator: (value) => validateNotNull(value!),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.phoneController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Telefone'),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter(),
                ],
                validator: (value) => validateNotNull(value!),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.cepController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'CEP'),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CepInputFormatter(ponto: false),
                ],
                validator: (value) => validateNotNull(value!),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.cityController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(labelText: 'Cidade'),
                textCapitalization: TextCapitalization.sentences,
                validator: (value) => validateNotNull(value!),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.neighborhoodController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(labelText: 'Bairro'),
                textCapitalization: TextCapitalization.sentences,
                validator: (value) => validateNotNull(value!),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.addressController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.streetAddress,
                decoration: const InputDecoration(labelText: 'Logradouro'),
                textCapitalization: TextCapitalization.sentences,
                validator: (value) => validateNotNull(value!),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.numberController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Número'),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) => validateNotNull(value!),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.complementController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Complemento'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.emailController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => validateEmail(value!),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.passwordController,
                textInputAction: TextInputAction.next,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Senha'),
                validator: (value) => validatePassword(value!),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.confirmPasswordController,
                obscureText: true,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: 'Confirmar senha'),
                validator: (value) => validatePassword(value!),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => controller.register(),
                child: const Text('Cadastrar'),
              ),
            ],
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

  String? validatePassword(String value) {
    if (value.isNotEmpty) {
      if (value != controller.passwordController.text ||
          value != controller.confirmPasswordController.text) {
        return 'As senhas não coincidem!';
      }
      return null;
    } else {
      return 'Este campo não pode ser vázio!';
    }
  }

  String? validateCEP(String value) {
    if (value.isEmpty) {
      return 'Este campo não pode ser vázio!';
    } else if (value.isEmail) {
      return null;
    } else {
      return 'Insira um CEP válido!';
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

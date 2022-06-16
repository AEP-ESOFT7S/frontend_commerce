import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './account_controller.dart';

class AccountPage extends GetView<AccountController> {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(title: const Text('Configurações'), onTap: () => Get.toNamed('/settings')),
            ListTile(title: const Text('Logout'), onTap: () => Get.offAllNamed('/login')),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Obx(
          () => BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: 'Pedidos'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Conta'),
            ],
            currentIndex: controller.getCurrentIndex,
            onTap: (menu) {
              controller.setCurrentIndex = menu;

              if (controller.getCurrentIndex == 0) {
                Get.offAllNamed('/home');
              } else if (controller.getCurrentIndex == 1) {
                Get.offAllNamed('/account');
              }
            },
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          const Text('Dados do comércio', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Obx(() => TextFormField(
                controller: controller.clientIdController,
                decoration: const InputDecoration(labelText: 'Client ID'),
                enabled: controller.getIsEnableEditCredentialIfood,
              )),
          const SizedBox(height: 15),
          Obx(() => TextFormField(
                controller: controller.clientSecretController,
                decoration: const InputDecoration(labelText: 'Client Secret'),
                enabled: controller.getIsEnableEditCredentialIfood,
              )),
          const SizedBox(height: 15),
          Obx(() => TextFormField(
                controller: controller.merchantIdController,
                decoration: const InputDecoration(labelText: 'Merchant ID'),
                enabled: controller.getIsEnableEditCredentialIfood,
              )),
          const SizedBox(height: 20),
          Obx(() => ElevatedButton(
                onPressed: () {
                  if (controller.getIsEnableEditCredentialIfood) {
                    controller.saveIfoodCredentials();
                  } else {
                    controller.setIsEnableEditCredentialIfood = true;
                  }
                },
                child: Text(controller.getIsEnableEditCredentialIfood ? 'Salvar' : 'Editar'),
              )),
          const SizedBox(height: 40),
          const Text('Dados do usuário', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          TextFormField(
            controller: controller.corporateNameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(labelText: 'Razão Social'),
            enabled: false,
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: controller.cnpjController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(labelText: 'CNPJ'),
            enabled: false,
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: controller.phoneController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(labelText: 'Telefone'),
            enabled: false,
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: controller.cepController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'CEP'),
            enabled: false,
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: controller.cityController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(labelText: 'Cidade'),
            textCapitalization: TextCapitalization.sentences,
            enabled: false,
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: controller.neighborhoodController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(labelText: 'Bairro'),
            textCapitalization: TextCapitalization.sentences,
            enabled: false,
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: controller.addressController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.streetAddress,
            decoration: const InputDecoration(labelText: 'Logradouro'),
            textCapitalization: TextCapitalization.sentences,
            enabled: false,
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: controller.numberController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Número'),
            enabled: false,
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: controller.complementController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(labelText: 'Complemento'),
            enabled: false,
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: controller.emailController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: 'Email'),
            enabled: false,
          ),
        ],
      ),
    );
  }
}

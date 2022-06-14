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
          TextFormField(
            controller: controller.clientIdController,
            decoration: const InputDecoration(labelText: 'Client ID'),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: controller.clientSecretController,
            decoration: const InputDecoration(labelText: 'Client Secret'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => controller.saveIfoodCredentials(),
            child: const Text('Salvar'),
          ),
          const SizedBox(height: 40),
          const Text('Dados do usuário', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          TextFormField(
            controller: controller.firstNameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(labelText: 'Nome'),
            readOnly: true,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: controller.lastNameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(labelText: 'Sobrenome'),
            readOnly: true,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: controller.cpfController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(labelText: 'CPF'),
            readOnly: true,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: controller.phoneController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(labelText: 'Telefone'),
            readOnly: true,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: controller.cepController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'CEP'),
            readOnly: true,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: controller.cityController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(labelText: 'Cidade'),
            textCapitalization: TextCapitalization.sentences,
            readOnly: true,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: controller.neighborhoodController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(labelText: 'Bairro'),
            textCapitalization: TextCapitalization.sentences,
            readOnly: true,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: controller.addressController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.streetAddress,
            decoration: const InputDecoration(labelText: 'Logradouro'),
            textCapitalization: TextCapitalization.sentences,
            readOnly: true,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: controller.numberController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Número'),
            readOnly: true,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: controller.complementController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(labelText: 'Complemento'),
            readOnly: true,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: controller.emailController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: 'Email'),
            readOnly: true,
          ),
        ],
      ),
    );
  }
}

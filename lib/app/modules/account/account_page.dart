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
              BottomNavigationBarItem(icon: Icon(Icons.delivery_dining), label: 'Entregas'),
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
          TextFormField(
            controller: controller.clientIdController,
            decoration: const InputDecoration(labelText: 'Client ID'),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: controller.clientSecretController,
            decoration: const InputDecoration(labelText: 'Client Secret'),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              controller.saveIfoodCredentials().then(
                    (value) => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(value)),
                    ),
                  );
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }
}

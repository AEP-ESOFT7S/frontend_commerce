import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pedidos')),
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
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          children: [
            const Text('Pendentes'),
            SizedBox(
              child: Obx(
                () => ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  itemCount: controller.getPollings.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      onPressed: () {
                        controller.confirm(controller.getPollings[index].orderId);
                      },
                      child: Text(controller.getPollings[index].orderId),
                    );
                  },
                ),
              ),
            ),
            const Text('Confirmados'),
            SizedBox(
              child: Obx(
                () => ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  itemCount: controller.getOrders.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      onPressed: () {
                        controller.confirm(controller.getOrders[index]);
                      },
                      child: Text(controller.getOrders[index]),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

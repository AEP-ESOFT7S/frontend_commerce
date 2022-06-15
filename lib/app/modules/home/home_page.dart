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
        child: Column(
          children: [
            Obx(
              () => Visibility(
                visible: controller.getRegisterCommerceNotificationIsVisible,
                child: Container(
                  color: Colors.redAccent,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(controller.registerCommerceMessage),
                      TextButton(
                        onPressed: () => Get.toNamed('/account'),
                        child: const Text(
                          'Vincular',
                          style: TextStyle(decoration: TextDecoration.underline, inherit: true),
                        ),
                      ),
                      GestureDetector(
                        child: const Icon(Icons.close),
                        onTap: () => controller.setRegisterCommerceNotificationIsVisible = false,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                shrinkWrap: true,
                children: [
                  const Text('Pendentes'),
                  SizedBox(
                    child: Obx(
                      () => ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                        itemCount: controller.getPlaced.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ElevatedButton(
                            onPressed: () {
                              controller.confirm(controller.getPlaced[index].orderId);
                            },
                            child: Text(controller.getPlaced[index].toJson()),
                          );
                        },
                      ),
                    ),
                  ),
                  const Text('Confirmados'),
                  SizedBox(
                    child: Obx(
                      () => ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                        itemCount: controller.getOrders.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ElevatedButton(
                            onPressed: () =>
                                controller.dispatch(controller.getOrders[index].orderId),
                            child: Text(controller.getOrders[index].toString()),
                          );
                        },
                      ),
                    ),
                  ),
                  const Text('Outros'),
                  SizedBox(
                    child: Obx(
                      () => ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                        itemCount: controller.getOthers.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ElevatedButton(
                            onPressed: () =>
                                controller.dispatch(controller.getOthers[index].orderId),
                            child: Text(controller.getOthers[index].toString()),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

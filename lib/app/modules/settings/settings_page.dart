import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './settings_controller.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: ListView(children: [
        ListTile(
          title: const Text('Mapa modo escuro'),
          onTap: () {},
        )
      ]),
    );
  }
}

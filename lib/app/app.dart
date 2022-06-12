import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verydeli_commerce/app/core/theme/themes.dart';
import 'package:verydeli_commerce/app/routes/pages.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.config(enableLog: false, defaultTransition: Transition.noTransition);
    return GetMaterialApp(
      theme: Themes.light,
      getPages: Pages.pages,
      initialRoute: Routes.INITIAL,
    );
  }
}

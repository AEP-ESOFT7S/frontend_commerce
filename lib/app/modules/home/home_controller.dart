import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:verydeli_commerce/app/data/models/polling_response.dart';
import 'package:verydeli_commerce/app/modules/home/home_repository.dart';

class HomeController extends GetxController {
  final HomeRepository _homeRepository = HomeRepository();

  final _storage = GetStorage();

  final deliveryNotificationIsVisible = false.obs;
  get getDeliveryNotificationIsVisible => deliveryNotificationIsVisible.value;
  set setDeliveryNotificationIsVisible(bool value) => deliveryNotificationIsVisible.value = value;

  final toDelivery = [].obs;
  List get getToDelivery => toDelivery.toList();
  set setToDelivery(List value) => toDelivery.value = value;
  addToDelivery(value) => toDelivery.add(value);

  List<PollingResponse> polling = [];

  @override
  void onInit() async {
    String token = '';

    await _homeRepository.authorization().then((value) {
      token = value.result['accessToken'] ?? '';
      _storage.write('accessToken', value.result['accessToken']);
    }).catchError((_) async {
      if (_.message != '') {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(_.message)));
      }
    });

    if (token != '') {
      Timer.periodic(const Duration(seconds: 30), (Timer t) async {
        await _homeRepository.polling().then((value) {
          for (var element in value.result) {
            var values = PollingResponse.fromMap(element);
            polling.add(values);
            // addToDelivery(element['orderId']);
          }
        }).catchError((_) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(_.message)));
        });

        await _homeRepository.acknowledgment(getToDelivery).catchError((_) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(_.message)));
        });
      });
    }

    super.onInit();
  }

  final _index = 0.obs;

  int get getCurrentIndex => _index.value;
  set setCurrentIndex(int value) => _index.value = value;
}

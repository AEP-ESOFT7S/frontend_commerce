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

  final _pollings = <PollingResponse>[].obs;
  List<PollingResponse> get getPollings => _pollings.toList();
  void addPolling(PollingResponse value) {
    getPollings.singleWhere(
      (element) => element.orderId == value.orderId,
      orElse: () {
        _pollings.add(value);
        return value;
      },
    );
  }

  final _orders = [].obs;
  List get getOrders => _orders.toList();
  set setOrders(List value) => _orders.value = value;
  void addOrders(String value) {
    if (_orders.contains(value)) {
      return;
    }
    _orders.add(value);
  }

  @override
  void onInit() async {
    String token = '';

    await _homeRepository.authorization().then((value) {
      token = value.result['accessToken'] ?? '';
      _storage.write('accessToken', value.result['accessToken']);
    }).catchError((_) async {
      if (_.message != '') {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(_.toString())));
      }
    });

    if (token != '') {
      Timer.periodic(const Duration(seconds: 30), (Timer t) async {
        await _homeRepository.polling().then((value) {
          for (var element in value.result) {
            var values = PollingResponse.fromMap(element);
            addPolling(values);
            _storage.write('pollings', getPollings);
            if (values.code == 'CFM') {
              addOrders(values.orderId);
              _storage.write('orders', getOrders);
            }
          }
        }).catchError((_) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(_.message)));
        });

        if (getPollings.isNotEmpty) {
          await _homeRepository.acknowledgment(getPollings).then((value) {}).catchError((erro) {
            ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(erro.message)));
          });
        }
      });
    }

    super.onInit();
  }

  final _index = 0.obs;

  int get getCurrentIndex => _index.value;
  set setCurrentIndex(int value) => _index.value = value;

  Future<void> confirm(String orderId) async {
    await _homeRepository.confirmOrder(orderId).then((value) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(content: Text('Confirmado!')));
    }).catchError((_) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(_.message)));
    });
  }
}

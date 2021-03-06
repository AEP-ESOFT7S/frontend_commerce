import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:verydeli_commerce/app/data/models/polling.dart';
import 'package:verydeli_commerce/app/data/models/user_response.dart';
import 'package:verydeli_commerce/app/modules/home/home_repository.dart';

class HomeController extends GetxController {
  final HomeRepository _homeRepository = HomeRepository();

  final _storage = GetStorage();

  final deliveryNotificationIsVisible = false.obs;
  get getDeliveryNotificationIsVisible => deliveryNotificationIsVisible.value;
  set setDeliveryNotificationIsVisible(bool value) => deliveryNotificationIsVisible.value = value;

  final _registerCommerceNotificationIsVisible = true.obs;
  get getRegisterCommerceNotificationIsVisible => _registerCommerceNotificationIsVisible.value;
  set setRegisterCommerceNotificationIsVisible(bool value) =>
      _registerCommerceNotificationIsVisible.value = value;

  final _index = 0.obs;
  int get getCurrentIndex => _index.value;
  set setCurrentIndex(int value) => _index.value = value;

  final registerCommerceMessage = 'Conta ainda sem vínculo a um comércio!';

  final _placed = <Polling>[].obs;
  List<Polling> get getPlaced => _placed.toList();
  void addPlaced(Polling value) {
    getPlaced.singleWhere(
      (element) => element.orderId == value.orderId,
      orElse: () {
        _placed.add(value);
        return value;
      },
    );
  }

  final _orders = <Polling>[].obs;
  List<Polling> get getOrders => _orders.toList();
  set setOrders(List<Polling> value) => _orders.value = value;
  void addOrders(Polling value) {
    getOrders.singleWhere(
      (element) => element.orderId == value.orderId,
      orElse: () {
        _orders.add(value);
        return value;
      },
    );
  }

  final _others = <Polling>[].obs;
  List<Polling> get getOthers => _others.toList();
  set setOthers(List<Polling> value) => _others.value = value;
  void addOthers(Polling value) {
    getOthers.singleWhere(
      (element) => element.orderId == value.orderId,
      orElse: () {
        _others.add(value);
        return value;
      },
    );
  }

  String _accessToken = '';
  DateTime _expiresAt = DateTime.now().toLocal().subtract(const Duration(seconds: 1));

  @override
  void onInit() async {
    final String userData = _storage.read('userData') ?? '';
    UserResponse user = UserResponse.fromJson(userData);
    setRegisterCommerceNotificationIsVisible = true;
    if (user.clientId != null && user.clientSecret != null && user.merchantId != null) {
      setRegisterCommerceNotificationIsVisible = false;
    }

    final DateTime dateTimeNow = DateTime.now().toLocal();

    _accessToken = _storage.read('accessToken') ?? '';
    _expiresAt = DateTime.parse(_storage.read('expiresAt') ?? _expiresAt.toString());

    if (_accessToken.isEmpty && dateTimeNow.isAfter(_expiresAt)) {
      await _getAuthorization(user);
    }

    await _getPolling(_accessToken);
    await _getAcknowledgment(_accessToken);

    Timer.periodic(const Duration(seconds: 30), (Timer t) async {
      if (_accessToken.isEmpty && dateTimeNow.isAfter(_expiresAt)) {
        await _getAuthorization(user);
      }

      await _getPolling(_accessToken);
      await _getAcknowledgment(_accessToken);
    });

    super.onInit();
  }

  Future<void> _getAuthorization(UserResponse user) async {
    if (user.clientId!.isNotEmpty && user.clientSecret!.isNotEmpty && user.merchantId!.isNotEmpty) {
      await _homeRepository.authorization(user).then((value) {
        final dateTimeNow = DateTime.now().toLocal();

        _accessToken = value.result['accessToken'];
        int expiresIn = value.result['expiresIn'];
        _expiresAt = dateTimeNow.add(Duration(seconds: expiresIn));

        _storage.write('accessToken', _accessToken);
        _storage.write('expiresAt', _expiresAt.toString());
      }).catchError((_) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(_.message)));
      });
    }
  }

  Future<void> _getPolling(String accessToken) async {
    await _homeRepository.polling(accessToken).then((value) async {
      for (var element in value.result) {
        var values = Polling.fromMap(element);

        _generateListToAcknowledgment(values.orderId);

        switch (values.code) {
          case 'PLC':
            addPlaced(values);
            _storage.write('placed', getPlaced);
            break;
          case 'CFM':
            addOrders(values);
            _storage.write('orders', getOrders);
            break;
          case 'CON':
            break;
          case 'CAN':
            break;
          default:
            break;
        }
      }
    }).catchError((_) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(_.message)));
    });
  }

  Future<void> _getAcknowledgment(String accessToken) async {
    if (_toAcknowledgment.isNotEmpty) {
      await _homeRepository
          .acknowledgment(accessToken, _toAcknowledgment)
          .then((value) {})
          .catchError((erro) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(erro.message)));
      });
    }
  }

  Future<void> confirm(String orderId) async {
    await _homeRepository.confirmOrder(orderId).then((value) {
      final List<Polling> listOrders = _storage.read('pollings');

      listOrders.removeWhere((element) => element.orderId == orderId);
      _storage.write('pollings', listOrders);

      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(content: Text('Confirmado!')));
    }).catchError((_) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(_.message)));
    });
  }

  Future<void> dispatch(String orderId) async {
    await _homeRepository.confirmOrder(orderId).then((value) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(content: Text('Dispachado!')));
    }).catchError((_) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(_.message)));
    });
  }

  String _toAcknowledgment = '';

  void _generateListToAcknowledgment(String pollingId) {
    String map = '{"id": "$pollingId"}';
    _toAcknowledgment += _toAcknowledgment.isEmpty ? map : ', $map';
  }
}

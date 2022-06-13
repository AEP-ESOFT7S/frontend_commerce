import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:get_storage/get_storage.dart';
import 'package:verydeli_commerce/app/core/exceptions/rest_client_exception.dart';
import 'package:verydeli_commerce/app/data/models/api_response.dart';
import 'package:verydeli_commerce/app/data/provider/api_provider.dart';
import 'package:verydeli_commerce/app/modules/account/account_controller.dart';

class HomeRepository extends GetConnect {
  final APIProvider _restClient = APIProvider(url: 'https://merchant-api.ifood.com.br');

  final _storage = GetStorage();

  Future<ApiResponse> authorization() async {
    try {
      final credentials = await _storage.read('credentials');

      if (credentials == null) {
        throw RestClientException('Sistema ainda sem vinculo a um comercio!');
      }

      IFoodCredentials? credential = IFoodCredentials.fromJson(credentials);

      final response = await _restClient.postApi(
        '/authentication/v1.0/oauth/token',
        {
          'grantType': 'client_credentials',
          'clientId': credential.clientId,
          'clientSecret': credential.clientSecret,
        },
        contentType: 'application/x-www-form-urlencoded',
      );

      switch (response.statusCode) {
        case HttpStatus.ok:
          return ApiResponse(result: response.body);
        default:
          throw RestClientException('Falha ao registrar usuário!', code: response.statusCode);
      }
    } on RestClientException catch (exception) {
      throw RestClientException(exception.message, code: exception.code);
    }
  }

  Future<ApiResponse> polling() async {
    try {
      final token = _storage.read('accessToken') ?? '';

      final response = await _restClient.getApi(
        '/order/v1.0/events:polling',
        headers: {'authorization': 'Bearer $token'},
        // query: {'types': 'DSP'},
      );

      switch (response.statusCode) {
        case HttpStatus.ok:
          return ApiResponse(result: response.body ?? []);
        case HttpStatus.noContent:
          return ApiResponse(result: response.body ?? []);
        default:
          throw RestClientException('Polling error!', code: response.statusCode);
      }
    } on RestClientException catch (exception) {
      throw RestClientException(exception.message, code: exception.code);
    }
  }

  Future<ApiResponse> acknowledgment(List pollingId) async {
    try {
      final map = [];
      String mapJson = '';
      final token = _storage.read('accessToken') ?? '';

      for (var element in pollingId) {
        map.add({'id': element});
      }

      mapJson = json.encode(map);

      final response = await _restClient.postApi(
        '/order/v1.0/events/acknowledgment',
        mapJson,
        headers: {'authorization': 'Bearer $token'},
      );

      switch (response.statusCode) {
        case HttpStatus.accepted:
          return ApiResponse();
        default:
          throw RestClientException('acknowledgment error!', code: response.statusCode);
      }
    } on RestClientException catch (exception) {
      throw RestClientException(exception.message, code: exception.code);
    }
  }

  Future<ApiResponse> confirmOrder(String orderId) async {
    try {
      final token = _storage.read('accessToken') ?? '';

      final response = await _restClient.postApi(
        '/order/v1.0/orders/$orderId/confirm',
        null,
        headers: {'authorization': 'Bearer $token'},
      );

      switch (response.statusCode) {
        case HttpStatus.accepted:
          return ApiResponse(result: response.body);
        default:
          throw RestClientException('Erro!', code: response.statusCode);
      }
    } on RestClientException catch (exception) {
      throw RestClientException(exception.message, code: exception.code);
    }
  }

  Future<ApiResponse> dispatchOrder(String orderId) async {
    try {
      final token = _storage.read('accessToken') ?? '';

      final response = await _restClient.postApi(
        '/order/v1.0/orders/$orderId/dispatch',
        null,
        headers: {'authorization': 'Bearer $token'},
      );

      switch (response.statusCode) {
        case HttpStatus.accepted:
          return ApiResponse(result: response.body);
        default:
          throw RestClientException('Erro!', code: response.statusCode);
      }
    } on RestClientException catch (exception) {
      throw RestClientException(exception.message, code: exception.code);
    }
  }
}

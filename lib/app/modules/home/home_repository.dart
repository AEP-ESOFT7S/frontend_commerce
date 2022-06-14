import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:get_storage/get_storage.dart';
import 'package:verydeli_commerce/app/core/exceptions/rest_client_exception.dart';
import 'package:verydeli_commerce/app/data/models/api_response.dart';
import 'package:verydeli_commerce/app/data/models/polling_response.dart';
import 'package:verydeli_commerce/app/data/models/register_response.dart';
import 'package:verydeli_commerce/app/data/provider/api_provider.dart';

class HomeRepository extends GetConnect {
  final APIProvider _restClient = APIProvider(url: 'https://merchant-api.ifood.com.br');

  final _storage = GetStorage();

  Future<ApiResponse> authorization() async {
    try {
      final userData = await _storage.read('userData');

      RegisterResponse register = RegisterResponse.fromJson(userData);

      if (register.clientId!.isEmpty && register.clientSecret!.isEmpty) {
        throw RestClientException('Conta ainda sem vínculo a um comércio!', code: 0);
      }

      final response = await _restClient.postApi(
        '/authentication/v1.0/oauth/token',
        {
          'grantType': 'client_credentials',
          'clientId': register.clientId,
          'clientSecret': register.clientSecret,
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
      final String token = _storage.read('accessToken') ?? '';

      final response = await _restClient.getApi(
        '/order/v1.0/events:polling',
        headers: {'authorization': 'Bearer $token'},
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

  Future<ApiResponse> acknowledgment(List<PollingResponse> pollings) async {
    try {
      String json = '';
      for (var element in pollings) {
        var map = '{"id": "${element.id}"}';
        json += json.isEmpty ? map : ', $map';
      }

      final token = _storage.read('accessToken') ?? '';

      final response = await _restClient.postApi(
        '/order/v1.0/events/acknowledgment',
        '[$json]',
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
          return ApiResponse(result: response.body, message: response.statusText!);
        default:
          throw RestClientException('Erro ao confirmar pedido!', code: response.statusCode);
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

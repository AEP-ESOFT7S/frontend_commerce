import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:get_storage/get_storage.dart';
import 'package:verydeli_commerce/app/core/exceptions/rest_client_exception.dart';
import 'package:verydeli_commerce/app/data/models/api_response.dart';
import 'package:verydeli_commerce/app/data/models/user_response.dart';
import 'package:verydeli_commerce/app/data/provider/api_provider.dart';

class HomeRepository extends GetConnect {
  final APIProvider _restClient = APIProvider(url: 'https://merchant-api.ifood.com.br');

  final _storage = GetStorage();

  Future<ApiResponse> authorization(UserResponse user) async {
    try {
      final response = await _restClient.post(
        '/authentication/v1.0/oauth/token',
        {
          'grantType': 'client_credentials',
          'clientId': user.clientId,
          'clientSecret': user.clientSecret,
        },
        contentType: 'application/x-www-form-urlencoded',
      );

      switch (response.statusCode) {
        case HttpStatus.ok:
          return ApiResponse(result: response.body);
        default:
          throw RestClientException('Falha ao autorizar usuário!', code: response.statusCode);
      }
    } on RestClientException catch (exception) {
      throw RestClientException(exception.message, code: exception.code);
    }
  }

  Future<ApiResponse> polling(String accessToken) async {
    try {
      final response = await _restClient.get(
        '/order/v1.0/events:polling',
        headers: {
          'authorization': 'Bearer $accessToken',
          // 'merchantId': merchantId,
        },
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

  Future<ApiResponse> acknowledgment(String accessToken, String pollings) async {
    try {
      final response = await _restClient.post(
        '/order/v1.0/events/acknowledgment',
        '[$pollings]',
        headers: {'authorization': 'Bearer $accessToken'},
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

      final response = await _restClient.post(
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

      final response = await _restClient.post(
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

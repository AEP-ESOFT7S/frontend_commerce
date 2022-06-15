import 'package:get/get_connect.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:verydeli_commerce/app/core/exceptions/rest_client_exception.dart';
import 'package:verydeli_commerce/app/data/models/api_response.dart';
import 'package:verydeli_commerce/app/data/provider/api_provider.dart';

class RegisterRepository extends GetConnect {
  final APIProvider _restClient = APIProvider();

  Future<ApiResponse> register(String registerData) async {
    try {
      final response = await _restClient.post('/users', registerData);

      switch (response.statusCode) {
        case HttpStatus.ok:
          return ApiResponse(message: 'Usuário cadastrado com sucesso!');
        case HttpStatus.created:
          return ApiResponse(message: 'Usuário cadastrado com sucesso!');
        default:
          throw RestClientException('Falha ao registrar usuário!', code: response.statusCode);
      }
    } on RestClientException catch (_) {
      throw RestClientException(_.message, code: _.code);
    }
  }
}

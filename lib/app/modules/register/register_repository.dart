import 'package:get/get_connect.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:verydeli_commerce/app/core/exceptions/rest_client_exception.dart';
import 'package:verydeli_commerce/app/data/models/api_response.dart';
import 'package:verydeli_commerce/app/data/models/register_request.dart';
import 'package:verydeli_commerce/app/data/provider/api_provider.dart';

class RegisterRepository extends GetConnect {
  final APIProvider _restClient = APIProvider();

  Future<ApiResponse> register(RegisterRequest registerData) async {
    try {
      final response = await _restClient.postApi('/register', registerData.toJson());

      if (response.statusCode != HttpStatus.created) {
        throw RestClientException('Falha ao registrar usuário!', code: response.statusCode);
      }

      return ApiResponse(message: 'Usuário cadastrado com sucesso!');
    } on RestClientException catch (_) {
      return ApiResponse(message: _.message);
    }
  }
}

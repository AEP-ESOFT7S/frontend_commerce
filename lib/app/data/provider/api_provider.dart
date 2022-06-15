import 'package:get/get.dart';
import 'package:verydeli_commerce/app/core/settings/settings.dart';

class APIProvider extends GetConnect {
  APIProvider({String? url}) {
    httpClient.baseUrl = url ?? Settings.baseUrl;
  }

  Future<Response> getApi(String path, {Map<String, String>? headers, Map<String, String>? query}) {
    return get(path, headers: headers, query: query);
  }

  Future<Response> postApi(String path, dynamic data,
          {Map<String, String>? headers, String? contentType}) =>
      post(path, data, headers: headers, contentType: contentType);
}

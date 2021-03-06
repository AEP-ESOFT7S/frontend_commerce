class RestClientException implements Exception {
  final int? code;
  final String message;

  RestClientException(this.message, {this.code});

  @override
  String toString() => 'code: $code, message: $message';
}

class ApiResponse<T> {
  T? result;
  bool error;
  String message;
  String? messageType;

  ApiResponse({
    this.result,
    this.error = false,
    this.message = '',
    this.messageType = '',
  }) {
    if (message.isNotEmpty && messageType!.isNotEmpty && messageType!.toLowerCase() == "danger") {
      error = true;
    }
  }
}

class GeneralException implements Exception {
  GeneralException(this.message, this.code, this.stackTrace);
  String message;
  String code;
  StackTrace stackTrace;

  @override
  String toString() {
    return 'GeneralException: { "message" : "$message", "code" : "$code" }';
  }
}

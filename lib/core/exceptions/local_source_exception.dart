class LocalSourceException implements Exception {
  LocalSourceException(this.message, this.cause);
  final String message;
  final Object cause;

  @override
  String toString() => '$message: $cause';
}

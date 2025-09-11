class RepositoryException implements Exception {
  RepositoryException(this.message, this.cause);
  final String message;
  final Object cause;

  @override
  String toString() => '$message: $cause';
}

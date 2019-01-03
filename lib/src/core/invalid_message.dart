
class InvalidMessageException implements Exception {

  final String errorMessage;

  final Object invalidMessage;

  const InvalidMessageException(this.errorMessage, [this.invalidMessage]);
}
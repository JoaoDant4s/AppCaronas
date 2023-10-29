class AuthException extends Error {
  final String message;

  AuthException(this.message);

  @override
  String toString() {
    return message;
  }
}

class UserDataException extends Error {
  final String message;

  UserDataException(this.message);

  @override
  String toString() {
    return message;
  }
}

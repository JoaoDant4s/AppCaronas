class CarException extends Error {
  final String message;

  CarException(this.message);

  @override
  String toString() {
    return message;
  }
}

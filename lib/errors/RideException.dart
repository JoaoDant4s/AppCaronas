class RideException extends Error {
  final String message;

  RideException(this.message);

  @override
  String toString() {
    return message;
  }
}

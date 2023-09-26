class User {
  String id;
  String origin;
  String destiny;
  DateTime date;
  double price;
  int seats;
  int availableSeats;

  User(
      {required this.id,
        required this.origin,
        required this.destiny,
        required this.date,
        required this.price,
        required this.seats,
        required this.availableSeats});
}

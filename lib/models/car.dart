class Car {
  String id;
  String model;
  String licensePlate;
  int age;
  int availableSeats;
  String color;
  String brand;
  String userID;

  Car({
    required this.id,
    required this.model,
    required this.licensePlate,
    required this.age,
    required this.availableSeats,
    required this.color,
    required this.brand,
    required this.userID,
  });

  Car.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        model = map['model'],
        licensePlate = map['licensePlate'],
        age = map['age'],
        availableSeats = map['availableSeats'],
        color = map['color'],
        brand = map['brand'],
        userID = map['userID'];
}

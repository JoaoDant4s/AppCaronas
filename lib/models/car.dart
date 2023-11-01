
import 'package:cloud_firestore/cloud_firestore.dart';

class Car {
  String? id;
  String model;
  String licensePlate;
  int year;
  int availableSeats;
  String color;
  String brand;
  String userID;

  Car({
    this.id,
    required this.model,
    required this.licensePlate,
    required this.year,
    required this.availableSeats,
    required this.color,
    required this.brand,
    required this.userID,
  });

  factory Car.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Car(
      id: snapshot.id,
      model: data?['model'],
      licensePlate: data?['licensePlate'],
      year: data?['year'],
      availableSeats: data?['availableSeats'],
      color: data?['color'],
      brand: data?['brand'],
      userID: data?['userID'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'model': model,
      'licensePlate': licensePlate,
      'year': year,
      'availableSeats': availableSeats,
      'color': color,
      'brand': brand,
      'userID': userID,
    };
  }

  setId(String id) {
    this.id = id;
  }

  Car.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        model = map['model'],
        licensePlate = map['licensePlate'],
        year = map['year'],
        availableSeats = map['availableSeats'],
        color = map['color'],
        brand = map['brand'],
        userID = map['userID'];
}

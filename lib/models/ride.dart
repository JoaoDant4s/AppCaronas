import 'package:cloud_firestore/cloud_firestore.dart';

class Ride {
  String id;
  String origin;
  String destiny;
  DateTime date;
  double price;
  String driverID;
  List<String> participants;
  int seats;

  Ride({
    required this.id,
    required this.driverID,
    required this.participants,
    required this.origin,
    required this.destiny,
    required this.date,
    required this.price,
    required this.seats,
  });

  factory Ride.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Ride(
      id: snapshot.id,
      origin: data?['origin'],
      driverID: data?['driverID'],
      participants: (data?['participants'] as List<dynamic>).cast<String>(),
      destiny: data?['destiny'],
      date: (data?['date'] as Timestamp).toDate(),
      price: data?['price'],
      seats: data?['seats'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'origin': origin,
      'driverID': driverID,
      'participants': participants,
      'destiny': destiny,
      'date': date,
      'price': price,
      'seats': seats
    };
  }

  setId(String id) {
    this.id = id;
  }

  Ride.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        origin = map['origin'],
        driverID = map['driverID'],
        participants = map['participants'],
        destiny = map['destiny'],
        date = map['date'],
        price = map['price'],
        seats = map['seats'];
}

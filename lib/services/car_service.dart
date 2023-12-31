import 'package:caronas/errors/CarException.dart';
import 'package:caronas/firebase_db.dart';
import 'package:caronas/models/car.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> createCar(Car car) async {
  try {
    final docRef = db
        .collection("car")
        .withConverter(
          fromFirestore: Car.fromFirestore,
          toFirestore: (Car car, options) => car.toFirestore(),
        )
        .doc();
    await docRef.set(car);
    return docRef.id;
  } on FirebaseException catch (e) {
    throw CarException("Error registering a car");
  }
}

Future<Car?> getCar(String uid) async {
  final carsRef = db.collection("car");

  final query = carsRef.where("userID", isEqualTo: uid).withConverter(
        fromFirestore: Car.fromFirestore,
        toFirestore: (Car car, _) => car.toFirestore(),
      );
  Car? car;
  final docSnapshot = await query.get();
  if (docSnapshot.size != 0) {
    car = docSnapshot.docs.first.data();
  }
  return car;
}

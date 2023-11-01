import 'package:caronas/errors/RideException.dart';
import 'package:caronas/firebase_db.dart';
import 'package:caronas/models/ride.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> createRide(Ride ride) async {
  try {
    final docRef = db
        .collection("rides")
        .withConverter(
          fromFirestore: Ride.fromFirestore,
          toFirestore: (Ride ride, options) => ride.toFirestore(),
        )
        .doc();
    await docRef.set(ride);
    return docRef.id;
  } on FirebaseException catch (e) {
    throw RideException("Error creating a ride");
  }
}

Future<Ride?> getRide(String rideId) async {
  final ridesRef = db.collection("rides");

  final ride = await ridesRef.doc(rideId).withConverter(
        fromFirestore: Ride.fromFirestore,
        toFirestore: (Ride ride, _) => ride.toFirestore(),
      ).get();
  if (ride.exists) {
    return ride.data();
  }
  return null;
}

Future<List<Ride>> getAllRides() async {
  final ridesRef = FirebaseFirestore.instance.collection("rides");

  final query = await ridesRef.withConverter(
    fromFirestore: Ride.fromFirestore,
    toFirestore: (Ride ride, _) => ride.toFirestore(),
  ).get();

  List<Ride> rides = [];

  for (final doc in query.docs) {
    final ride = doc.data();
    rides.add(ride);
  }

  return rides;
}

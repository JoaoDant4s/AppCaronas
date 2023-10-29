import 'package:caronas/models/car.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  String? id;
  String email;
  String? password;
  String name;
  String gender;
  DateTime birth;
  String image;
  double rating;
  Car? car;

  AppUser({
    this.id,
    required this.email,
    this.password,
    required this.birth,
    required this.gender,
    required this.name,
    required this.image,
    required this.rating,
    required this.car,
  });

  setId(String id) {
    this.id = id;
  }

  setImage(String imageURL) {
    image = imageURL;
  }

  factory AppUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return AppUser(
      email: data?['email'],
      birth: data?['birth'],
      name: data?['name'],
      gender: data?['gender'],
      image: '',
      rating: data?['rating'],
      car: data?['car'] ?? {},
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "email": email,
      "birth": birth,
      "gender": gender,
      "image": image,
      "rating": rating,
      if (car != null) "car": car,
    };
  }
}

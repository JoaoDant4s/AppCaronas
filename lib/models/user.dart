import 'dart:io';

class User {
  String id;
  String email;
  String name;
  String gender;
  DateTime birth;
  String password;
  File? image;
  double rating;

  User({
    required this.id,
    required this.email,
    required this.birth,
    required this.gender,
    required this.name,
    required this.password,
    required this.image,
    required this.rating,
  });
}

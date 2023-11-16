import 'package:caronas/errors/AuthException.dart';
import 'package:caronas/errors/FirebaseErrors.dart';
import 'package:caronas/errors/UserDataException.dart';
import 'package:caronas/firebase_db.dart';
import 'package:caronas/models/app_user.dart';
import 'package:caronas/models/car.dart';
import 'package:caronas/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../errors/CarException.dart';

class AuthService extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser? _user;

  AppUser? get user => _user;

  var userIsAuthenticated = false;

  AuthService() {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        AppUser? appUser =
            await getUserDataByUID(user.uid.characters.toString());
        if (appUser != null) {
          _user = appUser;
          userIsAuthenticated = true;
        }
      } else {
        userIsAuthenticated = false;
      }
      notifyListeners();
    });
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw AuthException(getErrorMessage(e.code));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> createUser(AppUser user, XFile? image) async {
    try {
      final userCreated = await _auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password!);
      User? authUser = userCreated.user;
      if (authUser != null) {
        String uid = authUser.uid.characters.toString();
        await createUserData(user, uid, image);
      }
    } on FirebaseAuthException catch (e) {
      throw AuthException(getErrorMessage(e.code));
    } catch (e) {
      throw AuthException("Error on creating user");
    }
  }

  Future<void> deleteCarFromFirestore(String carId) async {
    try {
      await db.collection('car').doc(carId).delete();
    } catch (e) {
      throw CarException("Error deleting car: $e");
    }
    notifyListeners();
  }

  Future<void> updateCarInFirestore(Car car) async {
    try {
      if (car.id != null) {
        await db.collection('car').doc(car.id!).update({
          'brand': car.brand,
          'model': car.model,
          'year': car.year,
          'licensePlate': car.licensePlate,
          'color': car.color,
          'availableSeats': car.availableSeats,
        });
      }
    } catch (error) {
      throw CarException("Error updating the car: $error");
    }
  }

  void setCar(Car createdCar) async {
    _user!.car = createdCar;
    notifyListeners();
  }

  Future<void> updateUser(AppUser user) async {
    try {
      final docRef = db.collection('user').doc(user.id);

      await docRef.update({
        "name": user.name,
        "gender": user.gender,
        "birth": user.birth,
      });
    } on FirebaseException catch (e) {
      throw UserDataException("Error uploading user data");
    }
    notifyListeners();
  }
}

import 'package:caronas/errors/AuthException.dart';
import 'package:caronas/errors/FirebaseErrors.dart';
import 'package:caronas/models/app_user.dart';
import 'package:caronas/models/car.dart';
import 'package:caronas/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  void setCar(Car createdCar) async {
    _user!.car = createdCar;
    notifyListeners();
  }
}

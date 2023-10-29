import 'dart:io';

import 'package:caronas/errors/AuthException.dart';
import 'package:caronas/errors/FirebaseErrors.dart';
import 'package:caronas/models/app_user.dart';
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
    _auth.authStateChanges().listen((user) {
      print("dentro do authStateChanges");
      // if (user != null) {
      //   _user = user;
      //   userIsAuthenticated = true;
      // } else {
      //   userIsAuthenticated = false;
      // }
      // notifyListeners();
      print("teste");
    });
  }

  Future<String> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return 'User created successfuly';
    } catch (e) {
      return e.toString();
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
}

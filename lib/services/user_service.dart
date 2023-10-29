import 'dart:io';

import 'package:caronas/errors/UserDataException.dart';
import 'package:caronas/firebase_db.dart';
import 'package:caronas/firebase_storage.dart';
import 'package:caronas/models/app_user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

Future<void> createUserData(AppUser user, String uid, XFile? image) async {
  String? downloadURL;
  if (image != null) {
    downloadURL = await uploadPhoto(image.path, uid);
  }
  try {
    if (downloadURL != null) {
      user.setImage(downloadURL);
    }
    final docRef = db
        .collection("user")
        .withConverter(
          fromFirestore: AppUser.fromFirestore,
          toFirestore: (AppUser user, options) => user.toFirestore(),
        )
        .doc(uid);
    await docRef.set(user);
  } on FirebaseException catch (e) {
    throw UserDataException("Error creating user data");
  }
}

Future<AppUser?> getUserDataByUID(String uid) async {
  try {
    final docRef = db.collection("user").doc(uid).withConverter(
          fromFirestore: AppUser.fromFirestore,
          toFirestore: (AppUser user, _) => user.toFirestore(),
        );
    final docSnapshot = await docRef.get();
    AppUser? appUser = docSnapshot.data();
    return appUser;
  } on FirebaseException catch (e) {
    throw UserDataException("Error fetching user data");
  }
}

Future<String> uploadPhoto(String path, String uid) async {
  File file = File(path);

  try {
    String ref = 'user_profile_images/img-$uid.jpg';
    Reference storageRef = storage.ref(ref);
    await storageRef.putFile(file);

    return storageRef.getDownloadURL();
  } on FirebaseException catch (e) {
    throw UserDataException("Error uploading user image");
  }
}

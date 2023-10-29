import 'package:caronas/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AppUser? _getUser(User? user){
    print(user);
    // return user != null ? AppUser(id: user.id, email: user.email, birth: user.birth, gender: user.gender, name: name, password: password, image: image, rating: rating, car: car)
  }

  User? get currentUser => _firebaseAuth.currentUser;
  
  Stream<AppUser?> get authStateChanges => _firebaseAuth.authStateChanges().map((user) => _getUser(user));

  Future<void> signInWithEmailAndPassword({
    required email,
    required password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

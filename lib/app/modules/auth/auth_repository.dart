import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth auth;

  AuthRepository(this.auth, {authInstance});

  Future<String> login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'O e-mail não foi encontrado';
      } else if (e.code == 'wrong-password') {
        return 'E-mail ou senha incorretos';
      }
    }
    return '';
  }

  Future<bool> logged() async {
    return auth.currentUser != null ? true : false;
  }

  Future<UserCredential> signInWithGoogle() async {
    UserCredential? userCredential;
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider.addScope('email');
    googleProvider.setCustomParameters({
      'login_hint': 'user@example.com'
    });
    try {
      userCredential = await FirebaseAuth.instance.signInWithPopup(googleProvider);
      log(userCredential.user!.email.toString());
    } on Exception catch (e) {
      // TODO
    }
    return userCredential!;
  }
}

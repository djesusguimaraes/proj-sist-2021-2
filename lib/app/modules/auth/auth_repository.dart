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
    return "";
  }

  Future<UserCredential> signInWithFacebook() async {
    // Create a new provider
    FacebookAuthProvider facebookProvider = FacebookAuthProvider();

    facebookProvider.addScope('email');
    facebookProvider.setCustomParameters({
      'display': 'popup',
    });

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithPopup(facebookProvider);

    // Or use signInWithRedirect
    // return await FirebaseAuth.instance.signInWithRedirect(facebookProvider);
  }

  Future<UserCredential> signInWithGoogle() async {
    UserCredential? userCredential;
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider.addScope('email');
    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
    try {
      userCredential =
          await FirebaseAuth.instance.signInWithPopup(googleProvider);
      log(userCredential.user!.email.toString());
    } on Exception catch (e) {
      // TODO
    }
    return userCredential!;
  }
}

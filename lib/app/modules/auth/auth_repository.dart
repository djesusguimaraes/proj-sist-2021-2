import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth auth;

  AuthRepository(this.auth);

  Future<String> login(String email, String password) async {
    UserCredential? userCredential;
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: "barry.allen@example.com", password: "SuperSecretPassword!");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'O e-mail não foi encontrado';
      } else if (e.code == 'wrong-password') {
        return 'E-mail ou senha incorretos';
      }
    }
    return userCredential!.user!.uid;
  }

  Future<UserCredential> signInWithGoogle() async {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider.addScope('email');
    googleProvider.setCustomParameters({
      'login_hint': 'user@example.com'
    });
    return await FirebaseAuth.instance.signInWithPopup(googleProvider);
  }
}

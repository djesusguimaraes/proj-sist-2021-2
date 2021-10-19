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
}

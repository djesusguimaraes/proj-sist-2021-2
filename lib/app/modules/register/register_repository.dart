import 'package:firebase_auth/firebase_auth.dart';

class RegisterRepository {
  final FirebaseAuth auth;

  RegisterRepository(this.auth);

  Future verifyNumberForWeb(String phoneNumber) async {
    return await auth.signInWithPhoneNumber(phoneNumber,

    );
  }

  Future<bool> verifyCodeForWeb(
      ConfirmationResult? confirmationResult, String code) async {
    try {
      final UserCredential? userCredential =
          await confirmationResult?.confirm(code);
      return userCredential?.user != null ? true : false;
    } catch (e) {
      throw Exception('Codigo invalido');
    }
  }
}

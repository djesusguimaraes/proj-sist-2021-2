import 'package:firebase_auth/firebase_auth.dart';

class RegisterRepository {
  final FirebaseAuth auth;

  RegisterRepository(this.auth);

  Future verifyNumberForWeb(String phoneNumber) async {
    return await auth.signInWithPhoneNumber('+55' + phoneNumber,
        RecaptchaVerifier(
          onSuccess: () => print('reCAPTCHA Completed!'),
          onError: (FirebaseAuthException error) => print(error),
          onExpired: () => print('reCAPTCHA Expired!'),
        ),
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

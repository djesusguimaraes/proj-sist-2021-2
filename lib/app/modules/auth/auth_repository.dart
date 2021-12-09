import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pscomidas/app/global/models/entities/delivery_at.dart';
import 'package:pscomidas/app/modules/auth/auth_service.dart';

class AuthRepository extends AuthService {
  final FirebaseAuth auth;

  AuthRepository(this.auth, {authInstance});
  final userCollection = FirebaseFirestore.instance.collection('users');
  final clientsCollection = FirebaseFirestore.instance.collection('clients');

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      UserCredential user = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseAuth.instance.currentUser!;
      if (!user.user!.emailVerified) {
        user.user!.sendEmailVerification();
      }
      final response = await userCollection
          .doc(user.user!.uid)
          .get()
          .then((value) => value.data());
      return {
        'user': user,
        'isClient': response!['isClient'],
        'delivery_at': response['delivery_at']
      };
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw e.code;
      } else if (e.code == 'wrong-password' || e.code == 'invalid-email') {
        throw Exception('E-mail ou senha incorretos');
      }
      throw Exception('Houve um erro desconhecido ao tentar fazer login.');
    }
  }

  @override
  Future<DeliveryAt> fetchDeliveryAt(String uid) async {
    try {
      final response =
          await clientsCollection.doc(uid).get().then((value) => value.data());
      return DeliveryAt.fromMap(map: response!);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<UserCredential> signInWithFacebook() async {
    FacebookAuthProvider facebookProvider = FacebookAuthProvider();

    facebookProvider.addScope('email');
    facebookProvider.setCustomParameters({'display': 'popup'});
    try {
      return await FirebaseAuth.instance.signInWithPopup(facebookProvider);
    } on Exception catch (_) {
      throw Exception("Houve um erro ao tentar entrar no Facebook");
    }
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider.addScope('email');
    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
    try {
      return await FirebaseAuth.instance.signInWithPopup(googleProvider);
    } on Exception catch (_) {
      throw Exception('Houve um erro ao fazer login com Google');
    }
  }
}

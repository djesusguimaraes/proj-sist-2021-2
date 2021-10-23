import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../auth_store.dart';

class VerifyScreen extends StatefulWidget {
  static String get routeName => '/verify-email';
  const VerifyScreen({Key? key}) : super(key: key);

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final AuthStore store = Modular.get();
  final auth = FirebaseAuth.instance;
  late Timer timer;

  List<ReactionDisposer> disposers = [];

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      store.checkEmailVerified();
    });
    disposers.add(
      reaction(
        (_) => store.emailVerified == true,
        (_) => Navigator.pushNamed(context, '/'),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    for (var i = 0; i <= disposers.length; i++) {
      dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
            'Um link de verificação foi enviado para o seu email. Por favor, cheque a sua caixa de entrada!'),
      ),
    );
  }
}

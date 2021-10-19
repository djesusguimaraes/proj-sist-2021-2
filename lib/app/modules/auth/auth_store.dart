import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pscomidas/app/modules/auth/auth_repository.dart';


part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  final AuthRepository _authRepository;

  _AuthStoreBase(this._authRepository);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @observable
  String errorMessage = '';

  @action
  Future<String> login() async {
    try {
      await _authRepository.login(
          emailController.text, passwordController.text);
    } catch (e) {
      errorMessage = e.toString();
    }
    return errorMessage;
  }

  @action
  Future<UserCredential> signInWithGoogle() async {
    try {
      final response = await _authRepository.login(
          emailController.text, passwordController.text);
    } catch (e) {
      errorMessage = e.toString();
    }
    throw 'error';
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:pscomidas/app/modules/register/register_repository.dart';

part 'register_store.g.dart';

class RegisterStore = _RegisterStoreBase with _$RegisterStore;

abstract class _RegisterStoreBase with Store {
  final _repository = Modular.get<RegisterRepository>();

  TextEditingController phoneController = TextEditingController();
  TextEditingController otpCodeController = TextEditingController();

  @observable
  ConfirmationResult? confirmationResult;

  @observable
  bool? validatorPhone = false;

  @observable
  String errorPhone = '';

  @action
  Future<void> sendVerifyCode() async {
    confirmationResult =
    await _repository.verifyNumberForWeb(phoneController.text);
  }

  @action
  Future<void> verifyCode() async {
    try {
      validatorPhone =
      await _repository.verifyCodeForWeb(confirmationResult, otpCodeController.text);
    } catch (e) {
      errorPhone = e.toString();
    }
  }

}
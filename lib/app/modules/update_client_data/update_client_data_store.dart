import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:pscomidas/app/global/models/entities/cliente.dart';
import 'package:pscomidas/app/modules/register_client/pages/confirm_phone/confirm_phone_page.dart';
import 'package:pscomidas/app/modules/register_client/register_client_repository.dart';
import 'package:pscomidas/app/modules/update_client_data/update_client_data_service_firestore.dart';

part 'update_client_data_store.g.dart';

class UpdateClientDataStore = _UpdateClientDataStoreBase
    with _$UpdateClientDataStore;

abstract class _UpdateClientDataStoreBase with Store {
  final _registerRepository = Modular.get<RegisterClientRepository>();
  final _updateClientData = Modular.get<UpdateClientServiceFirestore>();

  TextEditingController nameController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  @observable
  ConfirmationResult? confirmationResult;

  @observable
  bool?
      hasChanged; //tem que verificar se algum dos controllers foi alterado pra n fazer query no banco sem necessidade (falta implementar essa funcionalidade)

  @observable
  bool? validatorPhone;

  @observable
  String? errorPhone;

  @observable
  String? errorMessage;

  @observable
  bool updated = false;

  @action
  Future<void> sendVerifyCode() async {
    confirmationResult =
        await _registerRepository.verifyNumberForWeb(phoneController.text);
  }

  @action
  Future<void> verifyCode() async {
    try {
      validatorPhone = await _registerRepository.verifyCodeForWeb(
          confirmationResult, codeController.text);
    } catch (e) {
      errorPhone = e.toString();
    }
  }

  Future<void> checkData() async {
    if (await _registerRepository.checkData(
        emailController.text, phoneController.text, cpfController.text)) {
      goToConfirmPhone();
    } else {
      errorMessage =
          'Os dados pertencem a outra conta. Tente fazer login, ou corrigir os dados.';
    }
  }

  void goToConfirmPhone() async {
    await sendVerifyCode();
    Modular.to.navigate(ConfirmPhonePage.routeName);
  }

  @action
  Future<void> updateClientData() async {
    try {
      Cliente user = Cliente(
        name: nameController.text,
        cpf: cpfController.text,
        email: emailController.text,
        phone: phoneController.text,
      );
      updated = await _updateClientData.updateClient(user);
    } catch (e) {
      throw Exception(
          'Não foi possível atualizar seus dados. Tente novamente!');
    }
  }

  @action
  Future<void> getClientData() async {
    try {
      Cliente user = await _updateClientData.getClientData();
      nameController.text = user.name;
      cpfController.text = user.cpf;
      emailController.text = user.email;
      phoneController.text = user.phone;
    } catch (e) {
      throw Exception('Não foi possível pegar os dados.');
    }
  }
}

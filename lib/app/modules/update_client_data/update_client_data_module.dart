import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pscomidas/app/global/repositories/update_client_data/update_client_data_repository.dart';
import 'package:pscomidas/app/global/utils/auth_guard.dart';
import 'package:pscomidas/app/modules/register_client/register_client_repository.dart';
import 'package:pscomidas/app/modules/update_client_data/pages/confirm_new_phone_page.dart';
import 'package:pscomidas/app/modules/update_client_data/update_client_data_store.dart';

import 'pages/update_client_data_page.dart';

class UpdateClientDataModule extends Module {
  static String get routeName => '/update';
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => UpdateClientDataStore()),
    Bind.lazySingleton((i) => RegisterClientRepository(FirebaseAuth.instance)),
    Bind.lazySingleton((i) => UpdateClientRepository()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: (_, args) => const UpdateClientDataPage(),
        guards: [AuthGuard(false)]),
    ChildRoute(ConfirmNewPhonePage.routeName,
        child: (_, args) => const ConfirmNewPhonePage()),
  ];
}

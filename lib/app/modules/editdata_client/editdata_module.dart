import 'package:flutter_modular/flutter_modular.dart';

import 'package:pscomidas/app/modules/edit_data_client_page.dart';

class EditDataClientModule extends Module {
  static String get routeName => '/edit';
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => EditDataRepository()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const EditDataClientPage()),
  ];
}

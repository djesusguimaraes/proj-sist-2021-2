import 'package:flutter_modular/flutter_modular.dart';
import 'package:pscomidas/app/global/utils/auth_guard.dart';
import 'package:pscomidas/app/global/widgets/not_found/not_found_page.dart';
import 'package:pscomidas/app/modules/home/home_page.dart';
import 'package:pscomidas/app/modules/home/pages/mobile_search_page.dart';
import '/app/modules/home/store/home_store.dart';

class HomeModule extends Module {
  static String get routeName => '/';
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const HomePage()),
    ChildRoute(MobileSearchPage.routeName,
        child: (_, args) => const MobileSearchPage()),
    WildcardRoute(child: (context, args) => const NotFoundPage()),
  ];
}

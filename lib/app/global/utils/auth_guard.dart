import 'package:flutter_modular/flutter_modular.dart';
import 'package:pscomidas/app/modules/auth/auth_store.dart';

class AuthGuard extends RouteGuard {
  AuthGuard(this.notClient) : super('/login');
  final bool notClient;

  @override
  Future<bool> canActivate(String path, ModularRoute router) {
    return notClient
        ? Modular.get<AuthStore>().isNotClient
        : Modular.get<AuthStore>().isClient;
  }
}

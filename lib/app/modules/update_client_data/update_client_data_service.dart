import 'package:http/http.dart';
import 'package:pscomidas/app/global/models/entities/cliente.dart';

abstract class UpdateClientService {
  Future<void> updateClient(Cliente client);
  Future<Cliente> getClientData();
}

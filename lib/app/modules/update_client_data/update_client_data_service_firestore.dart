import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:pscomidas/app/global/models/entities/cliente.dart';
import 'package:pscomidas/app/modules/update_client_data/update_client_data_service.dart';

final clientsCollection = FirebaseFirestore.instance.collection('users');
final currentUser = FirebaseAuth.instance.currentUser;

class UpdateClientServiceFirestore extends UpdateClientService {
  @override
  Future<void> updateClient(Cliente client) async {
    try {
      await clientsCollection.where('cpf', isEqualTo: client.cpf).get().then(
            (value) => clientsCollection.doc().set(
              {
                'name': client.name,
                'email': client.email,
                'cpf': client.cpf,
                'phone': client.phone,
              },
            ),
          );
    } catch (e) {
      throw Exception('Não foi possível atualizar os dados do cliente.');
    }
  }

  @override
  Future<Cliente> getClientData() async {
    var clientData;
    try {
      await clientsCollection.doc(currentUser!.uid).get().then(
            (value) => clientData = Cliente(
                name: value['name'],
                cpf: value['cpf'],
                email: value['email'],
                phone: value['phone']),
          );
    } catch (e) {
      throw Exception('Não foi possível obter os dados do cliente.');
    }
    return clientData;
  }
}

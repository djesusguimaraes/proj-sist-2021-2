import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pscomidas/app/global/models/entities/cliente.dart';
import 'package:pscomidas/app/modules/update_client_data/update_client_data_service.dart';

final userCollection = FirebaseFirestore.instance.collection('users');
final clientsCollection = FirebaseFirestore.instance.collection('clients');
final currentUser = FirebaseAuth.instance.currentUser;
final String uid = currentUser!.uid;

class UpdateClientServiceFirestore extends UpdateClientService {
  @override
  Future<bool> updateClient(Cliente client) async {
    try {
      await userCollection.doc(uid).set(
        {
          'name': client.name,
          'email': client.email,
          'phone': client.phone,
        },
      );
      await clientsCollection.doc(uid).set({
        'cpf': client.cpf,
      });
      currentUser!.updateEmail(client.email);
    } catch (e) {
      throw Exception('Não foi possível atualizar os dados do cliente.');
    }
    return true;
  }

  @override
  Future<Cliente> getClientData() async {
    // ignore: prefer_typing_uninitialized_variables
    var clientData;
    try {
      var clientCpf = await clientsCollection.doc(uid).get();
      await userCollection.doc(uid).get().then(
            (value) => clientData = Cliente(
              name: value['name'],
              cpf: clientCpf['cpf'],
              email: value['email'],
              phone: value['phone'],
            ),
          );
      return clientData;
    } catch (e) {
      throw Exception('Não foi possível obter os dados do cliente.');
    }
  }
}

import 'dart:collection';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pscomidas/app/global/models/entities/delivery_at.dart';
import 'package:search_cep/search_cep.dart';

final clientCollection = FirebaseFirestore.instance.collection('clients');
final addressCollection = FirebaseFirestore.instance.collection('address');
final currentUser = FirebaseAuth.instance.currentUser;

class ClientAddressRepository {
  Future<void>? fetchCEP(String cep) async {
    try {
      final viaCep = ViaCepSearchCep();
      final infoCepJson = await viaCep.searchInfoByCep(cep: cep);
      print(infoCepJson);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<DeliveryAt>> fetchAddresses() async {
    late List address;
    List<DeliveryAt> addresses = [];
    int i = 0;
    try {
      await clientCollection
          .doc(currentUser!.uid)
          .get()
          .then((doc) => address = doc.data()!['address']);
      for (var element in address) {
        await addressCollection
            .doc(element)
            .get()
            .then((value) => addresses.add(DeliveryAt.fromMap(value.data()!)));
        addresses[i].id = element;
        i += 1;
      }
      return addresses;
    } catch (e) {
      throw Exception('Não foi possível recolher os dados de endereço');
    }
  }

  Future<void> updateAddress(DeliveryAt address) async {
    try {
      await addressCollection.doc(address.id).update({
        'active': address.active,
        'cep': address.cep,
        'city': address.city,
        'complement': address.complement,
        'district': address.block,
        'number': address.number,
        'street': address.street,
        'uf': address.uf,
      }).then((value) => log('atualizamo'));
    } catch (e) {
      throw Exception('Não foi possível atualizar os dados do endereço');
    }
  }

  Future<void> createAddress(DeliveryAt address) async {
    try {
      await addressCollection.add({
        'active': address.active,
        'cep': address.cep,
        'city': address.city,
        'complement': address.complement,
        'district': address.block,
        'number': address.number,
        'street': address.street,
        'uf': address.uf,
      }).then((value) async {
        await clientCollection.doc(currentUser!.uid).update(
          {
            'address': FieldValue.arrayUnion([value.id]),
          },
        );
      });
    } catch (e) {
      throw Exception('Não foi possível criar um novo endereço');
    }
  }

  Future<void> removeAddress(DeliveryAt address) async {
    try {
      await addressCollection.doc(address.id).delete().then(
          (value) => log('O endereço do usuário foi deletado com sucesso'));
    } catch (e) {
      throw Exception(
          'Não foi possível remover os dados de endereço do usuário');
    }
  }
}

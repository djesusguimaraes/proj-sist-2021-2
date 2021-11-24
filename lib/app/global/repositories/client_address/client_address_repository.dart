import 'dart:collection';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pscomidas/app/global/models/entities/delivery_at.dart';
import 'package:search_cep/search_cep.dart';

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
    late DeliveryAt address;
    List<DeliveryAt> addresses = [];
    try {
      await addressCollection.doc(currentUser!.uid).get().then((doc) {
        for (int i = 0; i < doc.data()!.length; i++) {
          print(doc.data()!['address'][i]);
          address = DeliveryAt.fromMap(doc.data()!['address'][i]);
          addresses.add(address);
        }
      });
      return addresses;
    } catch (e) {
      throw Exception('Não foi possível recolher os dados de endereço');
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nbt/providers/return.dart';

import 'return.dart';

class Returns with ChangeNotifier {
  final List<Return> _returns = [
    // Return(
    //   id: '101',
    //   productName: 'Acetic Acid',
    //   partyName: 'Super',
    //   factoryName: 'Kid Init',
    //   quantity: '1.5 kg',
    //   date: DateTime.now(),
    //   remarks: 'Grade 2',
    // ),
    // Return(
    //   id: '102',
    //   productName: 'Acetic',
    //   partyName: 'Shakib',
    //   factoryName: 'Ebna Atiq',
    //   quantity: '2.6 kg',
    //   date: DateTime.now(),
    //   remarks: 'Grade 1',
    // ),
  ];

  List<Return> get returns {
    return [..._returns];
  }

  Return findById(String id) {
    return _returns.firstWhere((element) => element.id == id);
  }

// void addNew(Requisition value) {
//   _requisitions.add(value);
// }

//FIRESTORE
  Future createOrder(Return returnT) async {
    final docReturn = FirebaseFirestore.instance.collection('returns').doc();
    final newReturn = Return(
      id: returnT.id,
      uid: docReturn.id,
      productName: returnT.productName,
      partyName: returnT.partyName,
      factoryName: returnT.factoryName,
      remarks: returnT.remarks,
      quantity: returnT.quantity,
      date: returnT.date,
    );

    final json = newReturn.toJson();
    await docReturn.set(json);
  }

  Future deleteRequisition(String id) async {
    FirebaseFirestore.instance
        .collection('returns')
        .where('id', isEqualTo: id)
        .get()
        .then((snapshot) async {
      for (DocumentSnapshot ds in snapshot.docs) {
        await ds.reference.delete();
        print(ds.reference);
      }
    });
  }
//FIRESTORE END

}

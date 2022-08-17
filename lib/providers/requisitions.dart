import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nbt/providers/requisition.dart';

import 'requisition.dart';

class Requisitions with ChangeNotifier {
  final requisitionDB = FirebaseFirestore.instance.collection('requisitions');

  final List<Requisition> _requisitions = [
    // Requisition(
    //   id: '101',
    //   productName: 'Shakib',
    //   reqQuantity: '1.2 MT',
    //   date: DateTime.now(),
    //   remarks: 'Yeeee',
    //   status: Status.OrderPlaced,
    // ),
    // Requisition(
    //   id: '102',
    //   productName: 'kib',
    //   reqQuantity: '1.5 MT',
    //   date: DateTime.now(),
    //   status: Status.RequestSent,
    // ),
  ];

  List<Requisition> get requisitions {
    return [..._requisitions];
  }

  Requisition findById(String id) {
    return _requisitions.firstWhere((element) => element.id == id);
  }

  //FIRESTORE

  Future createOrder(Requisition requisition) async {
    final docRequisition =
        FirebaseFirestore.instance.collection('requisitions').doc();
    final newRequistion = Requisition(
        id: requisition.id,
        uid: docRequisition.id,
        productName: requisition.productName,
        reqQuantity: requisition.reqQuantity,
        remarks: requisition.remarks,
        date: requisition.date,
        status: requisition.status);

    final json = newRequistion.toJson();
    await docRequisition.set(json);
  }

  Future deleteRequisition(String id) async {
    // final docOrder = requisitionDB.doc(id);
    // var ss = readSingleOrder(id);
    // final docOrder =
    requisitionDB.where('uid', isEqualTo: id).get().then((snapshot) async {
      for (DocumentSnapshot ds in snapshot.docs) {
        await ds.reference.delete();
        print(ds.reference);
      }
    });
    // await docOrder.delete();
  }

  Future<Requisition> readSingleOrder(String id) async {
    final docReq = requisitionDB.where('uid', isEqualTo: id);
    final snapShot = await docReq.get();

    // if (snapShot.exists) {
    return Requisition.fromJson(snapShot.docs.map((e) => e.data()).first);
    // }
  }

  Future updateRequisition(Requisition requisition, String id) async {
    // final tentativeETA = requisitionDB
    //     .doc(id)
    //     .get()
    //     .then((value) => value['tentativeETA']) as String;
    final updateReq = Requisition(
      id: requisition.id,
      uid: id,
      productName: requisition.productName,
      reqQuantity: requisition.reqQuantity,
      remarks: requisition.remarks,
      date: requisition.date,
    );

    final json = updateReq.toJson();
    // await docRequisition.update(json);

    requisitionDB.where('uid', isEqualTo: id).get().then((snapshot) async {
      for (DocumentSnapshot ds in snapshot.docs) {
        await ds.reference.update(json);
      }
    });

    notifyListeners();

    // await docOrder.update(updateOrder as Map<String, dynamic>);
  }

  // Future<List<SetModel>> getAllSet(String s) async {
  //   try {
  //     var data = await FirebaseFirestore.instance
  //         .collection('set')
  //         .where("subjectId", isEqualTo: "mathid")
  //         .get();
  //     return data.docs.map((e) {
  //       return SetModel.fromJson(e.data());
  //     }).toList();
  //   } catch (e) {
  //     throw Exception('somting');
  //   }
  // }

  //END FIRESTORE FUNCTION

  // void addNew(Requisition value) {
  //   _requisitions.add(value);
  // }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nbt/providers/inventory.dart';

import 'inventory.dart';

class Inventories with ChangeNotifier {
  final List<Inventory> _inventories = [
    // Inventory(
    //   id: '101',
    //   productName: 'Acetic Acid',
    //   initStock: '1.2 KG',
    //   date: DateTime.now(),
    //   remarks: 'Grade 2',
    // ),
    // Inventory(
    //   id: '102',
    //   productName: 'Acetic',
    //   initStock: '1.5 KG',
    //   date: DateTime.now(),
    //   remarks: 'Grade 1',
    // ),
    // Inventory(
    //   id: '103',
    //   productName: 'Ace Tic',
    //   initStock: '1700 KG',
    //   date: DateTime.now(),
    //   remarks: 'Grade 6',
    // ),
  ];

  List<Inventory> get inventories {
    return [..._inventories];
  }

  Inventory findById(String id) {
    return _inventories.firstWhere((element) => element.id == id);
  }

// void addNew(Requisition value) {
//   _requisitions.add(value);
// }

//FIRESTORE
  Future createOrder(Inventory inventory) async {
    final docInventory =
        FirebaseFirestore.instance.collection('inventories').doc();
    final newInventory = Inventory(
      id: inventory.id,
      uid: docInventory.id,
      productName: inventory.productName,
      initStock: inventory.initStock,
      remarks: inventory.remarks,
      date: inventory.date,
      beingUsed: inventory.beingUsed,
      newStock: inventory.newStock,
    );

    final json = newInventory.toJson();
    await docInventory.set(json);
  }

//FIRESTORE END
}

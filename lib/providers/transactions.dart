import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'transaction.dart';

class Transactions with ChangeNotifier {
  final List<Transaction1> transactions1 = [
    // Transaction1(
    //   id: '101',
    //   productName: 'Product Hello',
    //   partyName: 'Party Shakib',
    //   factoryName: 'Super Kid',
    //   address: 'address',
    //   quantity: '1.2 MT',
    //   productDetail: "productDetail",
    //   date: DateTime.now(),
    //   status: Status.Complete,
    // ),
    // Transaction1(
    //   id: '102',
    //   productName: 'Product s2',
    //   partyName: 'Party Kid',
    //   factoryName: 'Super',
    //   address: 'address 2',
    //   quantity: '1.5 MT',
    //   productDetail: "productDeta32il",
    //   date: DateTime.now(),
    //   status: Status.NewOrder,
    // ),
  ];

  List<Transaction1> get transactions {
    return [...transactions1];
  }

  Transaction1 findById(String id) {
    return transactions1.firstWhere((element) => element.id == id);
  }

  void addNew(Transaction1 value) {
    transactions1.add(value);
  }

  void addProduct(Transaction1 transaction) {
    var newProduct = Transaction1(
        id: transaction.id,
        productName: transaction.productName,
        partyName: transaction.partyName,
        factoryName: transaction.factoryName,
        address: transaction.address,
        quantity: transaction.quantity,
        productDetail: transaction.productDetail,
        date: transaction.date);
    transactions1.add(newProduct);
    notifyListeners();
  }

  List<Transaction1> get sortedList {
    final seen = <String>{};
    // _transactions.where((element) => element.partyName == pn).toList();
    // final docReq = FirebaseFirestore.instance.collection('orders').doc();
    // final snapShot = await docReq.get();

    // getData();

    return transactions1
        .where((element) => seen.add(element.partyName))
        .toList();
  }

  final _fireStore = FirebaseFirestore.instance;
  late Transaction1 trans;
  final listt = [];
  Future getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _fireStore.collection('orders').get();

    // Get data from docs and convert map to List
    final List<Object?> allData =
        querySnapshot.docs.map((doc) => doc.data()).toList();
    for (var i = 0; i < allData.length; i++) {
      listt.add(allData);
      trans = Transaction1(
        id: listt[i][i]['id'],
        productName: listt[i][i]['productName'],
        partyName: listt[i][i]['partyName'],
        factoryName: listt[i][i]['factoryName'],
        address: listt[i][i]['address'],
        quantity: listt[i][i]['quantity'],
        productDetail: listt[i][i]['productDetail'],
        date: (listt[i][i]['date'] as Timestamp).toDate(),
      );
      transactions1.add(trans);
    }
    print('list print: ${transactions1.map((e) => e.partyName)}');

    // _transactions.add(allData[0]! as Transaction1);
    //for a specific field
    // final allData =
    // querySnapshot.docs.map((doc) => doc.get('fieldName')).toList();

    // print('last check ${allData[0].partyName.toString()}');
  }

  // void readOrders() {
  //   _transactions
  //       .add(FirebaseFirestore.instance.collection('products').snapshots());
  // }

  //Firestore

  Stream<List<Transaction1>> readOrders() => FirebaseFirestore.instance
      .collection('orders')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((e) => Transaction1.fromJson(e.data())).toList());

  Future createOrder(Transaction1 transaction) async {
    final docOrder =
        FirebaseFirestore.instance.collection('orders').doc(transaction.id);
    final newOrder = Transaction1(
        id: docOrder.id,
        productName: transaction.productName,
        partyName: transaction.partyName,
        factoryName: transaction.factoryName,
        address: transaction.address,
        quantity: transaction.quantity,
        productDetail: transaction.productDetail,
        date: transaction.date,
        status: transaction.status);

    final json = newOrder.toJson();
    await docOrder.set(json);
  }

  Future updateOrder(String id, String status) async {
    final docOrder = FirebaseFirestore.instance.collection('orders').doc(id);
    await docOrder.update({
      'status': status,
    });
  }

  Future<void> updateOrders(
      Transaction1 transaction, String id, String status) async {
    final docOrder = FirebaseFirestore.instance.collection('orders').doc(id);
    final updateOrder = Transaction1(
      id: docOrder.id,
      productName: transaction.productName,
      partyName: transaction.partyName,
      factoryName: transaction.factoryName,
      address: transaction.address,
      quantity: transaction.quantity,
      productDetail: transaction.productDetail,
      date: transaction.date,
      status: Status.values.byName(status),
    );

    final json = updateOrder.toJson();
    await docOrder.update(json);

    notifyListeners();

    // await docOrder.update(updateOrder as Map<String, dynamic>);
  }

  Future deleteOrder(String id) async {
    final docOrder = FirebaseFirestore.instance.collection('orders').doc(id);
    await docOrder.delete();
  }

  Future<Transaction1?> readSingleOrder(String id) async {
    final docOrder = FirebaseFirestore.instance.collection('orders').doc(id);
    final snapShot = await docOrder.get();

    if (snapShot.exists) {
      return Transaction1.fromJson(snapShot.data()!);
    }
  }

  static Future<bool> isDuplicateUniqueName(List<String> uniqueName) async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('orders')
        .where('partyName', isEqualTo: uniqueName)
        .get();
    return query.docs.isNotEmpty;
  }

  static firebasePartyName(List<String> name) async {
    var ist = [];
    if (await isDuplicateUniqueName(name)) {
      // UniqueName is duplicate
      // return 'Unique name already exists';
      ist.add(name);
      print('$ist is duplicate');

      return ist;
    }
    print('$name is not duplicate');
    // ... the rest of your code. Go ahead and create an account.
    // remember to save the uniqueName to users collection.
  }

  //Firestore

  List<Transaction1> partyList(String partyName) {
    return transactions1
        .where((element) => element.partyName == partyName)
        .toList();
  }
}

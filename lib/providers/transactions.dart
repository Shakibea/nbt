import 'package:flutter/material.dart';

import 'transaction.dart';

class Transactions with ChangeNotifier {
  final List<Transaction> _transactions = [
    Transaction(
      id: '101',
      productName: 'Shakib',
      partyName: 'Shakib',
      factoryName: 'Super Kid',
      address: 'address',
      quantity: '1.2 MT',
      productDetail: "productDetail",
      date: DateTime.now(),
      status: Status.Complete,
    ),
    Transaction(
      id: '102',
      productName: 'kib',
      partyName: 'Ebna',
      factoryName: 'Super',
      address: 'address 2',
      quantity: '1.5 MT',
      productDetail: "productDeta32il",
      date: DateTime.now(),
      status: Status.NewOrder,
    ),
    Transaction(
      id: '103',
      productName: 'kib',
      partyName: 'Atiq',
      factoryName: 'Super',
      address: 'address 2',
      quantity: '1.5 MT',
      productDetail: "productDeta32il",
      date: DateTime.now(),
      status: Status.MltShortage,
    ),
    Transaction(
      id: '104',
      productName: 'kib',
      partyName: 'Ifti',
      factoryName: 'Super',
      address: 'address 2',
      quantity: '1.5 MT',
      productDetail: "productDeta32il",
      date: DateTime.now(),
      status: Status.Delivered,
    ),
    Transaction(
      id: '105',
      productName: 'kib',
      partyName: 'Seai',
      factoryName: 'Super',
      address: 'address 2',
      quantity: '1.5 MT',
      productDetail: "productDeta32il",
      date: DateTime.now(),
      status: Status.InProcess,
    ),
    Transaction(
      id: '105',
      productName: 'kib',
      partyName: 'Hello',
      factoryName: 'Super',
      address: 'address 2',
      quantity: '1.5 MT',
      productDetail: "productDeta32il",
      date: DateTime.now(),
      status: Status.NewOrder,
    ),
    Transaction(
      id: '105',
      productName: 'kib',
      partyName: 'SAfI',
      factoryName: 'Super',
      address: 'address 2',
      quantity: '1.5 MT',
      productDetail: "productDeta32il",
      date: DateTime.now(),
      status: Status.Complete,
    ),
  ];

  List<Transaction> get transactions {
    return [..._transactions];
  }

  Transaction findById(String id) {
    return _transactions.firstWhere((element) => element.id == id);
  }

  void addNew(Transaction value) {
    _transactions.add(value);
  }
}

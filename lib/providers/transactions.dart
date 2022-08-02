import 'package:flutter/material.dart';

import 'transaction.dart';

class Transactions with ChangeNotifier {
  final List<Transaction> _transactions = [
    Transaction(
      id: '101',
      productName: 'Product Hello',
      partyName: 'Party Shakib',
      factoryName: 'Super Kid',
      address: 'address',
      quantity: '1.2 MT',
      productDetail: "productDetail",
      date: DateTime.now(),
      status: Status.Complete,
    ),
    Transaction(
      id: '102',
      productName: 'Product s2',
      partyName: 'Party Kid',
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
      partyName: 'Initiatives',
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
      partyName: 'Party Shakib',
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
      partyName: 'Initiatives',
      factoryName: 'Super',
      address: 'address 2',
      quantity: '1.5 MT',
      productDetail: "productDeta32il",
      date: DateTime.now(),
      status: Status.InProcess,
    ),
    Transaction(
      id: '106',
      productName: 'Pro note h',
      partyName: 'Hello',
      factoryName: 'Super',
      address: 'address 2',
      quantity: '1.5 MT',
      productDetail: "productDeta32il",
      date: DateTime.now(),
      status: Status.NewOrder,
    ),
    Transaction(
      id: '107',
      productName: 'Pro sde2',
      partyName: 'Party Shakib',
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

  var seen = <String>{};
  List<Transaction> get sortedList {
    // _transactions.where((element) => element.partyName == pn).toList();
    return _transactions
        .where((element) => seen.add(element.partyName))
        .toList();
  }

  List<Transaction> partyList(String partyName) {
    return _transactions
        .where((element) => element.partyName == partyName)
        .toList();
  }
}

import 'package:flutter/material.dart';

import 'transaction.dart';

class Transactions with ChangeNotifier {
  final List<Transaction> _transactions = [
    Transaction(
      id: '101',
      productName: 'Shakib',
      partyName: 'SEAI',
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
      partyName: 'SAI',
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
      partyName: 'SAI',
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
      partyName: 'SAI',
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
      partyName: 'SAI',
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
      partyName: 'SAI',
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
      partyName: 'SAI',
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

  void addNew(Transaction value) {
    _transactions.add(value);
  }
}

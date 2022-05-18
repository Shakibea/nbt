import 'package:flutter/material.dart';

import 'transaction.dart';

enum status { Complete, MltShortage, InProcess, Delivered, NewOrder }

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
      status: status.InProcess.toString(),
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
      status: status.NewOrder.toString(),
    )
  ];

  List<Transaction> get transactions {
    return [..._transactions];
  }
}

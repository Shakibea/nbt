import 'package:flutter/material.dart';
import 'package:nbt/providers/return.dart';

import 'return.dart';

class Returns with ChangeNotifier {
  final List<Return> _returns = [
    Return(
      id: '101',
      productName: 'Acetic Acid',
      partyName: 'Super',
      factoryName: 'Kid Init',
      quantity: '1.5 kg',
      date: DateTime.now(),
      remarks: 'Grade 2',
    ),
    Return(
      id: '102',
      productName: 'Acetic',
      partyName: 'Shakib',
      factoryName: 'Ebna Atiq',
      quantity: '2.6 kg',
      date: DateTime.now(),
      remarks: 'Grade 1',
    ),
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
}

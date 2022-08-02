import 'package:flutter/material.dart';
import 'package:nbt/providers/requisition.dart';

import 'requisition.dart';

class Requisitions with ChangeNotifier {
  final List<Requisition> _requisitions = [
    Requisition(
      id: '101',
      productName: 'Shakib',
      reqQuantity: '1.2 MT',
      date: DateTime.now(),
      remarks: 'Yeeee',
      status: Status.OrderPlaced,
    ),
    Requisition(
      id: '102',
      productName: 'kib',
      reqQuantity: '1.5 MT',
      date: DateTime.now(),
      status: Status.RequestSent,
    ),
  ];

  List<Requisition> get requisitions {
    return [..._requisitions];
  }

  Requisition findById(String id) {
    return _requisitions.firstWhere((element) => element.id == id);
  }

  // void addNew(Requisition value) {
  //   _requisitions.add(value);
  // }
}

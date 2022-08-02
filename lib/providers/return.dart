import 'package:flutter/material.dart';

class Return with ChangeNotifier {
  final String id;
  final String productName;
  final String partyName;
  final String factoryName;
  final DateTime date;
  final String remarks;
  final String quantity;

  Return(
      {required this.id,
      required this.productName,
      required this.partyName,
      required this.factoryName,
      required this.date,
      required this.remarks,
      required this.quantity});
}

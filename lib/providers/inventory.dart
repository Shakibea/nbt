import 'package:flutter/material.dart';

class Inventory with ChangeNotifier {
  final String id;
  final String productName;
  final String initStock;
  final DateTime date;
  final String remarks;

  Inventory({
    required this.id,
    required this.productName,
    required this.initStock,
    required this.date,
    required this.remarks,
  });
}

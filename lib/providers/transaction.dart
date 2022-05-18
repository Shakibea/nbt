import 'package:flutter/material.dart';

class Transaction with ChangeNotifier {
  final String id;
  final String productName;
  final String partyName;
  final String factoryName;
  final String address;
  final String quantity;
  final String productDetail;
  final DateTime date;
  final String status;

  Transaction({
    required this.id,
    required this.productName,
    required this.partyName,
    required this.factoryName,
    required this.address,
    required this.quantity,
    required this.productDetail,
    required this.date,
    required this.status,
  });
}

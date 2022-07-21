import 'package:flutter/material.dart';

enum Status { RequestSent, OrderPlaced }

class Requisition with ChangeNotifier {
  final String id;
  final String productName;
  final String reqQuantity;
  final DateTime date;
  String remarks;
  Status status;

  Requisition({
    required this.id,
    required this.productName,
    required this.reqQuantity,
    required this.date,
    this.remarks = '',
    this.status = Status.RequestSent,
  });

  String get getStatus {
    switch (status) {
      case Status.RequestSent:
        return 'Requested';
      case Status.OrderPlaced:
        return 'Order Placed';
      default:
        return 'Unknown';
    }
  }

  Color get getColor {
    switch (status) {
      case Status.OrderPlaced:
        return const Color(0xff00973D);
      case Status.RequestSent:
        return const Color(0xffF77E0B);
      default:
        return const Color(0xff000000);
    }
  }
}

import 'package:flutter/material.dart';

enum Status { Complete, MltShortage, InProcess, Delivered, NewOrder }

class Transaction with ChangeNotifier {
  final String id;
  final String productName;
  final String partyName;
  final String factoryName;
  final String address;
  final String quantity;
  final String productDetail;
  final DateTime date;
  Status status;

  Transaction({
    required this.id,
    required this.productName,
    required this.partyName,
    required this.factoryName,
    required this.address,
    required this.quantity,
    required this.productDetail,
    required this.date,
    this.status = Status.NewOrder,
  });

  String get getStatus {
    switch (status) {
      case Status.Complete:
        return 'Completed';
      case Status.InProcess:
        return 'In Process';
      case Status.MltShortage:
        return 'Shortage';
      case Status.NewOrder:
        return 'New Order';
      case Status.Delivered:
        return 'Delivered';
      default:
        return 'Unknown';
    }
  }

  Color get getColor {
    switch (status) {
      case Status.Complete:
        return const Color(0xff00973D);
      case Status.InProcess:
        return const Color(0xffF77E0B);
      case Status.MltShortage:
        return const Color(0xffE50019);
      case Status.NewOrder:
        return const Color(0xff4A544E);
      case Status.Delivered:
        return const Color(0xff00A0EC);
      default:
        return const Color(0xff000000);
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum Status { RequestSent, OrderPlaced }

class Requisition with ChangeNotifier {
  final String id;
  final String productName;
  final String reqQuantity;
  final DateTime date;
  String remarks;
  final Status status;

  Requisition({
    required this.id,
    required this.productName,
    required this.reqQuantity,
    required this.date,
    this.remarks = '',
    this.status = Status.RequestSent,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'productName': productName,
        'reqQuantity': reqQuantity,
        'remarks': remarks,
        'date': date,
        'status': status.name,
      };

  factory Requisition.fromJson(Map<String, dynamic> json) => Requisition(
        id: json['id'],
        productName: json['productName'],
        reqQuantity: json['reqQuantity'],
        remarks: json['remarks'],
        date: (json['date'] as Timestamp).toDate(),
        status: Status.values.byName(json['status']),
      );

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

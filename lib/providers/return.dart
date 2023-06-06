import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Return with ChangeNotifier {
  final String id;
  String? uid;
  final String productName;
  final String partyName;
  final String factoryName;
  final DateTime date;
  final String remarks;
  final String quantity;

  Return({
    required this.id,
    this.uid,
    required this.productName,
    required this.partyName,
    required this.factoryName,
    required this.date,
    required this.remarks,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'uid': uid,
        'productName': productName,
        'partyName': partyName,
        'factoryName': factoryName,
        'remarks': remarks,
        'quantity': quantity,
        'date': date,
      };

  factory Return.fromJson(Map<String, dynamic> json) => Return(
        id: json['id'],
        productName: json['productName'],
        partyName: json['partyName'],
        factoryName: json['factoryName'],
        remarks: json['remarks'],
        quantity: json['quantity'],
        date: (json['date'] as Timestamp).toDate(),
        uid: json['uid'],
      );
}

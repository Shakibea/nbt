import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Inventory with ChangeNotifier {
  final String id;
  String? uid;
  final String productName;
  final String initStock;
  final DateTime date;
  final String remarks;
  String? beingUsed;
  String? newStock;

  Inventory(
      {required this.id,
      this.uid = '',
      required this.productName,
      required this.initStock,
      required this.date,
      required this.remarks,
      this.beingUsed = '',
      this.newStock = ''});

  Map<String, dynamic> toJson() => {
        'id': id,
        'uid': uid,
        'productName': productName,
        'initStock': initStock,
        'remarks': remarks,
        'beingUsed': beingUsed,
        'newStock': newStock,
        'date': date,
      };

  factory Inventory.fromJson(Map<String, dynamic> json) => Inventory(
        id: json['id'],
        uid: json['uid'],
        productName: json['productName'],
        initStock: json['initStock'],
        remarks: json['remarks'],
        beingUsed: json['beingUsed'],
        newStock: json['newStock'],
        date: (json['date'] as Timestamp).toDate(),
      );
}

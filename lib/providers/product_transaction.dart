import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nbt/providers/product.dart';

enum Status { Complete, MltShortage, InProcess, Delivered, NewOrder }

class ProductTransaction with ChangeNotifier {
  final String id;
  final String partyName;
  final String factoryName;
  final String address;
  final DateTime date;
  Status status;

  ProductTransaction({
    required this.id,
    required this.partyName,
    required this.factoryName,
    required this.address,
    required this.date,
    this.status = Status.NewOrder,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'partyName': partyName,
        'factoryName': factoryName,
        'address': address,
        'date': date,
        'status': status.name
      };

  factory ProductTransaction.fromJson(Map<String, dynamic> json) =>
      ProductTransaction(
        id: json['id'],
        partyName: json['partyName'],
        factoryName: json['factoryName'],
        address: json['address'],
        date: (json['date'] as Timestamp).toDate(),
        status: Status.values.byName(json['status']),
      );

  static ProductTransaction fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ProductTransaction(
      id: snapshot['id'],
      partyName: snapshot['partyName'],
      factoryName: snapshot['factoryName'],
      address: snapshot['address'],
      date: (snapshot['date'] as Timestamp).toDate(),
      status: Status.values.byName(snapshot['status']),
    );
  }

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

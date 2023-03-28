import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nbt/providers/product.dart';

enum Status { Complete, MltShortage, InProcess, Delivered, NewOrder }

class Transaction1 with ChangeNotifier {
  final String id;
  final String productName;
  final String partyName;
  final String? factoryName;
  final String? address;
  final String quantity;
  final String? price;
  final String? transportation;
  final String productDetail;
  final DateTime date;
  Status status;

  Transaction1({
    this.price,
    this.transportation,
    required this.id,
    required this.productName,
    required this.partyName,
    this.factoryName,
    this.address,
    required this.quantity,
    required this.productDetail,
    required this.date,
    this.status = Status.NewOrder,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'productName': productName,
        'partyName': partyName,
        'factoryName': factoryName,
        'address': address,
        'quantity': quantity,
        'price': price,
        'transportation': transportation,
        'productDetail': productDetail,
        'date': date,
        'status': status.name
      };

  factory Transaction1.fromJson(Map<String, dynamic> json) => Transaction1(
        id: json['id'],
        productName: json['productName'],
        partyName: json['partyName'],
        factoryName: json['factoryName'],
        address: json['address'],
        quantity: json['quantity'],
        price: json['price'],
        transportation: json['transportation'],
        productDetail: json['productDetail'],
        date: (json['date'] as Timestamp).toDate(),
        status: Status.values.byName(
          json['status'],
        ),
      );

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

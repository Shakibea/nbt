import 'package:flutter/material.dart';

class OrderDetailsTextContent1 extends StatelessWidget {
  final String? title;
  final String? quantity;
  final String? price;
  const OrderDetailsTextContent1(
      {Key? key,
      required this.title,
      required this.quantity,
      required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final names = title;
    var nameList = names
        ?.split(",")
        .map((x) => x.trim())
        .where((element) => element.isNotEmpty)
        .toList();

    final quantitys = quantity;
    var quantityList = quantitys
        ?.split(",")
        .map((x) => x.trim())
        .where((element) => element.isNotEmpty)
        .toList();

    final prices = price;
    var priceList = prices
        ?.split(",")
        .map((x) => x.trim())
        .where((element) => element.isNotEmpty)
        .toList();

    for (var i = 0; i < nameList!.length; i++) {
      print("${nameList[i]}, ${quantityList![i]}, ${priceList![i]}");
    }

    return Container(
      height: 50,
      color: Colors.amber[100],
      child: Center(
          child: Text(
              "Name: ${nameList[0]} \nQuantity: ${quantityList![0]}\nPrice: ${priceList![0]}")),
    );
  }
}

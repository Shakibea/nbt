import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/transaction.dart';

class POListItem extends StatelessWidget {
  const POListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Transaction>(context, listen: false);
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
            backgroundColor: product.getColor,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: Text(
                  product.id,
                  style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            radius: 30),
        title: Text(
          '${product.productName} (${product.quantity})',
          // style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text('${product.partyName} (${product.factoryName})'),
        trailing: Text(
          product.getStatus,
          style: TextStyle(
              color: product.getColor,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

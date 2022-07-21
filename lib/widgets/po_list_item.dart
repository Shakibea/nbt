import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nbt/screens/order_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/transaction.dart';

class POListItem extends StatefulWidget {
  const POListItem({Key? key}) : super(key: key);

  @override
  State<POListItem> createState() => _POListItemState();
}

class _POListItemState extends State<POListItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Transaction>(context, listen: false);
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, OrderDetailsScreen.routeName,
                  arguments: product.id);
            },
            onLongPress: () {},
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
            subtitle: Text(product.partyName),
            trailing:
                // Row(
                //   children: [
                //     Text(
                //       product.getStatus,
                //       style: TextStyle(
                //           color: product.getColor,
                //           fontSize: 16,
                //           fontWeight: FontWeight.bold),
                //     ),
                //   ],
                // ),
                GestureDetector(
              onTap: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              child: Icon(_expanded ? Icons.expand_less : Icons.expand_more,
                  size: 35),
            ),
          ),
          if (_expanded)
            Container(
              // height: min(product.date.length * 20 + 15, 100),
              height: 40,
              // width: 250,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: ListView(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.getStatus,
                      style: TextStyle(
                          color: product.getColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                        '${product.factoryName} - ${DateFormat.yMMMMd().format(product.date)}'),
                  ],
                ),
              ]),
            )
        ],
      ),
    );
  }
}

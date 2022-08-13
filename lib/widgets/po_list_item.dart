import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nbt/screens/order_details_screen.dart';
import 'package:nbt/widgets/custom_radio_button.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/transaction.dart';

class POListItem extends StatefulWidget {
  // const POListItem({Key? key}) : super(key: key);

  final Transaction1 product;
  POListItem(this.product);

  @override
  State<POListItem> createState() => _POListItemState();
}

class _POListItemState extends State<POListItem> {
  final _pinController = TextEditingController();
  var _expanded = false;

  void showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {
        if (_pinController.text == '1234') {
          Navigator.pushReplacementNamed(context, CustomRadio.routeName,
              arguments: {
                'id': widget.product.id,
                'getStatus': widget.product.status
              });

          _pinController.text = '';
        } else {
          Navigator.pop(context);
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: TextField(
        decoration: const InputDecoration(label: Text('PIN')),
        controller: _pinController,
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final product = Provider.of<Transaction1>(context, listen: false);
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, OrderDetailsScreen.routeName,
                  arguments: widget.product.id);
            },
            onLongPress: () {
              showAlertDialog(context);
              // Navigator.pushNamed(context, CustomRadio.routeName, arguments: {
              //   'id': widget.product.id,
              //   'getStatus': widget.product.status
              // });
            },
            leading: CircleAvatar(
                backgroundColor: widget.product.getColor,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: FittedBox(
                    child: Text(
                      widget.product.id,
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
              '${widget.product.productName} (${widget.product.quantity})',
              // style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: Text(widget.product.partyName),
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
                      widget.product.getStatus,
                      style: TextStyle(
                          color: widget.product.getColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                        '${widget.product.factoryName} - ${DateFormat.yMMMMd().format(widget.product.date)}'),
                  ],
                ),
              ]),
            )
        ],
      ),
    );
  }
}

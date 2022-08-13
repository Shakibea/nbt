import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nbt/screens/order_details_screen.dart';
import 'package:provider/provider.dart';

import '../providers/transaction.dart';

class PartyListItem extends StatelessWidget {
  const PartyListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Transaction1>(context, listen: false);

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
                // backgroundColor: product.getColor,
                backgroundColor: const Color(0xff007DC5),
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
              product.partyName,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Color(0xff007DC5),
              ),
            ),
            // subtitle: Text(product.partyName),
            // trailing: Text('ss'),
          ),
        ],
      ),
    );
  }
}

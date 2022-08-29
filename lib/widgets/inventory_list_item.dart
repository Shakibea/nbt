import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nbt/screens/inventory_details_screen.dart';
import 'package:nbt/utils/colors.dart';
import 'package:nbt/widgets/functions.dart';
import 'package:nbt/widgets/snackbar_widget.dart';
import 'package:provider/provider.dart';

import '../providers/inventory.dart';

class InventoryListItem extends StatelessWidget {
  // const InventoryListItem({Key? key}) : super(key: key);

  final Inventory inventory;
  InventoryListItem(this.inventory);

  @override
  Widget build(BuildContext context) {
    // final inventory = Provider.of<Inventory>(context, listen: false);
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              FirebaseAuth.instance.currentUser != null
                  ? Navigator.pushNamed(
                      context, InventoryDetailsScreen.routeName,
                      arguments: inventory.uid)
                  : ScaffoldMessenger.of(context)
                      .showSnackBar(snackBar(context));
            },
            leading: CircleAvatar(
                backgroundColor: colors['inventory'],
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: FittedBox(
                    child: Text(
                      inventory.id,
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
            title: Text(inventory.productName
                // style: Theme.of(context).textTheme.headline6,
                ),
            subtitle: Text(inventory.remarks, softWrap: true),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  inventory.initStock,
                  style: TextStyle(
                      color: colors['inventory'], fontWeight: FontWeight.bold),
                ),
                Text(
                  DateFormat.yMMMMd().format(inventory.date),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

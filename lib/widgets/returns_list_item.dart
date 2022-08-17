import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nbt/providers/return.dart';
import 'package:nbt/utils/colors.dart';
import 'package:provider/provider.dart';

import '../providers/returns.dart';

class ReturnsListItem extends StatelessWidget {
  // const ReturnsListItem({Key? key}) : super(key: key);

  final Return returns;
  ReturnsListItem(this.returns);

  @override
  Widget build(BuildContext context) {
    // final returns = Provider.of<Return>(context, listen: false);
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              // Navigator.pushNamed(context, InventoryDetailsScreen.routeName,
              //     arguments: returns.id);
            },
            leading: CircleAvatar(
                backgroundColor: colors['returns'],
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: FittedBox(
                    child: Text(
                      returns.id,
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
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMMd().format(returns.date)),
                Text(
                  returns.productName,
                  style: TextStyle(
                      color: colors['returns'], fontWeight: FontWeight.bold),
                ),
              ],
            ),
            subtitle: Text('${returns.partyName} (${returns.factoryName})',
                softWrap: true),
            trailing: SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    returns.quantity,
                    softWrap: true,
                    style: TextStyle(
                        color: colors['returns'],
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  // Text(
                  //   returns.quantity,
                  //   style: const TextStyle(fontWeight: FontWeight.bold),
                  // ),
                  IconButton(
                      onPressed: () {
                        Provider.of<Returns>(context, listen: false)
                            .deleteRequisition(returns.id);
                        // Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.remove_circle_outline,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

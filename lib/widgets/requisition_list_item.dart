import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nbt/providers/requisitions.dart';
import 'package:nbt/screens/requisition_details_screen.dart';
import 'package:provider/provider.dart';

import '../providers/requisition.dart';

class RequisitionListItem extends StatelessWidget {
  const RequisitionListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Requisition>(context, listen: false);
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.pushNamed(
                context,
                RequisitionDetailsScreen.routeName,
                arguments: product.id,
              );
            },
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
              product.productName,
              // style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: Text('Requested: ${product.reqQuantity}'),
            trailing: Text(
              product.getStatus,
              style: TextStyle(
                  color: product.getColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

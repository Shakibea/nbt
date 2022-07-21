import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/inventories.dart';

class InventoryDetailsScreen extends StatelessWidget {
  const InventoryDetailsScreen({Key? key}) : super(key: key);

  static const routeName = '/inventory-details';

  @override
  Widget build(BuildContext context) {
    final inventoryId = ModalRoute.of(context)?.settings.arguments as String;
    var inventory =
        Provider.of<Inventories>(context, listen: false).findById(inventoryId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Will be here: $inventoryId'),
        backgroundColor: const Color(0xff0057A5),
      ),
      body: Text(inventory.productName),
    );
  }
}

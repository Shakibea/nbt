import 'package:flutter/material.dart';
import 'package:nbt/screens/new_inventory_screen.dart';
import 'package:provider/provider.dart';

import '../providers/inventories.dart';
import '../widgets/inventory_list_item.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  static const routeName = '/inventory';

  @override
  Widget build(BuildContext context) {
    var inventoryData = Provider.of<Inventories>(context);
    var inventory = inventoryData.inventories;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
        backgroundColor: const Color(0xff0057A5),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, NewInventoryScreen.routeName);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        height: (MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: ListView.builder(
          itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
            value: inventory[index],
            child: InventoryListItem(),
          ),
          itemCount: inventory.length,
        ),
      ),
    );
  }
}

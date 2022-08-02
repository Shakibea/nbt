import 'package:flutter/material.dart';
import 'package:nbt/screens/inventory_details_screen.dart';
import 'package:nbt/screens/inventory_screen.dart';
import 'package:nbt/screens/new_orders_screen.dart';
import 'package:nbt/screens/o_order_screen.dart';
import 'package:nbt/screens/po_list_screen.dart';
import 'package:nbt/screens/requisition_details_screen.dart';
import 'package:nbt/screens/requisition_screen.dart';
import 'package:nbt/screens/returns_screen.dart';
import 'package:nbt/widgets/custom_radio_button.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('NBT'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/main-dashboard');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Orders'),
            onTap: () {
              Navigator.pushReplacementNamed(context, POListScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Old Orders'),
            onTap: () {
              Navigator.pushReplacementNamed(context, OOrderScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.note_alt),
            title: const Text('Requisition'),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, RequisitionScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.inventory),
            title: const Text('Inventory'),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, InventoryScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.keyboard_return),
            title: const Text('Returns'),
            onTap: () {
              Navigator.pushReplacementNamed(context, ReturnsScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.keyboard_return),
            title: const Text('Custom Radio Button'),
            onTap: () {
              Navigator.pushReplacementNamed(context, CustomRadio.routeName);
            },
          ),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nbt/screens/new_inventory_screen.dart';
import 'package:nbt/widgets/functions.dart';
import 'package:nbt/widgets/show_alert_dialog.dart';
import 'package:provider/provider.dart';

import '../providers/inventories.dart';
import '../providers/inventory.dart';
import '../widgets/app_drawer.dart';
import '../widgets/inventory_list_item.dart';
import '../widgets/snackbar_widget.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  static const routeName = '/inventory';

  @override
  Widget build(BuildContext context) {
    print('inventory screen');
    var inventoryData = Provider.of<Inventories>(context);
    var inventory = inventoryData.inventories;

    final Query inventories = FirebaseFirestore.instance
        .collection('inventories')
        .orderBy('id', descending: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
        backgroundColor: const Color(0xff0057A5),
        actions: [
          IconButton(
            onPressed: () {
              final user = FirebaseAuth.instance.currentUser;
              if (user == null) {
                ScaffoldMessenger.of(context).showSnackBar(snackBar(context));
                return;
              }
              Navigator.pushNamed(context, NewInventoryScreen.routeName);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      // drawer: const AppDrawer(),
      body: StreamBuilder(
        stream: inventories.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            final snapShot = streamSnapshot.data!.docs;
            return ListView.builder(
                itemCount: snapShot.length ?? 0,
                itemBuilder: (context, index) {
                  final documentSnapshotToList = snapShot
                      .map((e) =>
                          Inventory.fromJson(e.data() as Map<String, dynamic>))
                      .toList();

                  return InventoryListItem(documentSnapshotToList[index]);
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),

      //OLD STYLE
      // SizedBox(
      //   width: double.infinity,
      //   height: (MediaQuery.of(context).size.height -
      //           AppBar().preferredSize.height -
      //           MediaQuery.of(context).padding.top) *
      //       0.7,
      //   child: ListView.builder(
      //     itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
      //       value: inventory[index],
      //       child: InventoryListItem(),
      //     ),
      //     itemCount: inventory.length,
      //   ),
      // ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nbt/providers/requisitions.dart';
import 'package:nbt/screens/inventory_screen.dart';
import 'package:nbt/screens/new_requisition_screen.dart';
import 'package:nbt/widgets/requisition_list_item.dart';
import 'package:provider/provider.dart';

import '../providers/requisition.dart';
import '../providers/transactions.dart';
import '../widgets/app_drawer.dart';
import '../widgets/custom_button.dart';
import '../widgets/po_list_item.dart';
import '../widgets/snackbar_widget.dart';
import 'new_orders_screen.dart';
import 'old_orders_screen.dart';

class RequisitionScreen extends StatelessWidget {
  const RequisitionScreen({Key? key}) : super(key: key);

  static const routeName = '/requisition';

  @override
  Widget build(BuildContext context) {
    var requisitionData = Provider.of<Requisitions>(context);
    var requisition = requisitionData.requisitions;

    // CollectionReference Will Not Because, using orderBy;
    Query requisitions = FirebaseFirestore.instance
        .collection('requisitions')
        .orderBy('date', descending: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Requisition'),
        backgroundColor: const Color(0xff662D91),
      ),
      // drawer: const AppDrawer(),
      body: Column(
        children: [
          Container(
            height: (MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0.28,
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  // onTap: () => _startAddNewTransaction(context),
                  onTap: () {
                    final user = FirebaseAuth.instance.currentUser;
                    if (user == null) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(snackBar(context));
                      return;
                    }
                    Navigator.pushNamed(
                      context,
                      NewRequisitionScreen.routeName,
                    );
                  },
                  // Navigator.pushNamed(context, NewOrdersScreen.routeName),
                  child: CustomButton(
                    title: 'New Requisition',
                    icon: 'lib/assets/requisition_icon.png',
                    color: 0xff662D91,
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.pushNamed(
                    context,
                    InventoryScreen.routeName,
                  ),
                  child: CustomButton(
                    title: 'Inventory',
                    icon: 'lib/assets/reports_icon.png',
                    color: 0xff0057A5,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: (MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0.7,
            child: StreamBuilder(
              stream: requisitions.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  final snapShot = streamSnapshot.data!.docs;
                  return ListView.builder(
                      itemCount: snapShot.length,
                      itemBuilder: (context, index) {
                        final documentSnapshotToList = snapShot
                            .map((e) => Requisition.fromJson(
                                e.data() as Map<String, dynamic>))
                            .toList();

                        return RequisitionListItem(
                            documentSnapshotToList[index]);
                      });
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),

            // ListView.builder(
            //   itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
            //     value: requisition[index],
            //     child: RequisitionListItem(),
            //   ),
            //   itemCount: requisition.length,
            // ),
          ),
        ],
      ),
    );
  }
}

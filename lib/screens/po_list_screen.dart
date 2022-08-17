import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nbt/screens/new_orders_screen.dart';
import 'package:nbt/screens/o_order_screen.dart';
import 'package:nbt/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../providers/transaction.dart';
import '../screens/old_orders_screen.dart';
import '../widgets/new_transaction.dart';
import '../widgets/po_list_item.dart';
import '../providers/transactions.dart';
import '../widgets/custom_button.dart';
import '../widgets/app_bar_functions.dart';
import 'order_details_screen.dart';

class POListScreen extends StatelessWidget {
  const POListScreen({Key? key}) : super(key: key);

  static const routeName = '/po-list';

  Widget buildUser() {
    return Center();
  }

  /*todo*/
  void _ass() {}
  void _startAddNewTransaction(BuildContext context) {
    // From StackOverflow
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      context: context,
      isScrollControlled: true,
      builder: (builder) {
        return Container(
          height: MediaQuery.of(context).size.height - 50,
          padding: MediaQuery.of(context).viewInsets,
          child: NewTransaction(_ass),
        );
      },
    );
  }
  /*todo*/

  @override
  Widget build(BuildContext context) {
    var transactionData = Provider.of<Transactions>(context);
    var transaction = transactionData.transactions;
    var transaction2 = transactionData.readOrders();

    final Query products = FirebaseFirestore.instance
        .collection('orders')
        .orderBy('date', descending: true);

    Stream<List<Transaction1>> readOrders() => FirebaseFirestore.instance
        .collection('orders')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Transaction1.fromJson(doc.data()))
            .toList());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarForNewOrder('PO LIST'),
      drawer: const AppDrawer(),
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
                  onTap: () => Navigator.pushNamed(
                    context,
                    NewOrdersScreen.routeName,
                    // arguments: transaction.length,
                  ),
                  // Navigator.pushNamed(context, NewOrdersScreen.routeName),
                  child: CustomButton(
                    title: 'Create New Order',
                    icon: 'lib/assets/new_order_icon.png',
                    color: 0xff511C74,
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.pushNamed(
                    context, OOrderScreen.routeName,
                    // OldOrdersScreen.routeName,
                  ),
                  child: CustomButton(
                    title: 'Old Order',
                    icon: 'lib/assets/reports_icon.png',
                    color: 0xff505153,
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
              stream: products.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  final snapShot = streamSnapshot.data!.docs;
                  return ListView.builder(
                      itemCount: snapShot.length,
                      itemBuilder: (context, index) {
                        final documentSnapshotToList = snapShot
                            .map((e) => Transaction1.fromJson(
                                e.data() as Map<String, dynamic>))
                            .toList();

                        return POListItem(documentSnapshotToList[index]);
                      });
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),

            // ListView.builder(
            //   itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
            //     value: transaction[index],
            //     child: POListItem(),
            //   ),
            //   itemCount: transaction.length,
            // ),
          ),
        ],
      ),
    );
  }
}

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nbt/widgets/old_order_list_item.dart';
import 'package:provider/provider.dart';

import '../providers/transaction.dart';
import '../providers/transactions.dart';
import '../widgets/app_bar_functions.dart';
import '../widgets/app_drawer.dart';

class OOrderScreen extends StatefulWidget {
  const OOrderScreen({Key? key}) : super(key: key);

  static const routeName = '/o-order';

  @override
  State<OOrderScreen> createState() => _OOrderScreenState();
}

class _OOrderScreenState extends State<OOrderScreen> {
  @override
  void initState() {
    // var transactionData = Provider.of<Transactions>(context, listen: false);
    // transactionData.getData();
    super.initState();
  }

  var initLoad = false;

  @override
  void didChangeDependencies() {
    if (!initLoad) {
      // var transactionData = Provider.of<Transactions>(context, listen: false);
      // transactionData.getData();
      initLoad = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Query oldOrders = FirebaseFirestore.instance
        .collection('orders')
        .where('status', isEqualTo: 'Delivered');

    // var transaction = transactionData.transactions;
    // var transactionName = Provider.of<Transaction>(context);

    //can be use
    // final transactionData = Provider.of<Transactions>(context, listen: false);
    // final transaction = transactionData.sortedList;
    // transaction.clear();

    return Scaffold(
      appBar: appBarForNewOrder('Old Order List'),
      drawer: const AppDrawer(),
      body: StreamBuilder(
        stream: oldOrders.snapshots(),
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

                  return OldOrderListItem(documentSnapshotToList[index]);
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),

      //OLD WITH PROVIDER
      //     ListView.builder(
      //   itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
      //     value: transaction[index],
      //     child: OldOrderListItem(),
      //   ),
      //   itemCount: transaction.length,
      // ),
    );
  }
}

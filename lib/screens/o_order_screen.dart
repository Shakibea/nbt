import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nbt/screens/o_order_list_item_screen.dart';
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

    Map<String, List<dynamic>> groupBy(List<dynamic> list, Function key) {
      final Map<String, List<dynamic>> groups = {};
      list.forEach((item) {
        final groupKey = key(item);
        if (groups[groupKey] == null) {
          groups[groupKey] = [item];
        } else {
          groups[groupKey]!.add(item);
        }
      });
      return groups;
    }

    return Scaffold(
      appBar: appBarForNewOrder('Old Order List'),
      drawer: const AppDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('status', isEqualTo: 'Delivered')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          final data = snapshot.data!.docs;
          // Here you can group the data by a specific field using the groupBy() function.
          final groupedData = groupBy(data, (doc) => doc['partyName']);
          return ListView.builder(
            itemCount: groupedData.length,
            itemBuilder: (BuildContext context, int index) {
              final groupName = groupedData.keys.toList()[index];
              final groupData = groupedData[groupName];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(groupName,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: groupData?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      final doc = groupData != null ? groupData[index] : 0;
                      return ListTile(
                        leading: Text(doc['id']),
                        title: Text(doc['partyName']),
                        subtitle: Text(doc['factoryName']),
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
      //PREVIOUS CODE
      /*StreamBuilder(
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
      ),*/

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

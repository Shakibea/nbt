import 'dart:developer';

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
  Widget build(BuildContext context) {
    var transactionData = Provider.of<Transactions>(context, listen: false);
    // var transaction = transactionData.transactions;
    // var transactionName = Provider.of<Transaction>(context);
    var transaction = transactionData.sortedList;

    return Scaffold(
      appBar: appBarForNewOrder('Old Order List'),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
          value: transaction[index],
          child: OldOrderListItem(),
        ),
        itemCount: transaction.length,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nbt/widgets/party_list_item.dart';
import 'package:provider/provider.dart';

import '../providers/transactions.dart';
import '../widgets/app_bar_functions.dart';

class PartyDetailsScreen extends StatelessWidget {
  const PartyDetailsScreen({Key? key}) : super(key: key);

  static const routeName = '/party-details';

  @override
  Widget build(BuildContext context) {
    var transactionData = Provider.of<Transactions>(context, listen: false);
    // var transaction = transactionData.transactions;
    // var transactionName = Provider.of<Transaction>(context);
    final orderId = ModalRoute.of(context)?.settings.arguments as String;
    var transaction = transactionData.partyList(orderId);
    return Scaffold(
      appBar: appBarForNewOrder('Party List'),
      body: ListView.builder(
        itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
          value: transaction[index],
          child: PartyListItem(),
        ),
        itemCount: transaction.length,
      ),
    );
  }
}

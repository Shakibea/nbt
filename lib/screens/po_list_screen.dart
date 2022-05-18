import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/new_orders_screen.dart';
import '../screens/old_orders_screen.dart';
import '../widgets/new_transaction.dart';
import '../widgets/po_list_item.dart';
import '../providers/transactions.dart';
import '../widgets/orders_button.dart';
import '../widgets/app_bar_functions.dart';

class POListScreen extends StatelessWidget {
  const POListScreen({Key? key}) : super(key: key);

  static const routeName = '/po-list';

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
    return Scaffold(
      appBar: appBarForNewOrder('PO LIST'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () => _startAddNewTransaction(context),
                  // Navigator.pushNamed(context, NewOrdersScreen.routeName),
                  child: OrdersButton(
                    title: 'Create New Order',
                    icon: 'lib/assets/new_order_icon.png',
                    color: 0xff511C74,
                  ),
                ),
                InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, OldOrdersScreen.routeName),
                  child: OrdersButton(
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
            child: ListView.builder(
              itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
                value: transaction[index],
                child: POListItem(),
              ),
              itemCount: transaction.length,
            ),
          ),
        ],
      ),
    );
  }
}

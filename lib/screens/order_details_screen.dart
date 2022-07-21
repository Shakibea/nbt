import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/transactions.dart';
import '../widgets/app_bar_functions.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  static const routeName = '/order-details';

  @override
  Widget build(BuildContext context) {
    final orderId = ModalRoute.of(context)?.settings.arguments as String;
    var order = Provider.of<Transactions>(context).findById(orderId);
    return Scaffold(
      appBar: appBarForNewOrder('Order Details Page ${order.id}'),
    );
  }
}

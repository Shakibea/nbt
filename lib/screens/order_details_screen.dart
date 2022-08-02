import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nbt/utils/colors.dart';
import 'package:nbt/widgets/order_details_text_content.dart';
import 'package:nbt/widgets/order_details_text_title.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              OrderDetailsTitle('Date'),
              const SizedBox(
                height: 10,
              ),
              OrderDetailsTextContent(
                  title: DateFormat.yMMMMd().format(order.date)),
              const SizedBox(
                height: 20,
              ),

              //NAME OF PRODUCT
              OrderDetailsTitle('Name of Product'),
              const SizedBox(
                height: 10,
              ),
              OrderDetailsTextContent(title: order.productName),
              const SizedBox(
                height: 20,
              ),

              //PARTY NAME
              OrderDetailsTitle('Party Name'),
              const SizedBox(
                height: 10,
              ),
              OrderDetailsTextContent(title: order.partyName),
              const SizedBox(
                height: 20,
              ),

              //FACTORY NAME
              OrderDetailsTitle('Factory Name'),
              const SizedBox(
                height: 10,
              ),
              OrderDetailsTextContent(title: order.factoryName),
              const SizedBox(
                height: 20,
              ),

              //ADDRESS
              OrderDetailsTitle('Address'),
              const SizedBox(
                height: 10,
              ),
              OrderDetailsTextContent(title: order.address),
              const SizedBox(
                height: 20,
              ),

              //QUANTITY
              OrderDetailsTitle('Quantity'),
              const SizedBox(
                height: 10,
              ),
              OrderDetailsTextContent(title: order.quantity),
              const SizedBox(
                height: 20,
              ),

              //PRODUCT DETAILS
              OrderDetailsTitle('Product Details'),
              const SizedBox(
                height: 10,
              ),
              OrderDetailsTextContent(title: order.productDetail),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

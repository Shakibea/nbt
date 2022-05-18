import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/po_list_item.dart';
import '../providers/transactions.dart';

class POListScreen extends StatelessWidget {
  const POListScreen({Key? key}) : super(key: key);

  static const routeName = '/po-list';

  Widget newAndOldOrderButton(String title, String icon) {
    return Column(
      children: [
        SizedBox(
          width: 110,
          height: 110,
          child: Card(
            elevation: 20,
            color: Colors.amber,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Container(
              // decoration: BoxDecoration(
              //     color: Color(color),
              //     borderRadius: BorderRadius.circular(50)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    icon,
                    width: 42,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                ],
              ),
            ),
          ),
        ),
        Text(
          title,
          style: GoogleFonts.openSans(
              textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var transactionData = Provider.of<Transactions>(context);
    var transaction = transactionData.transactions;
    return Scaffold(
      appBar: AppBar(
        title: Text('PO List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                newAndOldOrderButton(
                    'create new order', 'lib/assets/new_order_icon.png'),
                newAndOldOrderButton(
                    'old order', 'lib/assets/new_order_icon.png'),
              ],
            ),
          ),
          Container(
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

// Column(
// children: [

// ],
// ),
// ),

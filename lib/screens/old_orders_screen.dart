import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/transactions.dart';
import '../widgets/app_bar_functions.dart';

class OldOrdersScreen extends StatelessWidget {
  OldOrdersScreen({Key? key}) : super(key: key);

  static const routeName = '/old-orders';

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Transactions>(context);
    return Scaffold(
      appBar: appBarForNewOrder('OLD ORDERS'),
      body: GridView.count(
          childAspectRatio: 1.0,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 44),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: orders.transactions.map((item) {
            return Card(
              elevation: 20,
              //todo
              color: const Color(0xff00A0EC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(90),
              ),
              child: InkWell(
                onTap: () {
                  if (item.partyName == 'New Orders') {
                    //todo
                    // Navigator.pushNamed(
                    //   context,
                    //   POListScreen.routeName,
                    // );
                  }
                  if (item.partyName == 'Accounts') {
                    //todo
                    // Navigator.pushNamed(
                    //   context,
                    //   NewOrdersScreen.routeName,
                    // );
                  }
                },
                child: Container(
                  // decoration: BoxDecoration(
                  //     color: Color(color),
                  //     borderRadius: BorderRadius.circular(50)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(
                        Icons.library_books,
                        size: 42,
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        item.partyName,
                        style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w700)),
                      ),

                      /*SUBTITLE WITH SIZE BOX*/
                      // const SizedBox(
                      //   height: 4,
                      // ),
                      // Text(
                      //   item.subtitle,
                      //   style: GoogleFonts.openSans(
                      //       textStyle: const TextStyle(
                      //           color: Colors.white38,
                      //           fontSize: 10,
                      //           fontWeight: FontWeight.w600)),
                      // ),
                      // const SizedBox(
                      //   height: 7,
                      // ),

                      /*EVENT*/
                      // Text(
                      //   item.event,
                      //   style: GoogleFonts.openSans(
                      //       textStyle: const TextStyle(
                      //           color: Colors.white70,
                      //           fontSize: 11,
                      //           fontWeight: FontWeight.w600)),
                      // ),
                    ],
                  ),
                ),
              ),
            );
          }).toList()),
    );
  }
}

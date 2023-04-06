// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nbt/utils/colors.dart';
import 'package:nbt/widgets/show_alert_dialog.dart';
import 'package:provider/provider.dart';

import '../providers/inventories.dart';
import '../providers/inventory.dart';
import '../widgets/inventory_list_item.dart';
import 'inventory_screen.dart';
import 'main_dashboard_screen.dart';

class InventoryDetailsScreen extends StatefulWidget {
  const InventoryDetailsScreen({Key? key}) : super(key: key);

  static const routeName = '/inventory-details';

  @override
  State<InventoryDetailsScreen> createState() => _InventoryDetailsScreenState();
}

class _InventoryDetailsScreenState extends State<InventoryDetailsScreen> {
  final _beingUsedController = TextEditingController();
  final _newStockController = TextEditingController();
  final _stockController = TextEditingController();

  late String totalScore;

  @override
  void dispose() {
    _beingUsedController.dispose();
    _newStockController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inventoryId = ModalRoute.of(context)?.settings.arguments as String;
    // var inventory = Provider.of<Inventories>(context, listen: false);
    // var inventoryDataWithId = inventory.findById(inventoryId);
    // var inventoryData = inventory.inventories;

    // final Query inventories =
    //     FirebaseFirestore.instance.collection('inventors');

    var inventory = Provider.of<Inventories>(context, listen: false)
        .readSingleOrder(inventoryId);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Product Will be here: $inventoryId'),
      //   backgroundColor: const Color(0xff0057A5),
      // ),
      body: FutureBuilder<Inventory?>(
          // StreamBuilder<QuerySnapshot>(

          future: inventory,

          // stream: FirebaseFirestore.instance
          //     .collection('inventories').snapshots(),

          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var inventoryData = snapshot.data!;
              totalScore = inventoryData.initStock;
              print(totalScore);

              // var inventoryData = snapshot.data!.docs;
              // _stockController.text = inventoryData.initStock;
              //pop navigation
              // void previousPage() => Navigator.pop(context);

              // void initStore(int total) async {
              //   await FirebaseFirestore.instance
              //       .collection('inventories')
              //       .where('uid', isEqualTo: inventoryData.uid)
              //       .get()
              //       .then((snapshot) async {
              //     for (DocumentSnapshot ds in snapshot.docs) {
              //       await ds.reference.update({
              //         'initStock': total.toString(),
              //         'beingUsed':
              //         _beingUsedController.text.trim(),
              //         'newStock':
              //         _newStockController.text.trim()
              //       });
              //     }
              //   });
              //
              //
              // }
              //
              //
              // final beingUsed =
              // _beingUsedController.text.trim();
              // final newStock = _newStockController.text.trim();
              // final initStock =
              // int.parse(inventoryData.initStock.trim());
              // int totalUsed;
              //
              // showAlertDialog(context, () {
              //   //calculation beingUsed
              //   if (beingUsed.isNotEmpty) {
              //     totalUsed = initStock - int.parse(beingUsed);
              //     initStore(totalUsed);
              //     Navigator.pushReplacementNamed(
              //       context,
              //       InventoryScreen.routeName,
              //     );
              //
              //     setState(() {
              //       totalScore = totalUsed.toString();
              //       _stockController.text = totalScore;
              //       print('used: $totalScore');
              //     });
              //
              //     // Navigator.pop(context);
              //   }
              //   //calculation newStock
              //   else if (newStock.isNotEmpty) {
              //     totalUsed = initStock + int.parse(newStock);
              //     initStore(totalUsed);
              //
              //     Navigator.pushNamedAndRemoveUntil(
              //       context,
              //       InventoryScreen.routeName,
              //           (Route<dynamic> route) => false,
              //     );
              //
              //     // setState(() {
              //     //   setState(() {
              //     //     totalScore = totalUsed.toString();
              //     //     print('saved: $totalScore');
              //     //   });
              //     // });
              //
              //     // Navigator.pop(context);
              //   }
              // });

              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      color: colors['inventory'],
                      child: Column(
                        children: [
                          const SizedBox(
                            // height: 110,
                            height: 70,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Product Name: ${inventoryData.productName}",
                                      style: GoogleFonts.openSans(
                                          textStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "Remarks: ${inventoryData.remarks}",
                                      style: GoogleFonts.openSans(
                                          textStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                    // StreamBuilder(
                    //   stream: inventoryData,
                    //   builder:
                    //       (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    //     if (snapshot.hasData) {
                    //       final snap = snapshot.data!.docs;
                    //     }
                    //     return Container();
                    //   },
                    // ),

                    // TextFormField(
                    //   key: Key(_stockController.text),
                    //   controller: _stockController,
                    //   decoration: InputDecoration(
                    //     border: InputBorder.none,
                    //   ),
                    //   enabled: false,
                    //   style: TextStyle(
                    //     color: colors['inventory'],
                    //     fontSize: 19,
                    //     fontWeight: FontWeight.w700,
                    //   ),
                    //   textAlign: TextAlign.center,
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(17),
                      child: Text(
                        totalScore,
                        key: Key(totalScore),
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            color: colors['inventory'],
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text('Date'),
                          Text(
                            DateFormat.yMMMd().format(inventoryData.date),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text('Being Used (-)'),
                          SizedBox(
                            width: 150,
                            child: TextField(
                              controller: _beingUsedController,
                              decoration: const InputDecoration(
                                  label: Text('Quantity (KGs)'),
                                  border: OutlineInputBorder()),
                              onChanged: (value) {
                                totalScore =
                                    '${int.parse(totalScore) - int.parse(value)}';
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text('New Stock (+)'),
                          SizedBox(
                            width: 150,
                            child: TextField(
                              controller: _newStockController,
                              decoration: const InputDecoration(
                                  label: Text('Quantity (KGs)'),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              //calling initStore from database to store init-stock
                              void initStore(int total) async {
                                await FirebaseFirestore.instance
                                    .collection('inventories')
                                    .where('uid', isEqualTo: inventoryData.uid)
                                    .get()
                                    .then((snapshot) async {
                                  for (DocumentSnapshot ds in snapshot.docs) {
                                    await ds.reference.update({
                                      'initStock': total.toString(),
                                      'beingUsed':
                                          _beingUsedController.text.trim(),
                                      'newStock':
                                          _newStockController.text.trim()
                                    });
                                  }
                                });
                              }

                              //pop navigation
                              // void previousPage() => Navigator.pop(context);

                              final beingUsed =
                                  _beingUsedController.text.trim();
                              final newStock = _newStockController.text.trim();
                              final initStock =
                                  int.parse(inventoryData.initStock.trim());
                              int totalUsed;

                              showAlertDialog(context, () {
                                //calculation beingUsed
                                if (beingUsed.isNotEmpty) {
                                  totalUsed = initStock - int.parse(beingUsed);
                                  initStore(totalUsed);
                                  Navigator.pushReplacementNamed(
                                    context,
                                    InventoryScreen.routeName,
                                  );

                                  // setState(() {
                                  //   totalScore = totalUsed.toString();
                                  //   _stockController.text = totalScore;
                                  //   print('used: $totalScore');
                                  // });

                                  // Navigator.pop(context);
                                }
                                //calculation newStock
                                if (newStock.isNotEmpty) {
                                  totalUsed = initStock + int.parse(newStock);
                                  initStore(totalUsed);

                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    InventoryScreen.routeName,
                                    // (Route<dynamic> route) => false,
                                    ModalRoute.withName(
                                      MainDashboardScreen.routeName,
                                    ),
                                  );

                                  // setState(() {
                                  //   setState(() {
                                  //     totalScore = totalUsed.toString();
                                  //     print('saved: $totalScore');
                                  //   });
                                  // });

                                  // Navigator.pop(context);
                                }
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green),
                            ),
                            child: const Text('Save Changes'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              showAlertDialog(context, () {
                                Provider.of<Inventories>(context, listen: false)
                                    .deleteOrder(inventoryId);
                              });
                              // Navigator.pop(context);
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                            ),
                            child: const Text('Delete'),
                          )
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   width: double.infinity,
                    //   height: (MediaQuery.of(context).size.height -
                    //           AppBar().preferredSize.height -
                    //           MediaQuery.of(context).padding.top) *
                    //       0.4,
                    //   child: ListView.builder(
                    //     itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
                    //       value: inventoryData[index],
                    //       child: InventoryListItem(),
                    //     ),
                    //     itemCount: inventoryData.length,
                    //   ),
                    // ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

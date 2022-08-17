import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nbt/utils/colors.dart';
import 'package:provider/provider.dart';

import '../providers/inventories.dart';
import '../widgets/inventory_list_item.dart';

class InventoryDetailsScreen extends StatefulWidget {
  const InventoryDetailsScreen({Key? key}) : super(key: key);

  static const routeName = '/inventory-details';

  @override
  State<InventoryDetailsScreen> createState() => _InventoryDetailsScreenState();
}

class _InventoryDetailsScreenState extends State<InventoryDetailsScreen> {
  final _beingUsedController = TextEditingController();
  final _newStockController = TextEditingController();

  @override
  void dispose() {
    _beingUsedController.dispose();
    _newStockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inventoryId = ModalRoute.of(context)?.settings.arguments as String;
    var inventory = Provider.of<Inventories>(context, listen: false);
    var inventoryDataWithId = inventory.findById(inventoryId);
    var inventoryData = inventory.inventories;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Product Will be here: $inventoryId'),
      //   backgroundColor: const Color(0xff0057A5),
      // ),
      body: SingleChildScrollView(
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
                              "Product Name: ${inventoryDataWithId.productName}",
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
                              "Remarks: ${inventoryDataWithId.remarks}",
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
            Padding(
              padding: const EdgeInsets.all(17),
              child: Text(
                inventoryDataWithId.initStock,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                      color: colors['inventory'],
                      fontSize: 19,
                      fontWeight: FontWeight.w700),
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
                    DateFormat.yMMMd().format(inventoryDataWithId.date),
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
                    onPressed: () {},
                    child: const Text('Save Changes'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Delete'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
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
      ),
    );
  }
}

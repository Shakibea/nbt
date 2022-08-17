import 'package:flutter/material.dart';
import 'package:nbt/providers/transaction.dart';
import 'package:nbt/widgets/custom_radio_item.dart';
import 'package:provider/provider.dart';

import '../models/radio.dart';
import '../providers/transactions.dart';

class CustomRadio extends StatefulWidget {
  const CustomRadio({Key? key}) : super(key: key);

  static const routeName = '/custom-radio';

  @override
  State<CustomRadio> createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  List<RadioModel> sampleData = <RadioModel>[];

  late String orderId;
  late Status getStatus;
  var _initLoad = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_initLoad) {
      final routeArgs = (ModalRoute.of(context)?.settings.arguments ??
          <String, dynamic>{}) as Map;

      orderId = routeArgs['id'];
      getStatus = routeArgs['getStatus'];
      // print(routeArgs['getStatus']);
      sampleData.add(RadioModel(getStatus == Status.MltShortage ? true : false,
          'Mlt Shortage', 0xffE50019, 'MltShortage'));
      sampleData.add(RadioModel(getStatus == Status.Delivered ? true : false,
          'Delivered', 0xff00A0EC, 'Delivered'));
      sampleData.add(RadioModel(getStatus == Status.Complete ? true : false,
          'Complete', 0xff00973D, 'Complete'));
      sampleData.add(RadioModel(getStatus == Status.InProcess ? true : false,
          'In Process', 0xffF77E0B, 'InProcess'));

      _initLoad = true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final orderId = ModalRoute.of(context)?.settings.arguments as String;
    final routeArgs = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    orderId = routeArgs['id'];
    // getStatus = routeArgs['getStatus'];
    print(routeArgs['getStatus']);

    // getStatus = Status.values.byName(routeArgs['getStatus']);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Status"),
      ),
      body: GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 2,
        childAspectRatio: 4 / 1.5,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(
          4,
          (index) {
            return InkWell(
              //highlightColor: Colors.red,
              splashColor: Colors.blueAccent,
              onTap: () {
                setState(() {
                  for (var element in sampleData) {
                    // if (element.isSelected) {
                    //   return;
                    // }
                    element.isSelected = false;
                  }
                  sampleData[index].isSelected = true;
                  Provider.of<Transactions>(context, listen: false)
                      .updateOrder(orderId, sampleData[index].text);
                });
              },
              child: RadioItem(sampleData[index]),
            );
          },
        ),
      ),

      //LIST VIEW
      // ListView.builder(
      //   itemCount: sampleData.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     return InkWell(
      //       //highlightColor: Colors.red,
      //       splashColor: Colors.blueAccent,
      //       onTap: () {
      //         setState(() {
      //           for (var element in sampleData) {
      //             element.isSelected = false;
      //           }
      //           sampleData[index].isSelected = true;
      //         });
      //       },
      //       child: Column(
      //         children: [
      //           RadioItem(sampleData[index]),
      //           Text(sampleData[index].isSelected
      //               ? sampleData[index].buttonText
      //               : 'dont know')
      //         ],
      //       ),
      //     );
      //   },
      // ),
    );
  }
}

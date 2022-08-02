import 'package:flutter/material.dart';
import 'package:nbt/widgets/custom_radio_item.dart';

import '../models/radio.dart';

class CustomRadio extends StatefulWidget {
  const CustomRadio({Key? key}) : super(key: key);

  static const routeName = '/custom-radio';

  @override
  State<CustomRadio> createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  List<RadioModel> sampleData = <RadioModel>[];

  @override
  void initState() {
    super.initState();
    sampleData.add(RadioModel(false, 'Mlt Shortage', 0xffE50019));
    sampleData.add(RadioModel(false, 'Delivered', 0xff00A0EC));
    sampleData.add(RadioModel(false, 'Complete', 0xff00973D));
    sampleData.add(RadioModel(false, 'In Process', 0xffF77E0B));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ListItem"),
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
                    element.isSelected = false;
                  }
                  sampleData[index].isSelected = true;
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

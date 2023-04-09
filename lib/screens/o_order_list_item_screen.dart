import 'package:flutter/material.dart';

class OOrderListItemScreen extends StatelessWidget {
  List<dynamic> groupData;
  OOrderListItemScreen(this.groupData);
  static const routeName = '/o-order-list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Old Order List")),
      body: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: groupData?.length,
        itemBuilder: (BuildContext context, int index) {
          final doc = groupData![index];
          return ListTile(
            title: Text(doc['partyName'] != null ? 's' : 'b'),
            subtitle: Text(doc['factoryName']),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/requisitions.dart';

class RequisitionDetailsScreen extends StatelessWidget {
  const RequisitionDetailsScreen({Key? key}) : super(key: key);

  static const routeName = '/requistion-details';

  @override
  Widget build(BuildContext context) {
    final requisitionId = ModalRoute.of(context)?.settings.arguments as String;
    var requisition =
        Provider.of<Requisitions>(context).findById(requisitionId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Requisition ${requisition.id}'),
        backgroundColor: const Color(0xff662D91),
      ),
      body: Container(),
    );
  }
}

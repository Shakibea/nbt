import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nbt/screens/edit_requisition_screen.dart';
import 'package:nbt/utils/colors.dart';
import 'package:provider/provider.dart';

import '../providers/requisition.dart';
import '../providers/requisitions.dart';

class RequisitionDetailsScreen extends StatefulWidget {
  const RequisitionDetailsScreen({Key? key}) : super(key: key);

  static const routeName = '/requistion-details';

  @override
  State<RequisitionDetailsScreen> createState() =>
      _RequisitionDetailsScreenState();
}

class _RequisitionDetailsScreenState extends State<RequisitionDetailsScreen> {
  final _tentativeETAController = TextEditingController();

  @override
  void dispose() {
    _tentativeETAController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final requisitionId = ModalRoute.of(context)?.settings.arguments as String;
    var requisitions = Provider.of<Requisitions>(context, listen: false)
        .readSingleOrder(requisitionId);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Requisition'),
        backgroundColor: colors['requisition'],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Requisition?>(
            future: requisitions,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final requisition = snapshot.data;
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Date',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: colors['requisition'],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            DateFormat.yMMMMd().format(requisition!.date),
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 26,
                      ),

                      //NAME OF PRODUCT
                      Row(
                        children: [
                          Text(
                            'Name of Product',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: colors['requisition'],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            requisition.productName,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 26,
                      ),

                      //Requested Quantity
                      Row(
                        children: [
                          Text(
                            'Requested Quantity',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: colors['requisition'],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            requisition.reqQuantity,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 26,
                      ),

                      //REMARKS
                      Row(
                        children: [
                          Text(
                            'Remarks',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: colors['requisition'],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            requisition.remarks,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, EditRequisitionScreen.routeName,
                                  arguments: requisitionId);
                            },
                            child: const Text('Edit'),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                const Color(0xff0057A5),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Provider.of<Requisitions>(context, listen: false)
                                  .deleteRequisition(requisitionId);
                              Navigator.pop(context);
                            },
                            child: const Text('Delete'),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                const Color(0xffFF0000),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Tentative ETA',
                          hintText: 'Tentative ETA',
                        ),
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // final docOrder = FirebaseFirestore.instance
                          //     .collection('requisitions')
                          //     .doc(requisitionId);
                          // docOrder.update({
                          //   'status': Status.OrderPlaced.name,
                          // });

                          FirebaseFirestore.instance
                              .collection('requisitions')
                              .where('id', isEqualTo: requisitionId)
                              .get()
                              .then((snapshot) async {
                            for (DocumentSnapshot ds in snapshot.docs) {
                              await ds.reference.update({
                                'status': Status.OrderPlaced.name,
                              });
                            }
                          });

                          Navigator.pop(context);
                        },
                        child: const Text('Order Placed'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color(0xff00973D),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return const Center(child: Text('No Data'));
              }
            }),
      ),
    );
  }
}

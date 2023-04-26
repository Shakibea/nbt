import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nbt/screens/edit_requisition_screen.dart';
import 'package:nbt/screens/requisition_screen.dart';
import 'package:nbt/utils/colors.dart';
import 'package:nbt/widgets/show_alert_dialog.dart';
import 'package:nbt/widgets/snackbar_widget.dart';
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
  final _form = GlobalKey<FormFieldState>();
  DateTime? dateTime;

  @override
  void initState() {
    dateTime = DateTime.now();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // dateTime = DateTime.now();
    super.didChangeDependencies();
  }

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

    // void

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
                // dateTime =
                //     DateTime.tryParse(requisition!.tentativeETA.toString()) ??
                //         DateTime.now();
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
                              if (FirebaseAuth.instance.currentUser == null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar(context));
                                return;
                              }
                              showAlertDialog(context, () {
                                Navigator.pushReplacementNamed(
                                    context, EditRequisitionScreen.routeName,
                                    arguments: requisitionId);
                              });
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
                              if (FirebaseAuth.instance.currentUser == null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar(context));
                                return;
                              }
                              showAlertDialog(context, () {
                                Provider.of<Requisitions>(context,
                                        listen: false)
                                    .deleteRequisition(requisitionId);
                                Navigator.popUntil(
                                  context,
                                  ModalRoute.withName(
                                      RequisitionScreen.routeName),
                                );
                              });
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

                      Row(
                        children: [
                          Text(
                            'Tentative ETA: ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: colors['requisition'],
                            ),
                          ),
                          // requisition.tentativeETA != ''
                          //     ?
                          // Text(DateFormat.yMMMd().format(dateTime!)),

                          requisition.tentativeETA!.isNotEmpty
                              ? Text(requisition.tentativeETA!)
                              : Text(DateFormat.yMMMd().format(dateTime!)),

                          // requisition.tentativeETA == null
                          //     ? Text(DateFormat.yMMMd().format(dateTime!))
                          //     : Text(requisition.tentativeETA.toString())

                          //     : Text(''),
                        ],
                      ),
                      //FORM SUBMISSION WITH TENTATIVE ETA
                      // Form(
                      //   key: _form,
                      //   child: TextFormField(
                      //     controller: _tentativeETAController,
                      //     // controller: requisition.tentativeETA == ''
                      //     //     ? _tentativeETAController
                      //     //     : TextEditingController(
                      //     //         text:
                      //     //             '${dateTime.day}/${dateTime.month}/${dateTime.year}'),
                      //     // onChanged: (value) {
                      //     //   _tentativeETAController.text =
                      //     //       '${dateTime.day}/${dateTime.month}/${dateTime.year}';
                      //     // },
                      //     decoration: const InputDecoration(
                      //       border: OutlineInputBorder(),
                      //       labelText: 'Tentative ETA',
                      //       hintText: 'Tentative ETA',
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 26,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            DateTime? newDate = await showDatePicker(
                                    context: context,
                                    initialDate: dateTime!,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100))
                                .then((value) {
                              setState(() {
                                dateTime = value;
                              });
                              return null;
                            });

                            if (newDate == null) return;
                            // setState(() {
                            //   dateTime = newDate;
                            // });
                          },
                          child: const Text('Choose Date!')),
                      // const SizedBox(
                      //   height: 26,
                      // ),
                      ElevatedButton(
                        onPressed: () {
                          // final docOrder = FirebaseFirestore.instance
                          //     .collection('requisitions')
                          //     .doc(requisitionId);
                          // docOrder.update({
                          //   'status': Status.OrderPlaced.name,
                          // });

                          // _form.currentState!.save();

                          if (FirebaseAuth.instance.currentUser != null) {
                            FirebaseFirestore.instance
                                .collection('requisitions')
                                .where('uid', isEqualTo: requisitionId)
                                .get()
                                .then((snapshot) async {
                              for (DocumentSnapshot ds in snapshot.docs) {
                                await ds.reference.update({
                                  'status': Status.OrderPlaced.name,
                                  'tentativeETA':
                                      DateFormat.yMMMd().format(dateTime!),
                                  // dateTime!.toIso8601String(),
                                });
                              }
                            });
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar(context));
                          }
                          // print('status:${Status.OrderPlaced.name}');
                          // print('tentativeETA:${dateTime}');
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
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nbt/providers/requisitions.dart';
import 'package:nbt/screens/requisition_details_screen.dart';
import 'package:nbt/screens/requisition_screen.dart';
import 'package:provider/provider.dart';

import '../providers/requisition.dart';
import '../utils/colors.dart';

class EditRequisitionScreen extends StatefulWidget {
  const EditRequisitionScreen({Key? key}) : super(key: key);

  static const routeName = '/edit-requisition';

  @override
  State<EditRequisitionScreen> createState() => _NewRequisitionScreenState();
}

class _NewRequisitionScreenState extends State<EditRequisitionScreen> {
  final _form = GlobalKey<FormState>();

  final _dateController = TextEditingController();
  final _requisitionNumController = TextEditingController();
  final _nameOfProductController = TextEditingController();
  final _reqQuantityController = TextEditingController();
  final _remarksController = TextEditingController();

  var _initLoad = false;
  late String id;
  late String uid;

  @override
  void initState() {
    _dateController.text = DateFormat.yMMMMd().format(DateTime.now());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_initLoad) {
      final orderId = ModalRoute.of(context)?.settings.arguments as String;
      final docRef =
          FirebaseFirestore.instance.collection("requisitions").doc(orderId);
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          // _dateController.text = DateFormat.yMMMMd().format(data['date']);
          id = data['id'];
          uid = data['uid'];
          _requisitionNumController.text = id;
          _dateController.text =
              DateFormat.yMMMMd().format((data['date'] as Timestamp).toDate());
          _nameOfProductController.text = data['productName'];
          _reqQuantityController.text = data['reqQuantity'];
          _remarksController.text = data['remarks'];

          // status = data['status'];
        },
        onError: (e) => print("Error getting document: $e"),
      );

      _initLoad = true;
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _requisitionNumController.dispose();
    _nameOfProductController.dispose();
    _reqQuantityController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  void _saveForm(Requisition requisition) {
    var valid = _form.currentState?.validate();
    if (!valid!) {
      return; // not valid
    }
    _form.currentState?.save();

    Provider.of<Requisitions>(context, listen: false)
        .updateRequisition(requisition, uid);

    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EDIT REQUISITION'),
        backgroundColor: colors['requisition'],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration:
                    const InputDecoration(label: Text('Requisition Number')),
                textInputAction: TextInputAction.next,
                enabled: false,
                controller: _requisitionNumController,
              ),
              TextFormField(
                decoration: const InputDecoration(label: Text('Date')),
                textInputAction: TextInputAction.next,
                enabled: false,
                controller: _dateController,
              ),
              TextFormField(
                decoration:
                    const InputDecoration(label: Text('Name of Product')),
                textInputAction: TextInputAction.next,
                controller: _nameOfProductController,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus();
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Product Name!';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                    label: Text('Requested Quantity (KG)')),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                controller: _reqQuantityController,
                // onFieldSubmitted: (_) {
                //   FocusScope.of(context).requestFocus();
                // },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Quantity!';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration:
                    const InputDecoration(label: Text('Remarks (If any)')),
                maxLines: 5,
                controller: _remarksController,
                keyboardType: TextInputType.multiline,
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return 'Please enter anything';
                //   }
                //   if (value.length <= 10) {
                //     return 'above 10';
                //   }
                //   return null;
                // },
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  var newReq = Requisition(
                      id: _requisitionNumController.text,
                      date: DateTime.now(),
                      productName: _nameOfProductController.text,
                      reqQuantity: _reqQuantityController.text,
                      remarks: _remarksController.text);
                  _saveForm(newReq);

                  // Navigator.pop(context);
                  // Navigator.pushReplacementNamed(
                  //     context, RequisitionScreen.routeName);
                  Navigator.popUntil(
                    context,
                    ModalRoute.withName(RequisitionScreen.routeName),
                  );
                },
                child: const Text(
                  'Request Sent',
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xffF77E0B)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

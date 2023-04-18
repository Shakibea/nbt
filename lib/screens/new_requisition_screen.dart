import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nbt/providers/requisitions.dart';
import 'package:provider/provider.dart';

import '../providers/requisition.dart';
import '../utils/colors.dart';

class NewRequisitionScreen extends StatefulWidget {
  const NewRequisitionScreen({Key? key}) : super(key: key);

  static const routeName = '/new-requisition';

  @override
  State<NewRequisitionScreen> createState() => _NewRequisitionScreenState();
}

class _NewRequisitionScreenState extends State<NewRequisitionScreen> {
  final _form = GlobalKey<FormState>();

  final _dateController = TextEditingController();
  final _requisitionNumController = TextEditingController();
  final _nameOfProductController = TextEditingController();
  final _reqQuantityController = TextEditingController();
  final _remarksController = TextEditingController();

  @override
  void initState() {
    _dateController.text = DateFormat.yMMMMd().format(DateTime.now());
    super.initState();
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

    Provider.of<Requisitions>(context, listen: false).createOrder(requisition);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CREATE NEW REQUISITION'),
        backgroundColor: colors['requisition'],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(label: Text('Date')),
                textInputAction: TextInputAction.next,
                enabled: false,
                controller: _dateController,
              ),
              TextFormField(
                decoration:
                    const InputDecoration(label: Text('Requisition Number')),
                textInputAction: TextInputAction.next,
                // enabled: false,
                controller: _requisitionNumController,
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

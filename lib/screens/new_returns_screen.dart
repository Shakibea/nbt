import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nbt/utils/colors.dart';
import 'package:provider/provider.dart';

import '../providers/return.dart';
import '../providers/returns.dart';

class NewReturnsScreen extends StatefulWidget {
  const NewReturnsScreen({Key? key}) : super(key: key);

  static const routeName = '/new-returns';

  @override
  State<NewReturnsScreen> createState() => _NewReturnsScreenState();
}

class _NewReturnsScreenState extends State<NewReturnsScreen> {
  final _form = GlobalKey<FormState>();

  final _dateController = TextEditingController();
  final _returnNumController = TextEditingController();
  final _nameOfProductController = TextEditingController();
  final _partyNameController = TextEditingController();
  final _factoryNameController = TextEditingController();
  final _requestedQuantityController = TextEditingController();
  final _remarksController = TextEditingController();

  @override
  void initState() {
    _dateController.text = DateFormat.yMMMMd().format(DateTime.now());
    super.initState();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _returnNumController.dispose();
    _nameOfProductController.dispose();
    _partyNameController.dispose();
    _factoryNameController.dispose();
    _requestedQuantityController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  void _saveForm(Return returns) {
    var valid = _form.currentState?.validate();
    if (!valid!) {
      return; // not valid
    }
    _form.currentState?.save();

    Provider.of<Returns>(context, listen: false).createOrder(returns);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Returns'),
        backgroundColor: const Color(0xff279758),
      ),
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration:
                    const InputDecoration(label: Text('Returns Number')),
                textInputAction: TextInputAction.next,
                // enabled: false,
                controller: _returnNumController,
              ),
              TextFormField(
                decoration: const InputDecoration(label: Text('Date')),
                textInputAction: TextInputAction.next,
                enabled: false,
                controller: _dateController,
              ),
              TextFormField(
                controller: _nameOfProductController,
                decoration:
                    const InputDecoration(label: Text('Name of Product')),
                textInputAction: TextInputAction.next,
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
                controller: _partyNameController,
                decoration: const InputDecoration(label: Text('Party Name')),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus();
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Party Name!';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _factoryNameController,
                decoration: const InputDecoration(label: Text('Factory Name')),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus();
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Factory Name!';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _requestedQuantityController,
                decoration:
                    const InputDecoration(label: Text('Requested Quantity')),
                textInputAction: TextInputAction.done,
                // onFieldSubmitted: (_) {
                //   FocusScope.of(context).requestFocus();
                // },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Quantity! (KG)';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _remarksController,
                decoration: const InputDecoration(label: Text('Remarks')),
                maxLines: 5,
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      var newReturns = Return(
                          id: _returnNumController.text,
                          date: DateTime.now(),
                          productName: _nameOfProductController.text,
                          partyName: _partyNameController.text,
                          factoryName: _factoryNameController.text,
                          quantity: _requestedQuantityController.text,
                          remarks: _remarksController.text);
                      _saveForm(newReturns);
                    },
                    child: const Text('Save'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        colors['returns'],
                      ),
                    ),
                  ),
                  // ElevatedButton(
                  //   onPressed: () {},
                  //   child: const Text('Delete'),
                  //   style: ButtonStyle(
                  //     backgroundColor: MaterialStateProperty.all(
                  //       const Color(0xffFF0000),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

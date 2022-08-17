import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nbt/providers/inventory.dart';
import 'package:provider/provider.dart';

import '../providers/inventories.dart';

class NewInventoryScreen extends StatefulWidget {
  const NewInventoryScreen({Key? key}) : super(key: key);

  static const routeName = '/new-inventory';

  @override
  State<NewInventoryScreen> createState() => _NewInventoryScreenState();
}

class _NewInventoryScreenState extends State<NewInventoryScreen> {
  final _nameOfProductController = TextEditingController();
  final _initStockController = TextEditingController();
  final _remarksController = TextEditingController();
  final _entryDateController = TextEditingController();
  final _idController = TextEditingController();

  void _saveForm(Inventory inventory) {
    // var valid = _form.currentState?.validate();
    // if (!valid!) {
    //   return; // not valid
    // }
    // _form.currentState?.save();

    Provider.of<Inventories>(context, listen: false).createOrder(inventory);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    _entryDateController.text = DateFormat.yMMMMd().format(DateTime.now());
    super.initState();
  }

  @override
  void dispose() {
    _nameOfProductController.dispose();
    _initStockController.dispose();
    _remarksController.dispose();
    _entryDateController.dispose();
    _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0057A5),
        title: const Text('CREATE NEW INVENTORY'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 8),
                child: TextFormField(
                  controller: _idController,
                  decoration: const InputDecoration(
                      label: Text('Id'), border: OutlineInputBorder()),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 8),
                child: TextFormField(
                  controller: _nameOfProductController,
                  decoration: const InputDecoration(
                      label: Text('Name of Product'),
                      border: OutlineInputBorder()),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 8),
                child: TextFormField(
                  controller: _remarksController,
                  decoration: const InputDecoration(
                      label: Text('Remarks'), border: OutlineInputBorder()),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 8),
                child: TextFormField(
                  controller: _initStockController,
                  decoration: const InputDecoration(
                      label: Text('Initial Stock (KGs)'),
                      border: OutlineInputBorder()),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 8),
                child: TextFormField(
                  controller: _entryDateController,
                  enabled: false,
                  decoration: const InputDecoration(
                      label: Text('Entry Date'), border: OutlineInputBorder()),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () {
                    final newReq = Inventory(
                        id: _idController.text,
                        uid: '',
                        date: DateTime.now(),
                        productName: _nameOfProductController.text,
                        initStock: _initStockController.text,
                        remarks: _remarksController.text);
                    _saveForm(newReq);
                  },
                  child: const Text(
                    'Save',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                    //todo
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

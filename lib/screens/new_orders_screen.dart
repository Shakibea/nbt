import 'package:flutter/material.dart';
import 'package:nbt/widgets/app_bar_functions.dart';
import 'package:intl/intl.dart';

class NewOrdersScreen extends StatefulWidget {
  const NewOrdersScreen({Key? key}) : super(key: key);

  static const routeName = '/new-orders';

  @override
  State<NewOrdersScreen> createState() => _NewOrdersScreenState();
}

class _NewOrdersScreenState extends State<NewOrdersScreen> {
  final _form = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _poNumController = TextEditingController(text: '1000');

  @override
  void initState() {
    _dateController.text = DateFormat.yMMMMd().format(DateTime.now());
    super.initState();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _poNumController.dispose();
    super.dispose();
  }

  void _saveForm() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appBarForNewOrder('CREATE NEW ORDER'),
      appBar: AppBar(
        title: const Text('CREATE NEW ORDER'),
        backgroundColor: const Color(0xff511C74),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.save),
          )
        ],
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
                decoration: const InputDecoration(label: Text('PO Number')),
                textInputAction: TextInputAction.next,
                enabled: false,
                controller: _poNumController,
              ),
              TextFormField(
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
                decoration: const InputDecoration(label: Text('Party Name')),
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
                decoration: const InputDecoration(label: Text('Factory Name')),
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
              // TextFormField(
              //   decoration: const InputDecoration(label: Text('Address')),
              //   textInputAction: TextInputAction.next,
              //   onFieldSubmitted: (_) {
              //     FocusScope.of(context).requestFocus();
              //   },
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return 'Please enter Product Name!';
              //     }
              //     return null;
              //   },
              // ),
              TextFormField(
                decoration: const InputDecoration(label: Text('Address')),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                // focusNode: _descriptionFocusNode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter anything';
                  }
                  if (value.length <= 10) {
                    return 'above 10';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(label: Text('Quantity')),
                textInputAction: TextInputAction.done,
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
                decoration: const InputDecoration(label: Text('Description')),
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                // focusNode: _descriptionFocusNode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter anything';
                  }
                  if (value.length <= 10) {
                    return 'above 10';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

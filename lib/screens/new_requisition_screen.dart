import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewRequisitionScreen extends StatefulWidget {
  const NewRequisitionScreen({Key? key}) : super(key: key);

  static const routeName = '/new-requisition';

  @override
  State<NewRequisitionScreen> createState() => _NewRequisitionScreenState();
}

class _NewRequisitionScreenState extends State<NewRequisitionScreen> {
  final _form = GlobalKey<FormState>();

  final _dateController = TextEditingController();
  final _requisitionNumController = TextEditingController(text: '1000');

  @override
  void initState() {
    _dateController.text = DateFormat.yMMMMd().format(DateTime.now());
    super.initState();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _requisitionNumController.dispose();
    super.dispose();
  }

  void _saveForm() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CREATE NEW REQUISITION'),
        backgroundColor: const Color(0xff662D91),
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
                decoration:
                    const InputDecoration(label: Text('Requested Quantity')),
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
                decoration:
                    const InputDecoration(label: Text('Remarks (If any)')),
                maxLines: 5,
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
              ElevatedButton(
                  onPressed: () {}, child: const Text('Request Sent'))
            ],
          ),
        ),
      ),
    );
  }
}

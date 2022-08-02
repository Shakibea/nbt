import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nbt/utils/colors.dart';

class NewReturnsScreen extends StatefulWidget {
  const NewReturnsScreen({Key? key}) : super(key: key);

  static const routeName = '/new-returns';

  @override
  State<NewReturnsScreen> createState() => _NewReturnsScreenState();
}

class _NewReturnsScreenState extends State<NewReturnsScreen> {
  final _form = GlobalKey<FormState>();

  final _dateController = TextEditingController();
  final _returnNumController = TextEditingController(text: '1000');

  @override
  void initState() {
    _dateController.text = DateFormat.yMMMMd().format(DateTime.now());
    super.initState();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _returnNumController.dispose();
    super.dispose();
  }

  void _saveForm() {}

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
                enabled: false,
                controller: _returnNumController,
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
                decoration: const InputDecoration(label: Text('Remarks')),
                maxLines: 5,
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Save'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        colors['returns'],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Delete'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        const Color(0xffFF0000),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

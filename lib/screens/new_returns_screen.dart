import 'package:cloud_firestore/cloud_firestore.dart';
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

  List<String> partyNames = [];
  List<String> factoryNames = [];

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
                decoration: const InputDecoration(label: Text('Date')),
                textInputAction: TextInputAction.next,
                enabled: false,
                controller: _dateController,
              ),
              TextFormField(
                decoration:
                    const InputDecoration(label: Text('Returns Number')),
                textInputAction: TextInputAction.next,
                // enabled: false,
                controller: _returnNumController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Returns Number!';
                  }
                  return null;
                },
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
              StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('orders').snapshots(),
                builder: (context, snapshots) {
                  if (snapshots.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshots.connectionState == ConnectionState.active) {
                    if (snapshots.hasData) {
                      for (int i = 0; i < snapshots.data!.docs.length; i++) {
                        partyNames.add(snapshots.data!.docs[i]['partyName']);
                      }

                      for (int i = 0; i < snapshots.data!.docs.length; i++) {
                        factoryNames
                            .add(snapshots.data!.docs[i]['factoryName']);
                      }
                      return SizedBox(
                        height: 160,
                        width: double.infinity,
                        // color: Colors.red,
                        child: Column(
                          children: [
                            RawAutocomplete(
                              optionsBuilder:
                                  (TextEditingValue textEditingValue) {
                                if (textEditingValue.text == '') {
                                  return const Iterable<String>.empty();
                                } else {
                                  List<String> matches = <String>[];

                                  matches.addAll(partyNames);
                                  // matches.addAll(snap
                                  //     .map((e) => e.partyName)
                                  //     .toList());

                                  print(matches.length);

                                  matches.retainWhere((s) {
                                    return s.toLowerCase().contains(
                                        textEditingValue.text.toLowerCase());
                                  });
                                  return matches;
                                }
                              },
                              onSelected: (String selection) {
                                print('You just selected $selection');
                              },
                              fieldViewBuilder: (BuildContext context,
                                  _partyNameController,
                                  FocusNode focusNode,
                                  VoidCallback onFieldSubmitted) {
                                return TextFormField(
                                  controller: _partyNameController,
                                  decoration: const InputDecoration(
                                      label: Text('Party Name')),
                                  textInputAction: TextInputAction.next,
                                  // onFieldSubmitted: (_) {
                                  //   FocusScope.of(context).requestFocus();
                                  // },
                                  focusNode: focusNode,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter Party Name!';
                                    }
                                    return null;
                                  },
                                );
                              },
                              optionsViewBuilder: (BuildContext context,
                                  void Function(String) onSelected,
                                  Iterable<String> options) {
                                return Material(
                                    child: SizedBox(
                                        height: 200,
                                        child: SingleChildScrollView(
                                            child: Column(
                                          children: options.map((opt) {
                                            return InkWell(
                                                onTap: () {
                                                  onSelected(opt);
                                                },
                                                child: Container(
                                                    padding: EdgeInsets.only(
                                                        right: 60),
                                                    child: Card(
                                                        child: Container(
                                                      width: double.infinity,
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Text(opt),
                                                    ))));
                                          }).toList(),
                                        ))));
                              },
                            ),
                            SizedBox(height: 15),
                            RawAutocomplete(
                              optionsBuilder:
                                  (TextEditingValue textEditingValue) {
                                if (textEditingValue.text == '') {
                                  return const Iterable<String>.empty();
                                } else {
                                  List<String> matchesF = [];

                                  matchesF.addAll(factoryNames);

                                  // matchesF.addAll(snap
                                  //     .map(
                                  //         (e) => e.factoryName.toString())
                                  //     .toList());
                                  // matches.addAll(FirebaseFirestore.instance.collection('orders'));

                                  print(matchesF.length);

                                  matchesF.retainWhere((s) {
                                    return s.toLowerCase().contains(
                                        textEditingValue.text.toLowerCase());
                                  });
                                  return matchesF;
                                }
                              },
                              onSelected: (String selection) {
                                print('You just selected $selection');
                              },
                              fieldViewBuilder: (BuildContext context,
                                  _factoryNameController,
                                  FocusNode focusNode,
                                  VoidCallback onFieldSubmitted) {
                                return TextFormField(
                                  controller: _factoryNameController,
                                  decoration: const InputDecoration(
                                      label: Text('Factory Name')),
                                  textInputAction: TextInputAction.next,
                                  // onFieldSubmitted: (_) {
                                  //   FocusScope.of(context).requestFocus();
                                  // },
                                  focusNode: focusNode,
                                  // validator: (value) {
                                  //   if (value!.isEmpty) {
                                  //     return 'Please enter Factory Name!';
                                  //   }
                                  //   return null;
                                  // },
                                );
                              },
                              optionsViewBuilder: (BuildContext context,
                                  void Function(String) onSelected,
                                  Iterable<String> options) {
                                return Material(
                                    child: SizedBox(
                                        height: 200,
                                        child: SingleChildScrollView(
                                            child: Column(
                                          children: options.map((opt) {
                                            return InkWell(
                                                onTap: () {
                                                  onSelected(opt);
                                                },
                                                child: Container(
                                                    padding: EdgeInsets.only(
                                                        right: 60),
                                                    child: Card(
                                                        child: Container(
                                                      width: double.infinity,
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Text(opt),
                                                    ))));
                                          }).toList(),
                                        ))));
                              },
                            ),
                          ],
                        ),
                      );
                    } else if (snapshots.hasError) {
                      return Center(
                        child: Text(snapshots.error.toString()),
                      );
                    }
                  }

                  return Container(
                    height: 202,
                    width: double.infinity,
                    // color: Colors.red,
                    child: Column(
                      children: [
                        RawAutocomplete(
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            if (textEditingValue.text == '') {
                              return const Iterable<String>.empty();
                            } else {
                              List<String> matches = <String>[];

                              matches.addAll(partyNames);
                              // matches.addAll(snap
                              //     .map((e) => e.partyName)
                              //     .toList());

                              print(matches.length);

                              matches.retainWhere((s) {
                                return s.toLowerCase().contains(
                                    textEditingValue.text.toLowerCase());
                              });
                              return matches;
                            }
                          },
                          onSelected: (String selection) {
                            print('You just selected $selection');
                          },
                          fieldViewBuilder: (BuildContext context,
                              TextEditingController textEditingController,
                              FocusNode focusNode,
                              VoidCallback onFieldSubmitted) {
                            return TextFormField(
                              controller: textEditingController,
                              decoration: const InputDecoration(
                                  label: Text('Party Name')),
                              textInputAction: TextInputAction.next,
                              // onFieldSubmitted: (_) {
                              //   FocusScope.of(context).requestFocus();
                              // },
                              focusNode: focusNode,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter Party Name!';
                                }
                                return null;
                              },
                            );
                          },
                          optionsViewBuilder: (BuildContext context,
                              void Function(String) onSelected,
                              Iterable<String> options) {
                            return Material(
                                child: SizedBox(
                                    height: 200,
                                    child: SingleChildScrollView(
                                        child: Column(
                                      children: options.map((opt) {
                                        return InkWell(
                                            onTap: () {
                                              onSelected(opt);
                                            },
                                            child: Container(
                                                padding:
                                                    EdgeInsets.only(right: 60),
                                                child: Card(
                                                    child: Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.all(10),
                                                  child: Text(opt),
                                                ))));
                                      }).toList(),
                                    ))));
                          },
                        ),
                        SizedBox(height: 15),
                        RawAutocomplete(
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            if (textEditingValue.text == '') {
                              return const Iterable<String>.empty();
                            } else {
                              List<String> matchesF = [];

                              matchesF.addAll(factoryNames);

                              // matchesF.addAll(snap
                              //     .map(
                              //         (e) => e.factoryName.toString())
                              //     .toList());
                              // matches.addAll(FirebaseFirestore.instance.collection('orders'));

                              print(matchesF.length);

                              matchesF.retainWhere((s) {
                                return s.toLowerCase().contains(
                                    textEditingValue.text.toLowerCase());
                              });
                              return matchesF;
                            }
                          },
                          onSelected: (String selection) {
                            print('You just selected $selection');
                          },
                          fieldViewBuilder: (BuildContext context,
                              TextEditingController textEditingController,
                              FocusNode focusNode,
                              VoidCallback onFieldSubmitted) {
                            return TextFormField(
                              controller: textEditingController,
                              decoration: const InputDecoration(
                                  label: Text('Factory Name')),
                              textInputAction: TextInputAction.next,
                              // onFieldSubmitted: (_) {
                              //   FocusScope.of(context).requestFocus();
                              // },
                              focusNode: focusNode,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter Factory Name!';
                                }
                                return null;
                              },
                            );
                          },
                          optionsViewBuilder: (BuildContext context,
                              void Function(String) onSelected,
                              Iterable<String> options) {
                            return Material(
                                child: SizedBox(
                                    height: 200,
                                    child: SingleChildScrollView(
                                        child: Column(
                                      children: options.map((opt) {
                                        return InkWell(
                                            onTap: () {
                                              onSelected(opt);
                                            },
                                            child: Container(
                                                padding:
                                                    EdgeInsets.only(right: 60),
                                                child: Card(
                                                    child: Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.all(10),
                                                  child: Text(opt),
                                                ))));
                                      }).toList(),
                                    ))));
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              // TextFormField(
              //   controller: _partyNameController,
              //   decoration: const InputDecoration(label: Text('Party Name')),
              //   textInputAction: TextInputAction.next,
              //   onFieldSubmitted: (_) {
              //     FocusScope.of(context).requestFocus();
              //   },
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return 'Please enter Party Name!';
              //     }
              //     return null;
              //   },
              // ),
              // TextFormField(
              //   controller: _factoryNameController,
              //   decoration: const InputDecoration(label: Text('Factory Name')),
              //   textInputAction: TextInputAction.next,
              //   onFieldSubmitted: (_) {
              //     FocusScope.of(context).requestFocus();
              //   },
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return 'Please enter Factory Name!';
              //     }
              //     return null;
              //   },
              // ),
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
                      print(_partyNameController.text);
                      print(_factoryNameController.text);
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

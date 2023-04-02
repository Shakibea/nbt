// ignore_for_file: prefer_const_constructors, prefer_final_fields, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nbt/resources/firestore_method.dart';
import 'package:nbt/screens/new_order_products_page.dart';
import 'package:provider/provider.dart';

import '../dynamic form/DynamicProductForm.dart';
import '../providers/product_transaction.dart';
import '../providers/transaction.dart';
import '../providers/transactions.dart';
import './login_screen.dart';
import '../widgets/new_order_page/custom_text_field.dart';
import '../widgets/new_order_page/custom_button.dart';

class NewOrderPage extends StatefulWidget {
  const NewOrderPage({Key? key}) : super(key: key);

  static const routeName = "/new-order-page";

  @override
  State<NewOrderPage> createState() => _NewOrderPageState();
}

class _NewOrderPageState extends State<NewOrderPage> {
  var space = 15.0;
  final _form = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _poNumController = TextEditingController();
  final _partyNameController = TextEditingController();
  final _factoryNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _transportationController = TextEditingController();

  var _newOrder = Transaction1(
    id: '',
    productName: '',
    partyName: '',
    factoryName: '',
    address: '',
    quantity: '',
    productDetail: '',
    transportation: '',
    date: DateTime.now(),
  );

  @override
  void initState() {
    _dateController.text = DateFormat.yMMMMd().format(DateTime.now());
    // Future.delayed(Duration(seconds: 1)).then(
    //   (value) =>
    //       Provider.of<Transactions>(context, listen: false).isPartyName(),
    // );
    super.initState();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _poNumController.dispose();
    _partyNameController.dispose();
    _factoryNameController.dispose();
    _addressController.dispose();
    _transportationController.dispose();
    super.dispose();
  }

  // void createOrder() async {
  //   await FirestoreMethod().addOrder(_newOrder);
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (_) => DynamicProductForm(
  //         id: _newOrder.id,
  //       ),
  //     ),
  //   );
  // }

  void _saveForm() {
    var valid = _form.currentState?.validate();
    if (!valid!) {
      return; // not valid
    }
    _form.currentState?.save();

    // Provider.of<Transactions>(context, listen: false).addProduct(_newOrder);
    // Provider.of<Transactions>(context, listen: false).createOrder(_newOrder);
    // Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DynamicProductForm(
          transaction1: _newOrder,
        ),
      ),
    );
  }

  // String partyName = '';
  List<String> partyNames = [];
  List<String> factoryNames = [];

  @override
  Widget build(BuildContext context) {
    // List<String> partyNames =
    //     Provider.of<Transactions>(context, listen: false).partyNames.toList();
    // print(partyNames.length);
    // print(partyNames);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('CREATE NEW ORDER'),
        backgroundColor: const Color(0xff511C74),
        actions: [
          TextButton(
            onPressed: () {
              _saveForm();
            },
            child: Text(
              'Next',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              //Date
              CustomTextField(
                labelText: 'Date',
                keyboardType: TextInputType.none,
                textInputAction: TextInputAction.next,
                enabled: false,
                controller: _dateController,
                onSaved: (value) {
                  _newOrder = Transaction1(
                    id: _newOrder.id,
                    productName: _newOrder.productName,
                    partyName: _newOrder.partyName,
                    factoryName: _newOrder.factoryName,
                    address: _newOrder.address,
                    quantity: _newOrder.quantity,
                    productDetail: _newOrder.productDetail,
                    transportation: _newOrder.transportation,
                    date: DateTime.now(),
                  );
                },
              ),
              SizedBox(height: space),
              //PO Number
              CustomTextField(
                labelText: 'PO Number',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                enabled: true,
                controller: _poNumController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter PO Number!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _newOrder = Transaction1(
                    id: value!,
                    productName: _newOrder.productName,
                    partyName: _newOrder.partyName,
                    factoryName: _newOrder.factoryName,
                    address: _newOrder.address,
                    quantity: _newOrder.quantity,
                    productDetail: _newOrder.productDetail,
                    date: _newOrder.date,
                    transportation: _newOrder.transportation,
                  );
                },
              ),
              SizedBox(height: space),
              // Autocomplete(optionsBuilder: optionsBuilder),
              // RawAutocomplete(
              //   optionsBuilder: (TextEditingValue textEditingValue) {
              //     if (textEditingValue.text == '') {
              //       return const Iterable<String>.empty();
              //     } else {
              //       List<String> matches = <String>[];
              //       matches.addAll(suggestion.toList());
              //       print(matches.length);
              //
              //       matches.retainWhere((s) {
              //         return s
              //             .toLowerCase()
              //             .contains(textEditingValue.text.toLowerCase());
              //       });
              //       return matches;
              //     }
              //   },
              //   onSelected: (String selection) {
              //     print('You just selected $selection');
              //   },
              //   fieldViewBuilder: (BuildContext context,
              //       TextEditingController textEditingController,
              //       FocusNode focusNode,
              //       VoidCallback onFieldSubmitted) {
              //     return TextField(
              //       decoration: InputDecoration(border: OutlineInputBorder()),
              //       controller: textEditingController,
              //       focusNode: focusNode,
              //       onSubmitted: (String value) {},
              //     );
              //   },
              //   optionsViewBuilder: (BuildContext context,
              //       void Function(String) onSelected,
              //       Iterable<String> options) {
              //     return Material(
              //         child: SizedBox(
              //             height: 200,
              //             child: SingleChildScrollView(
              //                 child: Column(
              //               children: options.map((opt) {
              //                 return InkWell(
              //                     onTap: () {
              //                       onSelected(opt);
              //                     },
              //                     child: Container(
              //                         padding: EdgeInsets.only(right: 60),
              //                         child: Card(
              //                             child: Container(
              //                           width: double.infinity,
              //                           padding: EdgeInsets.all(10),
              //                           child: Text(opt),
              //                         ))));
              //               }).toList(),
              //             ))));
              //   },
              // ),
              // Card(
              //   child: TextField(
              //     decoration: InputDecoration(
              //         prefixIcon: Icon(Icons.search), hintText: 'Search...'),
              //     onChanged: (val) {
              //       setState(() {
              //         partyName = val;
              //       });
              //     },
              //   ),
              // ),

              CustomTextField(
                labelText: 'Party Name',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                enabled: true,
                controller: _partyNameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Product Name!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _newOrder = Transaction1(
                    id: _newOrder.id,
                    productName: _newOrder.productName,
                    partyName: value!,
                    factoryName: _newOrder.factoryName,
                    address: _newOrder.address,
                    quantity: _newOrder.quantity,
                    productDetail: _newOrder.productDetail,
                    date: _newOrder.date,
                    transportation: _newOrder.transportation,
                  );
                },
              ),

              //////////////////////
              // StreamBuilder<QuerySnapshot>(
              //   stream:
              //       FirebaseFirestore.instance.collection('orders').snapshots(),
              //   builder: (context, snapshots) {
              //     return (snapshots.connectionState == ConnectionState.waiting)
              //         ? Center(
              //             child: CircularProgressIndicator(),
              //           )
              //         : Container(
              //             // height: 200,
              //             width: double.infinity,
              //             child: ListView.builder(
              //               shrinkWrap: true,
              //               itemCount: snapshots.data!.docs.length,
              //               itemBuilder: (context, index) {
              //                 var data = snapshots.data!.docs[index].data()
              //                     as Map<String, dynamic>;
              //
              //                 // for (String name in snapshots.data!.docs[index]
              //                 //     ['partyName']) {
              //                 //   suggestion.add(name.toString());
              //                 // }
              //
              //                 return RawAutocomplete(
              //                   optionsBuilder:
              //                       (TextEditingValue textEditingValue) {
              //                     if (textEditingValue.text == '') {
              //                       return const Iterable<String>.empty();
              //                     } else {
              //                       List<String> matches = <String>[];
              //                       matches.add(data['partyName']);
              //                       // matches.addAll(FirebaseFirestore.instance.collection('orders'));
              //                       print(matches.length);
              //
              //                       matches.retainWhere((s) {
              //                         return s.toLowerCase().contains(
              //                             textEditingValue.text.toLowerCase());
              //                       });
              //                       return matches;
              //                     }
              //                   },
              //                   onSelected: (String selection) {
              //                     print('You just selected $selection');
              //                   },
              //                   fieldViewBuilder: (BuildContext context,
              //                       TextEditingController textEditingController,
              //                       FocusNode focusNode,
              //                       VoidCallback onFieldSubmitted) {
              //                     return CustomTextField(
              //                       labelText: 'Party Name',
              //                       keyboardType: TextInputType.text,
              //                       textInputAction: TextInputAction.next,
              //                       enabled: true,
              //                       controller: _partyNameController,
              //                       validator: (value) {
              //                         if (value!.isEmpty) {
              //                           return 'Please enter Product Name!';
              //                         }
              //                         return null;
              //                       },
              //                       onSaved: (value) {
              //                         _newOrder = Transaction1(
              //                           id: _newOrder.id,
              //                           productName: _newOrder.productName,
              //                           partyName: value!,
              //                           factoryName: _newOrder.factoryName,
              //                           address: _newOrder.address,
              //                           quantity: _newOrder.quantity,
              //                           productDetail: _newOrder.productDetail,
              //                           date: _newOrder.date,
              //                         );
              //                       },
              //                     );
              //                   },
              //                   optionsViewBuilder: (BuildContext context,
              //                       void Function(String) onSelected,
              //                       Iterable<String> options) {
              //                     return Material(
              //                         child: SizedBox(
              //                             height: 200,
              //                             child: SingleChildScrollView(
              //                                 child: Column(
              //                               children: options.map((opt) {
              //                                 return InkWell(
              //                                     onTap: () {
              //                                       onSelected(opt);
              //                                     },
              //                                     child: Container(
              //                                         padding: EdgeInsets.only(
              //                                             right: 60),
              //                                         child: Card(
              //                                             child: Container(
              //                                           width: double.infinity,
              //                                           padding:
              //                                               EdgeInsets.all(10),
              //                                           child: Text(opt),
              //                                         ))));
              //                               }).toList(),
              //                             ))));
              //                   },
              //                 );
              //               },
              //             ),
              //           );
              //   },
              // ),

              //Suggestions
              // StreamBuilder<QuerySnapshot>(
              //   stream:
              //       FirebaseFirestore.instance.collection('orders').snapshots(),
              //   builder: (context, snapshots) {
              //     return (snapshots.connectionState == ConnectionState.waiting)
              //         ? Center(
              //             child: CircularProgressIndicator(),
              //           )
              //         : Container(
              //             height: 202,
              //             width: double.infinity,
              //             // color: Colors.red,
              //             child: ListView.builder(
              //               // physics: NeverScrollableScrollPhysics(),
              //               itemCount: snapshots.data!.docs.length,
              //               itemBuilder: (context, index) {
              //                 final snap = snapshots.data!.docs
              //                     .map((e) => Transaction1.fromJson(
              //                         e.data() as Map<String, dynamic>))
              //                     .toList();
              //
              //                 // print(snap[index].partyName);
              //                 // print('factory name');
              //                 // print(snap[index].factoryName);
              //
              //                 // partyNames.addAll(
              //                 //     snap.map((e) => e.partyName).toList());
              //
              //                 return Column(
              //                   children: [
              //                     RawAutocomplete(
              //                       optionsBuilder:
              //                           (TextEditingValue textEditingValue) {
              //                         if (textEditingValue.text == '') {
              //                           return const Iterable<String>.empty();
              //                         } else {
              //                           List<String> matches = <String>[];
              //
              //                           // matches.addAll(partyNames);
              //                           matches.addAll(snap
              //                               .map((e) => e.partyName)
              //                               .toList());
              //
              //                           print(matches.length);
              //
              //                           matches.retainWhere((s) {
              //                             return s.toLowerCase().contains(
              //                                 textEditingValue.text
              //                                     .toLowerCase());
              //                           });
              //                           return matches;
              //                         }
              //                       },
              //                       onSelected: (String selection) {
              //                         print('You just selected $selection');
              //                       },
              //                       fieldViewBuilder: (BuildContext context,
              //                           TextEditingController
              //                               textEditingController,
              //                           FocusNode focusNode,
              //                           VoidCallback onFieldSubmitted) {
              //                         return CustomTextField(
              //                           labelText: 'Party Name',
              //                           keyboardType: TextInputType.text,
              //                           textInputAction: TextInputAction.next,
              //                           enabled: true,
              //                           controller: textEditingController,
              //                           focusNode: focusNode,
              //                           // controller: _partyNameController,
              //                           validator: (value) {
              //                             if (value!.isEmpty) {
              //                               return 'Please enter Product Name!';
              //                             }
              //                             return null;
              //                           },
              //                           onSaved: (value) {
              //                             _newOrder = Transaction1(
              //                               id: _newOrder.id,
              //                               productName: _newOrder.productName,
              //                               partyName: value!,
              //                               factoryName: _newOrder.factoryName,
              //                               address: _newOrder.address,
              //                               quantity: _newOrder.quantity,
              //                               productDetail:
              //                                   _newOrder.productDetail,
              //                               date: _newOrder.date,
              //                               transportation:
              //                                   _newOrder.transportation,
              //                             );
              //                           },
              //                         );
              //                       },
              //                       optionsViewBuilder: (BuildContext context,
              //                           void Function(String) onSelected,
              //                           Iterable<String> options) {
              //                         return Material(
              //                             child: SizedBox(
              //                                 height: 200,
              //                                 child: SingleChildScrollView(
              //                                     child: Column(
              //                                   children: options.map((opt) {
              //                                     return InkWell(
              //                                         onTap: () {
              //                                           onSelected(opt);
              //                                         },
              //                                         child: Container(
              //                                             padding:
              //                                                 EdgeInsets.only(
              //                                                     right: 60),
              //                                             child: Card(
              //                                                 child: Container(
              //                                               width:
              //                                                   double.infinity,
              //                                               padding:
              //                                                   EdgeInsets.all(
              //                                                       10),
              //                                               child: Text(opt),
              //                                             ))));
              //                                   }).toList(),
              //                                 ))));
              //                       },
              //                     ),
              //                     SizedBox(height: space),
              //                     RawAutocomplete(
              //                       optionsBuilder:
              //                           (TextEditingValue textEditingValue) {
              //                         if (textEditingValue.text == '') {
              //                           return const Iterable<String>.empty();
              //                         } else {
              //                           List<String> matchesF = [];
              //                           matchesF.addAll(snap
              //                               .map(
              //                                   (e) => e.factoryName.toString())
              //                               .toList());
              //                           // matches.addAll(FirebaseFirestore.instance.collection('orders'));
              //                           print(matchesF.length);
              //
              //                           matchesF.retainWhere((s) {
              //                             return s.toLowerCase().contains(
              //                                 textEditingValue.text
              //                                     .toLowerCase());
              //                           });
              //                           return matchesF;
              //                         }
              //                       },
              //                       onSelected: (String selection) {
              //                         print('You just selected $selection');
              //                       },
              //                       fieldViewBuilder: (BuildContext context,
              //                           TextEditingController
              //                               textEditingController,
              //                           FocusNode focusNode,
              //                           VoidCallback onFieldSubmitted) {
              //                         return CustomTextField(
              //                           labelText: 'Factory Name',
              //                           keyboardType: TextInputType.text,
              //                           textInputAction: TextInputAction.next,
              //                           enabled: true,
              //                           controller: textEditingController,
              //                           focusNode: focusNode,
              //                           // validator: (value) {
              //                           //   if (value!.isEmpty) {
              //                           //     return 'Please enter Factory Name!';
              //                           //   }
              //                           //   return null;
              //                           // },
              //                           onSaved: (value) {
              //                             _newOrder = Transaction1(
              //                               id: _newOrder.id,
              //                               productName: _newOrder.productName,
              //                               partyName: _newOrder.partyName,
              //                               factoryName: value!,
              //                               address: _newOrder.address,
              //                               quantity: _newOrder.quantity,
              //                               productDetail:
              //                                   _newOrder.productDetail,
              //                               date: _newOrder.date,
              //                               transportation:
              //                                   _newOrder.transportation,
              //                             );
              //                           },
              //                         );
              //                       },
              //                       optionsViewBuilder: (BuildContext context,
              //                           void Function(String) onSelected,
              //                           Iterable<String> options) {
              //                         return Material(
              //                             child: SizedBox(
              //                                 height: 200,
              //                                 child: SingleChildScrollView(
              //                                     child: Column(
              //                                   children: options.map((opt) {
              //                                     return InkWell(
              //                                         onTap: () {
              //                                           onSelected(opt);
              //                                         },
              //                                         child: Container(
              //                                             padding:
              //                                                 EdgeInsets.only(
              //                                                     right: 60),
              //                                             child: Card(
              //                                                 child: Container(
              //                                               width:
              //                                                   double.infinity,
              //                                               padding:
              //                                                   EdgeInsets.all(
              //                                                       10),
              //                                               child: Text(opt),
              //                                             ))));
              //                                   }).toList(),
              //                                 ))));
              //                       },
              //                     ),
              //                   ],
              //                 );
              //               },
              //             ),
              //           );
              //   },
              // ),

              SizedBox(height: space),
              // Factory Name
              CustomTextField(
                labelText: 'Factory Name',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                enabled: true,
                controller: _factoryNameController,
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return 'Please enter Factory Name!';
                //   }
                //   return null;
                // },
                onSaved: (value) {
                  _newOrder = Transaction1(
                    id: _newOrder.id,
                    productName: _newOrder.productName,
                    partyName: _newOrder.partyName,
                    factoryName: value!,
                    address: _newOrder.address,
                    quantity: _newOrder.quantity,
                    productDetail: _newOrder.productDetail,
                    date: _newOrder.date,
                    transportation: _newOrder.transportation,
                  );
                },
              ),
              SizedBox(height: space),
              // Address
              CustomTextField(
                labelText: 'Address',
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                enabled: true,
                controller: _addressController,
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return 'Please enter anything';
                //   }
                //   // if (value.length <= 10) {
                //   //   return 'above 10';
                //   // }
                //   return null;
                // },
                onSaved: (value) {
                  _newOrder = Transaction1(
                    id: _newOrder.id,
                    productName: _newOrder.productName,
                    partyName: _newOrder.partyName,
                    factoryName: _newOrder.factoryName,
                    address: value!,
                    quantity: _newOrder.quantity,
                    productDetail: _newOrder.productDetail,
                    date: _newOrder.date,
                  );
                },
              ),
              SizedBox(height: space),
              // Transportation
              CustomTextField(
                labelText: 'Transportation',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                enabled: true,
                controller: _transportationController,
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return 'Please enter Transportation Name!';
                //   }
                //   return null;
                // },
                onSaved: (value) {
                  _newOrder = Transaction1(
                    id: _newOrder.id,
                    productName: _newOrder.productName,
                    partyName: _newOrder.partyName,
                    factoryName: _newOrder.factoryName,
                    transportation: value!,
                    address: _newOrder.address,
                    quantity: _newOrder.quantity,
                    productDetail: _newOrder.productDetail,
                    date: _newOrder.date,
                  );
                },
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
      // resizeToAvoidBottomInset: true,
      // extendBody: true,

      // drawerScrimColor: Colors.white,
      // persistentFooterAlignment: AlignmentDirectional.center,
      // persistentFooterButtons: [
      //   CustomButton(
      //     onTap: _saveForm,
      //     // onTap: () {
      //     //   Navigator.of(context).push(
      //     //     MaterialPageRoute(
      //     //       builder: (_) => DynamicProductForm(
      //     //         id: _newOrder.id,
      //     //       ),
      //     //     ),
      //     //   );
      //     //   createOrder();
      //     // },
      //     text: 'Next',
      //   ),
      // ],
    );
  }
}

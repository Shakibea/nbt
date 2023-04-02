import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nbt/providers/transaction.dart';

class SuggestionPage extends StatefulWidget {
  const SuggestionPage({Key? key}) : super(key: key);

  @override
  State<SuggestionPage> createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  String partyName = '';
  List<String> suggestion = <String>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // RawAutocomplete(
          //   optionsBuilder: (TextEditingValue textEditingValue) {
          //     if (textEditingValue.text == '') {
          //       return const Iterable<String>.empty();
          //     } else {
          //       var matches = [];
          //       matches.addAll(suggestion.toList());
          //       // matches.addAll(FirebaseFirestore.instance.collection('orders'));
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
          //       void Function(String) onSelected, Iterable<String> options) {
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
          Card(
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search), hintText: 'Search...'),
              onChanged: (val) {
                setState(() {
                  partyName = val;
                });
              },
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('orders').snapshots(),
            builder: (context, snapshots) {
              return (snapshots.connectionState == ConnectionState.waiting)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      height: 200,
                      width: double.infinity,
                      child: ListView.builder(
                        itemCount: snapshots.data!.docs.length,
                        itemBuilder: (context, index) {
                          var data = snapshots.data!.docs[index].data()
                              as Map<String, dynamic>;

                          // for (String name in snapshots.data!.docs[index]
                          //     ['partyName']) {
                          //   suggestion.add(name.toString());
                          // }

                          return RawAutocomplete(
                            optionsBuilder:
                                (TextEditingValue textEditingValue) {
                              if (textEditingValue.text == '') {
                                return const Iterable<String>.empty();
                              } else {
                                List<String> matches = <String>[];
                                matches.add(data['partyName']);
                                // matches.addAll(FirebaseFirestore.instance.collection('orders'));
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
                              return TextField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder()),
                                controller: textEditingController,
                                focusNode: focusNode,
                                // onSubmitted: (String value) {},
                              );
                            },
                            optionsViewBuilder: (BuildContext context,
                                void Function(String) onSelected,
                                Iterable<String> options) {
                              return Material(
                                  child: SizedBox(
                                      height: 200,
                                      child: ListView.builder(
                                          itemCount:
                                              snapshots.data!.docs.length,
                                          itemBuilder: (context, index) {
                                            final snap = snapshots.data!.docs
                                                .map((e) =>
                                                    Transaction1.fromJson(
                                                        e.data() as Map<String,
                                                            dynamic>))
                                                .toList();

                                            // print(snap[index].partyName);
                                            // print('factory name');
                                            // print(snap[index].factoryName);

                                            // partyNames.addAll(
                                            //     snap.map((e) => e.partyName).toList());

                                            return Column(
                                              children: options.map((opt) {
                                                return InkWell(
                                                    onTap: () {
                                                      onSelected(opt);
                                                    },
                                                    child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 60),
                                                        child: Card(
                                                            child: Container(
                                                          width:
                                                              double.infinity,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: Text(opt),
                                                        ))));
                                              }).toList(),
                                            );
                                          })));
                            },
                          );
                        },
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nbt/providers/return.dart';
import 'package:nbt/providers/returns.dart';
import 'package:nbt/screens/new_returns_screen.dart';
import 'package:nbt/utils/colors.dart';
import 'package:nbt/widgets/app_drawer.dart';
import 'package:nbt/widgets/returns_list_item.dart';
import 'package:provider/provider.dart';

class ReturnsScreen extends StatelessWidget {
  const ReturnsScreen({Key? key}) : super(key: key);

  static const routeName = '/returns';

  @override
  Widget build(BuildContext context) {
    // var returns = Provider.of<Returns>(context).returns;

    final Query returns = FirebaseFirestore.instance
        .collection('returns')
        .orderBy('date', descending: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Returns'),
        backgroundColor: colors['returns'],
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, NewReturnsScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: SizedBox(
        width: double.infinity,
        height: (MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: StreamBuilder(
          stream: returns.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              final snapShot = streamSnapshot.data!.docs;
              return ListView.builder(
                  itemCount: snapShot.length,
                  itemBuilder: (context, index) {
                    final documentSnapshotToList = snapShot
                        .map((e) =>
                            Return.fromJson(e.data() as Map<String, dynamic>))
                        .toList();

                    return ReturnsListItem(documentSnapshotToList[index]);
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),

        //OLD CODED
        // ListView.builder(
        //   itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        //     value: returns[index],
        //     child: ReturnsListItem(),
        //   ),
        //   itemCount: returns.length,
        // ),
      ),
    );
  }
}

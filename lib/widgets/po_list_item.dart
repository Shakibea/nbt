import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/transaction.dart';

class POListItem extends StatelessWidget {
  // const POListItem({Key? key}) : super(key: key);

//down todo
  Color? _color;

  final availableColors = [
    Colors.red,
    Colors.purple,
    Colors.yellow,
    Colors.orangeAccent
  ];
  void color() {
    // _color = availableColors[Random().nextInt(4)]
    if (2 > 500) {
      _color = availableColors[0];
    } else if (1 < 500 && 3 > 300) {
      _color = availableColors[2];
    } else {
      _color = availableColors[3];
    }
  }
  //up todo

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Transaction>(context, listen: false);
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
            backgroundColor: _color,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: Text(
                  product.id,
                ),
              ),
            ),
            radius: 30),
        title: Text(
          product.productName,
          // style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMMd().add_Hm().format(product.date),
        ),
        trailing: IconButton(
          color: Theme.of(context).errorColor,
          icon: const Icon(Icons.delete),
          onPressed: () {},
        ),
      ),
    );
  }
}

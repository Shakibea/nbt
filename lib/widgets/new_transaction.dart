import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/adaptive_text_button.dart';
import '../widgets/input_text_field.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTrnx;

  NewTransaction(this.addNewTrnx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleText = TextEditingController();
  final _amountText = TextEditingController();
  // When not initializing variable just use Nullable type '?'
  // use also '!' when returning.
  // DateTime? _selectedDate;
  var _selectedDate = DateTime.now();

  void _submitData() {
    if (_amountText.text.isEmpty) {
      return;
    }
    final addTitle = _titleText.text;
    final addAmount = double.parse(_amountText.text);

    if (addTitle.isEmpty || addAmount <= 0 || _selectedDate == null) {
      return;
    }
    // special property created for Function which is passed in constructor.
    // help us to persist modal input data by 'widget'
    // widget can access class related
    widget.addNewTrnx(addTitle, addAmount, _selectedDate);

    // poping up the top most screen.
    // exit the modal after new entry.
    // context is special property which can access context related.
    Navigator.of(context).pop();
  }

  void _presentSelectDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickDate) {
      if (pickDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      // elevation: 5,
      child: Container(
        padding: const EdgeInsets.only(
            top: 15,
            right: 15,
            left: 15,
            // MediaQuery.of(context).viewInsets.bottom
            bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InputTextField(
                textTitle: 'Title',
                textAmount: 'Amount',
                titleController: _titleText,
                amountController: _amountText,
                handler: _submitData),
            Container(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Text(
                        _selectedDate == null
                            ? 'Select Any Date!'
                            : DateFormat.yMd().format(_selectedDate),
                        style: Theme.of(context).textTheme.headline6),
                  ),

                  /* TextButton(
                    onPressed: _presentSelectDate,
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor),
                    child: Text('Add Expense'),
                  ), */
                  AdaptiveTextButton('Choose any date', _presentSelectDate),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              child: ElevatedButton(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor),
                child: const Text('Add Expense'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

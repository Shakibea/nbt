import 'package:flutter/material.dart';
import 'package:nbt/providers/transaction.dart';

class NewOrderMultiForm extends StatefulWidget {
  final index;
  Transaction1 contactModel;
  final Function onRemove;

  NewOrderMultiForm(
      {required this.contactModel, required this.onRemove, this.index});

  @override
  State<NewOrderMultiForm> createState() => _NewOrderMultiFormState();
}

class _NewOrderMultiFormState extends State<NewOrderMultiForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Contact - ${widget.index}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.orange),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          //Clear All forms Data
                          widget.contactModel.productName = "";
                          widget.contactModel.price = "";
                          widget.contactModel.quantity = "";
                          _nameController.clear();
                          _contactController.clear();
                          _emailController.clear();
                        });
                      },
                      child: const Text(
                        "Clear",
                        style: TextStyle(color: Colors.blue),
                      )),
                  TextButton(
                      onPressed: () => widget.onRemove(),
                      child: const Text(
                        "Remove",
                        style: TextStyle(color: Colors.blue),
                      )),
                ],
              ),
            ],
          ),
          TextFormField(
            controller: _nameController,
            // initialValue: widget.contactModel.name,
            onChanged: (value) => widget.contactModel.productName = value,
            onSaved: (value) =>
                widget.contactModel.productName = value ?? 'default',
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
              border: OutlineInputBorder(),
              hintText: "Enter Name",
              labelText: "Name",
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _contactController,
            onChanged: (value) => widget.contactModel.price = value,
            onSaved: (value) => widget.contactModel.price = value ?? 'default',
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
              border: OutlineInputBorder(),
              hintText: "Enter Number",
              labelText: "Number",
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _emailController,
            onChanged: (value) => widget.contactModel.quantity = value,
            onSaved: (value) =>
                widget.contactModel.quantity = value ?? 'default',
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
              border: OutlineInputBorder(),
              hintText: "Enter Email",
              labelText: "Email",
            ),
          ),
        ],
      ),
    );
  }
}

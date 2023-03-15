import 'package:flutter/material.dart';

import 'empty_state.dart';
import 'form.dart';
import 'user.dart';

class MultiForm extends StatefulWidget {
  @override
  _MultiFormState createState() => _MultiFormState();
}

class _MultiFormState extends State<MultiForm> {
  List<UserForm> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: .0,
        leading: const Icon(
          Icons.wb_cloudy,
        ),
        title: const Text('REGISTER USERS'),
        actions: <Widget>[
          ElevatedButton(
            child: Text('Save'),
            onPressed: onSave,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF30C1FF),
              Color(0xFF2AA7DC),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            users.length <= 0
                ? Center(
                    child: EmptyState(
                      title: 'Oops',
                      message: 'Add form by tapping add button below',
                    ),
                  )
                : Flexible(
                    child: ListView.builder(
                      addAutomaticKeepAlives: true,
                      itemCount: users.length,
                      itemBuilder: (_, i) => users[i],
                    ),
                  ),
            // TextFormField(
            //   decoration: const InputDecoration(label: Text('Date')),
            //   textInputAction: TextInputAction.next,
            //   enabled: false,
            // ),
            /*TextFormField(
              decoration: const InputDecoration(label: Text('PO Number')),
              textInputAction: TextInputAction.next,
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
            ),*/
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddForm,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  ///on form user deleted
  void onDelete(User user) {
    setState(() {
      var find = users.firstWhere(
        (it) => it.user == user,
        // orElse: (){
        //
        // },
      );
      if (find != null) users.removeAt(users.indexOf(find));

      print("Your list find Id: $find");
    });
  }

  ///on add form
  void onAddForm() {
    setState(() {
      var _user = User();
      users.add(UserForm(
        user: _user,
        onDelete: () => onDelete(_user),
      ));

      print("Your users list: $users");
    });
  }

  ///on save forms
  void onSave() {
    if (users.length > 0) {
      var allValid = true;
      for (var form in users) {
        allValid = allValid && form.isValid();
      }
      if (allValid) {
        var data = users.map((it) => it.user).toList();
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text('List of Users'),
              ),
              body: ListView.builder(
                itemCount: data.length,
                itemBuilder: (_, i) => ListTile(
                  leading: CircleAvatar(
                    child: Text(data[i].fullName.substring(0, 1)),
                  ),
                  title: Text(data[i].fullName),
                  subtitle: Text(data[i].email),
                ),
              ),
            ),
          ),
        );
      }
    }
  }
}

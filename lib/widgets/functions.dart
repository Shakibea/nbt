import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nbt/widgets/snackbar_widget.dart';

void checkAuth(BuildContext context, VoidCallback callBackFunction) =>
    FirebaseAuth.instance.currentUser == null
        ? ScaffoldMessenger.of(context).showSnackBar(snackBar(context))
        : callBackFunction;

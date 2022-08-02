import 'package:flutter/material.dart';
import 'package:nbt/utils/colors.dart';

PreferredSizeWidget? appBarForNewOrder(String title) {
  return AppBar(
    title: Text(title),
    backgroundColor: colors['order'],
  );
}

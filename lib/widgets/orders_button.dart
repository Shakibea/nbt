import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrdersButton extends StatelessWidget {
  final String title;
  final String icon;
  final int color;

  OrdersButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 110,
          height: 110,
          child: Card(
            elevation: 20,
            color: Color(color),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  icon,
                  width: 42,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          title,
          style: GoogleFonts.openSans(
              textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}

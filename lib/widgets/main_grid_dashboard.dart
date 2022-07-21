import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nbt/screens/inventory_screen.dart';
import 'package:nbt/screens/po_list_screen.dart';
import 'package:nbt/screens/requisition_screen.dart';

import '../screens/new_orders_screen.dart';
import '../models/dashboard_items.dart';

class MainGridDashboard extends StatelessWidget {
  var items = [
    DashboardItems(
      title: "New Orders",
      subtitle: "March, Wednesday",
      event: "3 Events",
      img: "lib/assets/new_order_icon.png",
      color: 0xff453658,
    ),
    DashboardItems(
      title: "Requisition",
      subtitle: "Bocali, Apple",
      event: "4 Items",
      img: "lib/assets/requisition_icon.png",
      color: 0xff662D91,
    ),
    DashboardItems(
      title: "Inventory",
      subtitle: "Lucy Mao going to Office",
      event: "",
      img: "lib/assets/inventory_icon.png",
      color: 0xff0057A5,
    ),
    DashboardItems(
      title: "The Team",
      subtitle: "Rose favirited your Post",
      event: "",
      img: "lib/assets/team_icon.png",
      color: 0xff007DC5,
    ),
    DashboardItems(
      title: "Returns",
      subtitle: "Homework, Design",
      event: "4 Items",
      img: "lib/assets/returns_icon.png",
      color: 0xff279758,
    ),
    DashboardItems(
      title: "Accounts",
      subtitle: "",
      event: "2 Items",
      img: "lib/assets/accounts_icon.png",
      // img: "lib/assets/notices_icon.png",
      color: 0xff89BA2B,
    ),
    DashboardItems(
      title: "CCTVs",
      subtitle: "",
      event: "2 Items",
      img: "lib/assets/cctv_icon.png",
      color: 0xff633A0C,
    ),
    DashboardItems(
      title: "Notices",
      subtitle: "",
      event: "2 Items",
      img: "lib/assets/notices_icon.png",
      color: 0xffF77E0B,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 44),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: items.map((item) {
            return Card(
              elevation: 20,
              color: Color(item.color),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(90),
              ),
              child: InkWell(
                //MAIN DASHBOARD BUTTONS, CLICKING BUTTON WILL SHOW DIFFERENT PAGE
                onTap: () {
                  if (item.title == 'New Orders') {
                    Navigator.pushNamed(
                      context,
                      POListScreen.routeName,
                    );
                  }
                  if (item.title == 'Requisition') {
                    Navigator.pushNamed(
                      context,
                      RequisitionScreen.routeName,
                    );
                  }
                  if (item.title == 'Inventory') {
                    Navigator.pushNamed(
                      context,
                      InventoryScreen.routeName,
                    );
                  }
                },
                child: Container(
                  // decoration: BoxDecoration(
                  //     color: Color(color),
                  //     borderRadius: BorderRadius.circular(50)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        item.img,
                        width: 42,
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        item.title,
                        style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                      ),

                      /*SUBTITLE WITH SIZE BOX*/
                      // const SizedBox(
                      //   height: 4,
                      // ),
                      // Text(
                      //   item.subtitle,
                      //   style: GoogleFonts.openSans(
                      //       textStyle: const TextStyle(
                      //           color: Colors.white38,
                      //           fontSize: 10,
                      //           fontWeight: FontWeight.w600)),
                      // ),
                      // const SizedBox(
                      //   height: 7,
                      // ),

                      /*EVENT*/
                      // Text(
                      //   item.event,
                      //   style: GoogleFonts.openSans(
                      //       textStyle: const TextStyle(
                      //           color: Colors.white70,
                      //           fontSize: 11,
                      //           fontWeight: FontWeight.w600)),
                      // ),
                    ],
                  ),
                ),
              ),
            );
          }).toList()),
    );
  }
}

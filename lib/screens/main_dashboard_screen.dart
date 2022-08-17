import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nbt/screens/login_screen.dart';

import '../widgets/main_grid_dashboard.dart';

class MainDashboardScreen extends StatelessWidget {
  const MainDashboardScreen({Key? key}) : super(key: key);

  static const routeName = '/main-dashboard';

  @override
  Widget build(BuildContext context) {
    final fireAuth = FirebaseAuth.instance;

    return Scaffold(
      // backgroundColor: const Color(0xff392850),
      body: Column(
        children: <Widget>[
          Container(
            color: const Color(0xff392850),
            child: Column(
              children: [
                const SizedBox(
                  // height: 110,
                  height: 90,
                ),
                StreamBuilder<User?>(
                    stream: fireAuth.authStateChanges(),
                    builder: (context, snapshot) {
                      // if(snapshot.hasData){
                      //   getUser(snapshot.data!.uid);
                      // }
                      return Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  fireAuth.currentUser == null
                                      ? "NBT User"
                                      : "${fireAuth.currentUser!.email.toString()}",
                                  style: GoogleFonts.openSans(
                                      textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  fireAuth.currentUser == null
                                      ? "User Information"
                                      : fireAuth.currentUser!.uid.toString(),
                                  style: GoogleFonts.openSans(
                                      textStyle: const TextStyle(
                                          color: Color(0xffa29aac),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),

                            /*Logout Icon Button*/
                            snapshot.hasData
                                ? IconButton(
                                    alignment: Alignment.topCenter,
                                    icon: const Icon(Icons.logout),
                                    onPressed: () {
                                      fireAuth.signOut();
                                    })
                                : IconButton(
                                    alignment: Alignment.topCenter,
                                    icon: const Icon(Icons.login),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, MyLogin.routeName);
                                    }),
                          ],
                        ),
                      );
                    }),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          MainGridDashboard(),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nbt/models/user_auth.dart';
import 'package:nbt/screens/po_list_screen.dart';
import 'package:nbt/screens/returns_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_dashboard_screen.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  static const routeName = '/login';

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String role = 'user';

  Future<void> setUserRole(String roleP) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('user_role', roleP);
  }

  void _checkAuth() async {
    final fireCurrentAuth = FirebaseAuth.instance.currentUser!.uid;
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(fireCurrentAuth.toString())
        .get();

    role = snapshot['role'];
    print('your role: $role');

    if (role == 'admin') {
      setUserRole(role);
      print('your role: $role');
      // Navigator.pushReplacementNamed(context, MinDashboardScreen.routeName);
    } else if (role == 'member') {
      setUserRole(role);
      print('your role: $role');
      // Navigator.pushReplacementNamed(context, MainDashboardScreen.routeName);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future singIn() async {
    // showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (context) => const Center(
    //           child: CircularProgressIndicator(),
    //         ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());

      if (FirebaseAuth.instance.currentUser != null) {
        _checkAuth();

        Navigator.pop(context);
        // Navigator.pushReplacementNamed(context, ReturnsScreen.routeName);
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    // navigatorKey.currentState!.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('lib/assets/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Container(
            padding: const EdgeInsets.only(left: 35, top: 80),
            child: const Text(
              "Welcome\nBack",
              style: TextStyle(color: Colors.white, fontSize: 33),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  right: 35,
                  left: 35,
                  top: MediaQuery.of(context).size.height * 0.5),
              child: Column(children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Color(0xff4c505b),
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: const Color(0xff4c505b),
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () {
                          singIn();
                        },
                        icon: const Icon(Icons.arrow_forward),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, 'register');
                  //   },
                  //   child: const Text(
                  //     'Sign Up',
                  //     style: TextStyle(
                  //       decoration: TextDecoration.underline,
                  //       fontSize: 18,
                  //       color: Color(0xff4c505b),
                  //     ),
                  //   ),
                  // ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot Password',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 18,
                        color: Color(0xff4c505b),
                      ),
                    ),
                  ),
                ]),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}

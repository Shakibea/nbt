import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
      backgroundColor: Colors.brown,
    ),
  );
}

// Future<bool> isInternet() async {
//   var connectivityResult = await (Connectivity().checkConnectivity());
//   if (connectivityResult == ConnectivityResult.mobile) {
//     // I am connected to a mobile network, make sure there is actually a net connection.
//     if (await DataConnectionChecker().hasConnection) {
//       // Mobile data detected & internet connection confirmed.
//       return true;
//     } else {
//       // Mobile data detected but no internet connection found.
//       return false;
//     }
//   } else if (connectivityResult == ConnectivityResult.wifi) {
//     // I am connected to a WIFI network, make sure there is actually a net connection.
//     if (await DataConnectionChecker().hasConnection) {
//       // Wifi detected & internet connection confirmed.
//       return true;
//     } else {
//       // Wifi detected but no internet connection found.
//       return false;
//     }
//   } else {
//     // Neither mobile data or WIFI detected, not internet connection found.
//     return false;
//   }
// }

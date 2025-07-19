// // ignore_for_file: library_private_types_in_public_api

// import 'package:flutter/material.dart';

// import '../../comman/color_codes.dart';

// class BottomBar extends StatefulWidget {
//   const BottomBar({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _BottomBarState createState() => _BottomBarState();
// }

// class _BottomBarState extends State<BottomBar> {
//   int _selectedIndex = 0;
//   Color color = const Color(0xff3a3a3a);

//   List<Widget> page1 = [
//     HomeScreen(),
//     Reports(),
//     FeedBack(),
//     Inventory(),
//     More(),
//   ];

//   List<String> icons1 = [
//     'assets/FoodRestaurant/icon1234.png',
//     'assets/FoodRestaurant/icon1231.png',
//     'assets/FoodRestaurant/icon1233.png',
//     'assets/FoodRestaurant/icon1232.png',
//     'assets/FoodRestaurant/icon12331.png',
//   ];

//   List<String> iconName1 = [
//     'Home',
//     'Reports',
//     'Feedback',
//     'Inventory',
//     'More',
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   void initState() {
//     _selectedIndex = 0;
//     WidgetsBinding.instance?.addPostFrameCallback((_) {
//       final receivedAction = ModalRoute.of(context)?.settings.arguments;

//       print("2222222222222222222222222222222222");
//       print("**************entered into bottom bar*****$receivedAction");
//       // Access context or perform actions here
//     });

//     //  HomeScreenRepository().OrderListByStatusWise(type: "Pending");
//     // FirebaseMessaging.onMessage.listen(
//     //   (RemoteMessage message) async {
//     //     debugPrint("onMessage:");

//     //     print("payload checking1... in main ${message.data["payload"]}");
//     //     dynamic r = jsonDecode(message.data["payload"]);
//     //     print("payload checking2... in main ${r}");
//     //     print("payload checking3... in main ${r["type"]}");
//     //     if (r["type"] == "new_order") {
//     //       print("into if condition");
//     //       final snackBar = await SnackBar(
//     //           duration: const Duration(seconds: 6),
//     //           backgroundColor: Color.fromARGB(255, 236, 92, 9),
//     //           content: Row(
//     //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //             children: [
//     //               // CircularProgressIndicator(
//     //               //   backgroundColor: const Color(0xffffffff),
//     //               //   value: controller!.value,
//     //               //   // semanticsLabel: 'Circular progress indicator',
//     //               // ),
//     //               Text(
//     //                 "You Have Got a New Order",
//     //                 style: TextStyle(
//     //                     color: Colors.white,
//     //                     fontFamily: "",
//     //                     fontSize: 14,
//     //                     fontWeight: FontWeight.w400),
//     //               ),
//     //               InkWell(
//     //                   onTap: () {
//     //                     Navigator.pushNamedAndRemoveUntil(
//     //                         context, "/BottomBar", (route) => false);
//     //                     // player.stop();
//     //                     ScaffoldMessenger.of(context).hideCurrentSnackBar();
//     //                   },
//     //                   child: Container(
//     //                     decoration: BoxDecoration(
//     //                         borderRadius: BorderRadius.circular(5),
//     //                         color: Colors.white),
//     //                     child: Padding(
//     //                       padding: const EdgeInsets.symmetric(
//     //                           horizontal: 15, vertical: 10),
//     //                       child: Text(
//     //                         "View",
//     //                         style: TextStyle(
//     //                             color: Colors.black,
//     //                             fontWeight: FontWeight.w400),
//     //                       ),
//     //                     ),
//     //                   ))
//     //             ],
//     //           ));

//     //       // WidgetsBinding.instance.addPostFrameCallback((_) {
//     //       // ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     //       // player.play(AssetSource("raw/flymengoBuzzer.wav"));
//     //       // });
//     //     }

//     //     // dynamic e = jsonEncode(message.data["payload"]);
//     //     // print("payload checking4... in main ${e}");

//     //     // log("onMessage: $message");
//     //     // final snackBar =
//     //     //     SnackBar(content: Text(message.notification?.title ?? ""));
//     //     // ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     //   },
//     // );

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     DateTime pre_backpress = DateTime.now();

//     return WillPopScope(
//       onWillPop: () async {
//         final timegap = DateTime.now().difference(pre_backpress);
//         final cantExit = timegap >= Duration(seconds: 2);
//         pre_backpress = DateTime.now();
//         if (cantExit) {
//           //show snackbar
//           final snack = SnackBar(
//             content: Text('Press Back button again to Exit'),
//             duration: Duration(seconds: 2),
//           );
//           ScaffoldMessenger.of(context).showSnackBar(snack);
//           return false; // false will do nothing when back press
//         } else {
//           return true; // true will exit the app
//         }
//       },
//       child: Scaffold(
//         body: Center(child: page1.elementAt(_selectedIndex)),
//         bottomNavigationBar: BottomNavigationBar(
//           backgroundColor: Colors.white,
//           currentIndex: _selectedIndex,
//           selectedItemColor: appThemeColor,
//           onTap: _onItemTapped,
//           elevation: 5,
//           showUnselectedLabels: true,
//           type: BottomNavigationBarType.fixed,
//           unselectedItemColor: const Color(0xff3A3A3A),
//           unselectedLabelStyle: TextStyle(
//             color: color.withGreen(5),
//             fontSize: 10,
//             fontFamily: 'ProximaNova',
//             fontWeight: FontWeight.w400,
//           ),
//           selectedLabelStyle: const TextStyle(
//             color: Color(0xFF3A3A3A),
//             fontSize: 10,
//             fontFamily: 'ProximaNova',
//             fontWeight: FontWeight.w400,
//             height: 1.5,
//           ),
//           items: [
//             BottomNavigationBarItem(
//               icon: ImageIcon(AssetImage(icons1[0]), size: 21),
//               label: iconName1[0],
//             ),
//             BottomNavigationBarItem(
//               icon: ImageIcon(AssetImage(icons1[1]), size: 21),
//               label: iconName1[1],
//             ),
//             BottomNavigationBarItem(
//               icon: ImageIcon(AssetImage(icons1[2]), size: 21),
//               label: iconName1[2],
//             ),
//             BottomNavigationBarItem(
//               icon: ImageIcon(AssetImage(icons1[3]), size: 21),
//               label: iconName1[3],
//             ),
//             BottomNavigationBarItem(
//               icon: ImageIcon(AssetImage(icons1[4]), size: 21),
//               label: iconName1[4],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

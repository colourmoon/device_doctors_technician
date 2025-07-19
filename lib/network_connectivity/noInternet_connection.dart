// ignore: file_names
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:device_doctors_technician/utility/auth_shared_pref.dart';

import 'dart:async';

import 'network_controller.dart';

class NoInternetConnection extends StatefulWidget {
  @override
  _NoInternetConnectionState createState() => _NoInternetConnectionState();
}

class _NoInternetConnectionState extends State<NoInternetConnection> {
  final NetworkController _networkController = Get.find<NetworkController>();

  // CategoryController _netWorkController = Get.find<CategoryController>();

  // final Connectivity _connectivity = Connectivity();

  // StreamSubscription _streamSubscription;

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  callbackmethod() {
    if (_networkController.connectionStatus.value != 0) {
      // Get.to(() => VendorLoginPage());
      // Navigator.pop(context);
      // Navigator.pushReplacement(
      //     context,
      //     CupertinoPageRoute(
      //       builder: (context) => GmapService(
      //         frompage: "networkcontroller",
      //       ),
      //     ));
      autoLoginfun();
    }
  }

  autoLoginfun() async {
    Timer(const Duration(seconds: 1), () {
      if (Constants.prefs?.getString('access_token') == null) {
        Navigator.pushNamedAndRemoveUntil(context, "/SignIn", (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, "/HomeScreen", (route) => false);
      }
    });
  }

  overlayCheckFun() async {
    // dynamic res = await ;
    // print("overlay res......$res");

    // print("overlay condition is.....${await OverlayState()}");
    // OverlayState();
    // OverlayState;
  }

  var currentBackPressTime;
  var orderid;
  @override
  void initState() {
    super.initState();
    // orderid = Constants.prefs?.getString("service_order_id");
    overlayCheckFun();
    // if (Constants.prefs!.getString("service_order_id") != null) {
    //   print("cherry.....");
    // }
    // if (orderid != null) {
    // if(OverlaySupportEntry.of(context).isBlank == true){

    // OverlaySupportEntry.of(context)!.dismiss();
    // }

    // }

    callbackmethod();
    connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(callbackmethod());
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive,
    //     overlays: [SystemUiOverlay.top]);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // callbackmethod();
    // connectivitySubscription =
    //     _connectivity.onConnectivityChanged.listen(callbackmethod());
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset(
                'assets/images/viewtalk-no-internet.json',
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Check your internet connection",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.green;
                    }
                    return Colors.red; // Use the component's default.
                  },
                ),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                )),
              ),
              onPressed: () => {
                callbackmethod(),
              }, //set both onPressed and onLongPressed to null to see the disabled properties
              child: const Text(
                'Try again',
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      FocusManager.instance.primaryFocus?.unfocus();
      Fluttertoast.showToast(msg: 'Tap back again to leave');

      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }
}

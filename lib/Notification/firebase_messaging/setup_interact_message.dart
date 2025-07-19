import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ex_kit/flutter_ex_kit.dart';
import '../PayLoadModel/data.dart';

class SetupInteractMessage {
  final FirebaseMessaging firebaseMessaging;

  SetupInteractMessage({
    required this.firebaseMessaging,
  });

  /// Sets up the interaction with incoming messages and handles navigation.
  void setupInteractMessage() async {
    // Check for any initial message that opened the app
    RemoteMessage? payloads = await firebaseMessaging.getInitialMessage();

    // If there is a payload, convert it to NavigationDetailsModel
    if (payloads != null) {
      _handlePayload(payloads);
    }

    // Listen for messages when the app is in the background
    FirebaseMessaging.onMessageOpenedApp.listen((payloads) {
      output(payloads.notification?.toMap());
      output(payloads.data);
      _handlePayload(payloads);
    });
  }

  /// Handles the incoming payload and navigates to the specified screen.
  void _handlePayload(RemoteMessage payloads) {
    try {
      final navigationDetailsModel =
          NavigationDetailsModel.fromJson(payloads.data);
      // Navigate to the specified screen using the NavigationService

      // BuildContext? context =   MyApp.navigatorObserver.navigator?.context;
      // if(context!=null)
      // NavigationService(context: context).goToScreen(screen: navigationDetailsModel.screen ??'');
    } catch (error) {
      // Handle any parsing or navigation errors
      debugPrint('Error handling payload: $error');
    }
  }
}

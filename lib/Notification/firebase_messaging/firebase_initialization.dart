import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ex_kit/flutter_ex_kit.dart';

class FirebaseInitialization {
  final Function(Map<String, dynamic> data) showNotification;

  FirebaseInitialization({
    required this.showNotification,
  });

  /// Initializes Firebase Messaging and listens for foreground messages.
  Future<void> firebaseInit() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage payloads) async {
      // Extract data from the payload
      output(payloads.toMap());
      Map<String, dynamic> data = payloads.data;

      if (data.isNotEmpty) {
        // Show notification based on the platform
        if (Platform.isAndroid || Platform.isIOS) {
         await showNotification.call(data);
        }
      } else {
        if (kDebugMode) {
          debugPrint('Received empty payload data');
        }
      }
    });
  }
}

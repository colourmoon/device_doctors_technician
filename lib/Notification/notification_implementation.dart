import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ex_kit/flutter_ex_kit.dart';
import 'awesome_notification/awesome_notification_service.dart';
import 'firebase_messaging/firebase_initialization.dart';
import 'firebase_messaging/foreground_message.dart';
import 'firebase_messaging/notification_permissions.dart';
import 'firebase_messaging/setup_interact_message.dart';
import 'awesome_notification/notification_channel_service.dart';
import 'firebase_messaging/background_notification.dart';
import 'uuid.dart';

// Define channel keys
const String _messageKey = 'message';
const String _normal = 'normal';

/// A class to implement notification functionalities.
class NotificationImplementation {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final AwesomeChannelService awesomeChannelService;

  /// Constructor to initialize [NotificationImplementation].
  NotificationImplementation({
    required this.awesomeChannelService,
  });

  /// Initializes Awesome Notifications and creates notification channels.
  Future<void> initialize() async {
    // Initialize Awesome Notifications
    await awesomeChannelService.initializeChannels(
      channels: _createNotificationChannels(),
    );
  }

  /// Creates notification channels for the application.
  List<NotificationChannel> _createNotificationChannels() {
    return [
      awesomeChannelService.createChannel(
        soundSource: awesomeChannelService.sound,
        criticalAlerts: true,
        channelKey: _messageKey,
        channelName: "Warning Notifications",
        channelDescription: "Notification for new orders.",
        ledColor: Colors.green,
        defaultColor: Colors.red,
        importance: NotificationImportance.Max,
        channelShowBadge: true,
        locked: true,
        defaultRingtoneType: DefaultRingtoneType.Notification,
        onlyAlertOnce: true,
        groupKey: 'warning_group',
      ),
      awesomeChannelService.createChannel(
        criticalAlerts: true,
        channelKey: _normal,
        channelName: "Normal Notifications",
        channelDescription: "Notifications for normal alerts.",
        ledColor: Colors.green,
        defaultColor: Colors.red,
        importance: NotificationImportance.Max,
        channelShowBadge: true,
        defaultRingtoneType: DefaultRingtoneType.Notification,
        groupKey: 'normal_group',
      ),
    ];
  }

  fcmInitialize(BuildContext context) {
    BackGroundNotification().backgroundInitializer();
    ForegroundMessage(firebaseMessaging).setForegroundNotificationOptions();
    NotificationPermissions(firebaseMessaging).requestNotificationPermission();

    FirebaseInitialization(
      showNotification: showNotification,
    ).firebaseInit();
    SetupInteractMessage(
      firebaseMessaging: firebaseMessaging,
    ).setupInteractMessage();
  }
}

showNotification(Map<String, dynamic> data, {bool isBackGround = false}) {
  if (data['android_channel_id'] == _messageKey) {
    viewScreen(
        id: data['android_channel_id'],  );
    Map<String, String?>? payload = data.map((key, value) {
      return MapEntry(key, value?.toString());
    });
    AwesomeNotificationService().createChatNotification(
        title: data['title'],
        body: data['body'],
        bigPicture: data['image'],
        channelKey: _messageKey,
        notificationLayout: NotificationLayout.Default,
        uid: generateSSID(),
        payload: payload);
  } else {
    AwesomeNotificationService().createNotification(
        title: data['title'],
        body: data['body'],
        bigPicture: data['image'],
        channelKey: _normal,
        uid: generateSSID());
  }
}

void viewScreen({
  String? id,
}) async {

}

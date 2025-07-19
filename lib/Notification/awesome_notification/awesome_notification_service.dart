import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';

import '../../main.dart';
const String _buttonKey = 'reply';
@pragma('vm:entry-point')
Future<void> _onActionReceivedMethod(ReceivedAction event) async {
  if (event.buttonKeyPressed == _buttonKey) {
  // add defult condiation
  }
}

/// Service for handling notifications using Awesome Notifications package.
class AwesomeNotificationService {
  // Private constants and fields
  static String ids = '';

  /// Creates a notification with optional action buttons and a big picture.
  ///
  /// [id] - The ID for the notification (default is an empty string).
  /// [uid] - The unique ID of the notification.
  /// [title] - The title of the notification.
  /// [body] - The body content of the notification.
  /// [bigPicture] - The URL or asset path of the big picture (optional).
  /// [showButton] - If true, shows an action button in the notification.
  /// [channelKey] - The channel key for categorizing the notification.
  Future<void> createNotification({
    String? id,
    int? uid,
    String? title,
    String? body,
    String? bigPicture,
    required String channelKey,
  }) async {
    await _startListeningNotificationEvents();
    ids = id ?? '';
    await _storeNotificationId(id);

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: uid ?? 0,
        channelKey: channelKey,
        title: title,
        body: body,
        bigPicture: bigPicture,
        notificationLayout: bigPicture != null
            ? NotificationLayout.BigPicture
            : NotificationLayout.Default,
      ),
    );
  }

  /// Creates a notification with optional action buttons and a big picture.
  ///
  /// [id] - The ID for the notification (default is an empty string).
  /// [uid] - The unique ID of the notification.
  /// [title] - The title of the notification.
  /// [body] - The body content of the notification.
  /// [bigPicture] - The URL or asset path of the big picture (optional).
  /// [timeoutAfter] - Duration after which the notification should be dismissed (optional).
  /// [payload] - Custom payload data (optional).
  /// [buttonList] - List of action buttons for the notification (optional).
  /// [wakeUpScreen] - If true, wakes up the screen when the notification is received.
  /// [notificationLayout] - The layout of the notification.
  /// [channelKey] - The channel key for categorizing the notification.
  Future<void> createChatNotification({
    String? id,
    int? uid,
    String? title,
    bool locked = false,
    String? body,
    String? bigPicture,
    String? customSound,
    String? largeIcon,
    bool repeats = false,
    DateTime? scheduledTime,
    bool preciseAlarm = false,
    Duration? timeoutAfter,
    Map<String, String?>? payload,
    bool wakeUpScreen = false,
    bool allowWhileIdle = false,
    NotificationLayout notificationLayout = NotificationLayout.Default,
    required String channelKey,
  }) async {
    NotificationSchedule? schedule;
    if (scheduledTime != null) {
      String localTimeZone =
          await AwesomeNotifications().getLocalTimeZoneIdentifier();

      // Create the notification calendar instance
      schedule = NotificationCalendar(
        timeZone: localTimeZone,
        year: scheduledTime.year,
        month: scheduledTime.month,
        day: scheduledTime.day,
        hour: scheduledTime.hour,
        minute: scheduledTime.minute,
        second: scheduledTime.second,
        millisecond: scheduledTime.millisecond,
        allowWhileIdle: allowWhileIdle,
        repeats: repeats,
        preciseAlarm: preciseAlarm,
      );
    }
    // Start listening for notification events
    _startListeningNotificationEvents();

    // Build action buttons from the buttonList
    List<NotificationActionButton>? actionButtons = _buildActionButtons(true);

    // Create the notification
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: uid ?? 0,
        channelKey: channelKey,
        title: title,
        body: body,
        wakeUpScreen: wakeUpScreen,
        bigPicture: bigPicture,
        largeIcon: largeIcon,
        payload: payload,
        locked: locked,
        timeoutAfter: timeoutAfter,
        customSound: customSound,
        notificationLayout: bigPicture != null
            ? NotificationLayout.BigPicture
            : notificationLayout,
      ),
      schedule: schedule,
      actionButtons: actionButtons,
    );
  }

  /// Cancels a notification by its ID.
  ///
  /// [notificationId] - The ID of the notification to cancel.
  Future<void> cancelNotification(int notificationId) async {
    await AwesomeNotifications().cancel(notificationId);
  }

  /// Cancels all notifications.
  Future<void> cancelAllNotifications() async {
    await AwesomeNotifications().cancelAll();
  }

  /// Resets the global notification badge count.
  Future<void> resetBadge() async {
    await AwesomeNotifications().resetGlobalBadge();
  }

  /// Checks if notifications are allowed and requests permission if not.
  Future<void> checkNotificationPermission() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await requestNotificationPermission();
    }
  }

  /// Requests notification permission from the user.
  Future<void> requestNotificationPermission() async {
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  // Private helper methods

  /// Starts listening for notification action events.
  Future<bool> _startListeningNotificationEvents() async {
    return await AwesomeNotifications().setListeners(
      onActionReceivedMethod: _onActionReceivedMethod,
    );
  }

  /// Handles actions when a notification button is pressed.

  /// Stores the notification ID in secure storage.
  ///
  /// [id] - The notification ID to store.
  Future<void> _storeNotificationId(String? id) async {
    // await SecureStorage.write(key: StorageKey.newOrderItem, value: id ?? '');
  }

  /// Builds action buttons for notifications if required.
  ///
  /// [showButton] - If true, includes an action button.
  List<NotificationActionButton>? _buildActionButtons(bool? showButton) {
    if (showButton ?? true) {
      return [
        NotificationActionButton(
          key: _buttonKey,
          icon: '',
          showInCompactView: true,
          label: 'View Order',
          requireInputText: false,
          autoDismissible: false,
          isDangerousOption: false,
        ),
      ];
    }
    return null;
  }

  /// Navigates to the NewRequestScreen with the stored notification ID.
}

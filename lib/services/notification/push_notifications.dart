import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'local_notification.dart';

checkForInitialMessage() async {
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    debugPrint(
      "app is terminated and opened from notification:\ntitle: ${initialMessage.notification!.title!}\nbody: ${initialMessage.notification!.body!}",
    );
  }
}

registerNotification() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  var initializationSettingsAndroid = const AndroidInitializationSettings(
    '@mipmap/ic_launcher',
  );
  var initializationSettingsIOS = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    onDidReceiveLocalNotification:
        (int? id, String? title, String? body, String? payload) async {},
  );

  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  //*
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse? payload) async {},
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
    RemoteNotification notification = message!.notification!;
    AndroidNotification? android = message.notification?.android!;
    if (android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'notification',
            'Channel for notification',
            largeIcon: DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
          ),
        ),
      );
    }
  });
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.notification != null) {}

  debugPrint('Handling a background message ${message.messageId}');

  return Future<void>.value();
}

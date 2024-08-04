import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void showNotification({required String title, required String body}) {
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
    'notification',
    'Channel for notification',
    icon: '@mipmap/ic_launcher',
    importance: Importance.max,
    priority: Priority.max,
    ticker: 'ticker',
    playSound: true,
  );

  var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();

  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );

  flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    platformChannelSpecifics,
    payload: 'Custom_Sound',
  );
}

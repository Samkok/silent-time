// ignore_for_file: unused_local_variable, prefer_const_constructors
import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class FCMServices {
  // createLocalNotificaion()
  static displyNotification({required String title, required String body}) {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.initialize(const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    ));

    try {
      flutterLocalNotificationsPlugin.show(
        1,
        title,
        body,
        NotificationDetails(
            android: AndroidNotificationDetails(
          "1",
          "test",
          playSound: true,
          priority: Priority.high,
          importance: Importance.high,
          enableVibration: true,
        )),
      );
    } catch (e) {
      print("catch: $e");
    }
  }

  static FutureOr<void> scheduleNotification() async {
    try {
      final FlutterLocalNotificationsPlugin notificationsPlugin =
          FlutterLocalNotificationsPlugin();
      final location = tz.getLocation('Europe/Warsaw');

// Create a TZDateTime from your DateTime
      final scheduledDate = tz.TZDateTime.from(
        DateTime.now().add(Duration(seconds: 10)),
        location,
      );
      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
        '888',
        'channel_name',
        playSound: true,
        priority: Priority.high,
        enableVibration: true,
      );
      const NotificationDetails platformDetails =
          NotificationDetails(android: androidDetails);

      await notificationsPlugin.zonedSchedule(
        888, // Notification ID
        'Scheduled Notification',
        'This is a scheduled notification',
        scheduledDate, // Trigger time
        platformDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
      );
      print("Notification Scheduled");
    } catch (e) {
      print("Catch: e");
    }
  }
}

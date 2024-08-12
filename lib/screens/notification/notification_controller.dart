import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silenttime/models/notification_model.dart';
import 'package:silenttime/services/local_notification_services.dart';

class NotificationController extends GetxController {
  List<NotificationModel> notificationList = [];
  final notificationKey = "notification";

  FutureOr<void> saveNotification(
      {required NotificationModel notification}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      if (notification.title != "null") {
        notificationList.add(notification);
        FCMServices.displyNotification(
          title: notification.title,
          body: notification.description,
        );
      }

      List jsonList =
          notificationList.map((trigger) => trigger.toJson()).toList();
      await prefs.setString(notificationKey, json.encode(jsonList));

      update();
    } catch (e) {
      log(e.toString());
    }
  }

  FutureOr<void> getAllNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var jsonString = prefs.getString(notificationKey);
      if (jsonString != null) {
        Iterable iterable = json.decode(jsonString);
        notificationList = List<NotificationModel>.from(
            iterable.map((model) => NotificationModel.fromJson(model)));
        print('notificationList: ${notificationList.length}');
      }
      update();
    } catch (e) {
      log("catch e: $e");
    }
  }
}

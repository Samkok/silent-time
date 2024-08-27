import 'dart:async';
import 'dart:developer';
import 'package:get/state_manager.dart';
import 'package:silenttime/models/notification_model.dart';
import 'package:silenttime/services/local_notification_services.dart';
import 'package:silenttime/services/shared_preference_service.dart';

class NotificationController extends GetxController {
  List<NotificationModel> notificationList = [];

  FutureOr<void> saveNotification(
      {required NotificationModel notification}) async {

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
      await SharedPreferenceService.setNotifications(jsonList);

      update();
    } catch (e) {
      log(e.toString());
    }
  }

  FutureOr<void> getAllNotification() async {
    try {
      notificationList = await SharedPreferenceService.getNotifications();
      update();
    } catch (e) {
      log("catch e: $e");
    }
  }
}

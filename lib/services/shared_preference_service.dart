import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silenttime/models/notification_model.dart';
import '../models/triger_model.dart';

class SharedPreferenceConstant {
  static String triggers = "triggers";
  static String theme = "theme";
  static String notification = "notification";
}

class SharedPreferenceService {

  static Future<List<TriggerModel>> getTriggers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var jsonString = prefs.getString(SharedPreferenceConstant.triggers);
    if (jsonString != null) {
      Iterable iterable = json.decode(jsonString);
      List<TriggerModel> triggerModelList = List<TriggerModel>.from(
          iterable.map((model) => TriggerModel.fromJson(model)));
      return triggerModelList;
    }
    return [];
  }

  static setTriggerValue(List jsonList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPreferenceConstant.triggers, json.encode(jsonList));
  }

  static setTheme(dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(SharedPreferenceConstant.theme, value);
  }

  static Future<bool?> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SharedPreferenceConstant.theme);
  }

  static setNotifications(List jsonList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPreferenceConstant.notification, json.encode(jsonList));
  }

  static Future<List<NotificationModel>> getNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<NotificationModel> notificationList = [];
    var jsonString = prefs.getString(SharedPreferenceConstant.notification);
    if (jsonString != null) {
      Iterable iterable = json.decode(jsonString);
      notificationList = List<NotificationModel>.from(
          iterable.map((model) => NotificationModel.fromJson(model)));
    }
    return notificationList;
  }
    static Future<void> setLocation(double latitude, double longitude) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setDouble("lat", latitude);
      await prefs.setDouble("long", longitude);    
    }

    static Future<Map<String, double>> getLocation() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      double lat = prefs.getDouble("lat") ?? 0.0;
      double long = prefs.getDouble("long") ?? 0.0;
          return {"lat": lat, "long": long};
    }
}
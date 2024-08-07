import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
    RxBool isLightTheme = false.obs;

  saveThemeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('theme', isLightTheme.value);
  }

  getAndApplyTheme() async {
    isLightTheme.value = await _getThemeFromPref();
    Get.changeThemeMode(isLightTheme.value ? ThemeMode.light : ThemeMode.dark);
  }

  _getThemeFromPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var theme = await prefs.getBool('theme');
    return theme == null ? false : theme;
  }



  ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.amber,
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.amber,
      disabledColor: Colors.grey,
    ));

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blue,
      disabledColor: Colors.grey,
    ));
}
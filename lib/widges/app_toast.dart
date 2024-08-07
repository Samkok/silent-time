import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:silenttime/utils/colors.dart';

appToast({required masg, required bool isEror}) {
  return Fluttertoast.showToast(
      msg: masg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: isEror ? Colors.red : AppColors.primaryBlue,
      textColor: Colors.white,
      fontSize: 16.0);
}

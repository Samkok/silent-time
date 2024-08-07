import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silenttime/utils/colors.dart';

class AppToast {
  static successToast(msg) {
    return Get.snackbar(
      'Success!',
      msg.toString(),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      maxWidth: Get.size.width * 0.8,
      margin: EdgeInsets.only(bottom: 10),
    );
  }

  static failToast(msg) {
    return Get.snackbar(
      'Oops!',
      msg.toString(),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      maxWidth: Get.size.width * 0.8,
      margin: EdgeInsets.only(bottom: 10),
    );
  }

  static infoToast(msg) {
    return Get.snackbar(
      'Oops!',
      msg.toString(),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.yellow,
      colorText: AppColors.primaryBlue,
      maxWidth: Get.size.width * 0.8,
      margin: EdgeInsets.only(bottom: 10),
    );
  }
}

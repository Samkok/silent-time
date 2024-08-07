import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silenttime/controllers/theme_controller.dart';
import 'package:silenttime/utils/colors.dart';

timePiker(context, {TimeOfDay? timeOfDay}) async {
  ThemeController themeController = Get.put(ThemeController());
  final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      
      builder: (BuildContext context, Widget? child) {
        // Customize the look and feel of the dialog using a custom theme.

        if (themeController.isLightTheme.value) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.primaryBlue,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
                secondary: AppColors.primaryBlue,
                onSecondary: Colors.white,
                surfaceVariant: AppColors.primaryBlue.withOpacity(0.3),
              ),
            ),
            child: child!,
          );
        } else {
          return Theme(
            data: ThemeData.dark(useMaterial3: true).copyWith(
              colorScheme: const ColorScheme.dark(
                primary: AppColors.primaryBlue,
                onPrimary: Colors.white,
                surface: AppColors.black,
                onSurface: Colors.black,
                surfaceTint: AppColors.black,
                secondary: AppColors.primaryBlue,
                onSecondary: Colors.black,
                surfaceVariant: Color(0xffCDCCF9),
              ),
            ),
            child: child!,
          );
        }
      });
  if (newTime != null) {
    // dialogController.updateTime(newTime);
    return newTime;
  }
}

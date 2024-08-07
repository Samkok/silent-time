import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:silenttime/screens/my_rules/pages/location_picker.dart';
import 'package:silenttime/utils/app_imaes.dart';
import 'package:silenttime/utils/colors.dart';
import 'package:silenttime/widges/custom_appbar.dart';
import 'package:silenttime/widges/custom_text.dart';

class MyZoneScreen extends StatefulWidget {
  const MyZoneScreen({super.key});

  @override
  State<MyZoneScreen> createState() => _MyZoneScreenState();
}

class _MyZoneScreenState extends State<MyZoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'Select Zone',
        autoleadingIcon: true,
        actionIconVal: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
              height: 400.h,
              width: 380.w,
              image: const AssetImage(
                AppImaes.noFigured,
              )),
          CText(
            text: 'No geofences configured',
            fontSize: 24.sp,
            fontWeight: FontWeight.w400,
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: IconButton(
        padding: EdgeInsets.only(bottom: 10.h),
        icon: const Icon(
          Icons.add_circle,
          size: 45,
        ),
        color: AppColors.primaryBlue,
        onPressed: () {
          addZoneDialog(context);
          // Get.to(() => const SetLocationScreen());
        },
      ),
    );
  }
}

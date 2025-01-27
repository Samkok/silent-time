import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:silenttime/screens/my_rules/controller/myrules_controller.dart';
import 'package:silenttime/utils/colors.dart';
import 'package:silenttime/widges/custom_text.dart';

// ignore: must_be_immutable
class TrigerTitleWidget extends StatelessWidget {
  final String widgetTitle;
  final IconData icondata;
  final bool selectedTab;

  TrigerTitleWidget({
    Key? key,
    required this.widgetTitle,
    required this.icondata,
    required this.selectedTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyRulesController>(
        init: MyRulesController(),
        builder: (controller) {
          return Container(
            height: 64.h,
            // width: 172.w,
            width: 342.w,
            decoration: BoxDecoration(
              color: selectedTab ? AppColors.primaryBlue : AppColors.blueFD,
              borderRadius: BorderRadius.all(
                Radius.circular(8.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  icondata,
                  color: AppColors.whiteColor,
                  size: 24.0,
                ),
                SizedBox(
                  // width: 82.w,
                  width: 162.w,
                  child: CText(
                    text: widgetTitle,
                    fontSize: 16.sp,
                    maxLines: 2,
                    fontWeight: FontWeight.w300,
                    color: AppColors.whiteColor,
                  ),
                )
              ],
            ),
          );
        });
  }
}

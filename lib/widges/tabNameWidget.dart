import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:silenttime/utils/colors.dart';
import 'package:silenttime/widges/custom_text.dart';

// ignore: must_be_immutable
class TabNameWidget extends StatelessWidget {
  String tabName;
  Color tabtcolor;
  final VoidCallback onTap;

  TabNameWidget({
    super.key,
    required this.tabName,
    required this.tabtcolor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      // width: 100.w,
      decoration: BoxDecoration(
        // color: AppColors.readColor,
        border: tabName == "Disabled"
            ? Border(right: BorderSide.none)
            : Border(
                right: BorderSide(
                  color: AppColors.buleF9,
                  width: 2,
                ),
              ),
      ),
      child: Padding(
        padding: EdgeInsets.only(right: 15.w),
        child: Align(
          alignment: Alignment.centerLeft,
          child: CText(
            text: tabName,
            fontSize: 20.sp,
            color: tabtcolor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

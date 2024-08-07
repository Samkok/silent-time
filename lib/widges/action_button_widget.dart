import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:silenttime/utils/colors.dart';
import 'package:silenttime/widges/custom_text.dart';

// ignore: must_be_immutable
class ActionButtonWidget extends StatelessWidget {
  String buttonIcon;
  String buttonText;
  final VoidCallback onPressed;
  Color buttonColor;
  ActionButtonWidget({
    super.key,
    required this.buttonIcon,
    required this.buttonText,
    required this.onPressed,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        // width: 190.w,
        height: 66.h,
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(
              image: AssetImage(buttonIcon),
              height: 20.h,
              width: 20.w,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 15.w,
            ),
            SizedBox(
              width: 127.w,
              child: CText(
                maxLines: 2,
                text: buttonText,
                fontSize: 14.sp,
                fontWeight: FontWeight.w300,
                color: AppColors.whiteColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:silenttime/utils/colors.dart';
import 'custom_text.dart';

congratulationDialog(context) {
  dialogContent(BuildContext context) {
    return Container(
      // height: 266.h,
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(32.r))),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 149.h,
              width: 192.w,
              color: AppColors.primaryBlue,
              // child: Image.asset(
              //   AppImaes.locationLogog,
              //   height: 32.h,
              //   width: 32.h,
              // ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 31.h),
              child: SizedBox(
                width: 311.w,
                child: CText(
                  text: 'Congratulations!',
                  alignText: TextAlign.center,
                  // maxLines: 2,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 32.h, bottom: 32.h),
              child: SizedBox(
                  width: 301.w,
                  child: CText(
                    alignText: TextAlign.center,
                    text:
                        'A new rule is created and you will be notified at the specified time.',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w300,
                    color: AppColors.black,
                  )),
              // InkWell(
              //   onTap: () {},
              //   child: Padding(
              //     padding: EdgeInsets.only(top: 15.h),
              //     child: SizedBox(
              //       width: 311.w,
              //       child: CText(
              //         text: 'Don’t Allow',
              //         color: AppColors.primaryBlue,
              //         alignText: TextAlign.center,
              //         maxLines: 2,
              //         fontSize: 20.sp,
              //         fontWeight: FontWeight.w300,
              //       ),
              //     ),
              //   ),
              // ),
            )
          ],
        ),
      ),
    );
  }

  showDialog(
      context: context,
      builder: (BuildContext context) {
        // MyRulesController controller = Get.put(MyRulesController());
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: dialogContent(context),
        );
      });
}

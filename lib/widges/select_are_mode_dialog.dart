import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:silenttime/utils/colors.dart';
import 'package:silenttime/widges/custom_text.dart';
import '../screens/my_rules/controller/myrules_controller.dart';
import '../screens/my_rules/pages/myZone_screen.dart';

class SelectAreaModeDialog extends StatelessWidget {
  const SelectAreaModeDialog({super.key});

  dialogContent(BuildContext context) {
    return GetBuilder<MyRulesController>(
        init: MyRulesController(),
        builder: (controller) {
          return Container(
            // height: 266.h,
            decoration: const BoxDecoration(
              // color: Colors.white,
              shape: BoxShape.rectangle,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 26.h, horizontal: 24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CText(
                        text: 'Select Option',
                        alignText: TextAlign.center,
                        maxLines: 2,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.cancel_outlined,
                            color: AppColors.primaryBlue,
                            size: 27,
                          ))
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.h),
                    child: SizedBox(
                      width: 311.w,
                      child: Row(
                        children: [
                          CText(
                            text: 'Zone Name',
                            alignText: TextAlign.start,
                            // maxLines: 2,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w300,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: InkWell(
                              onTap: () {
                                Get.back();
                                Get.to(() => const MyZoneScreen());
                                // Get.back();
                              },
                              child: Text(
                                '<Select Zone>',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.primaryBlue,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.primaryBlue,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: Row(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Checkbox(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            splashRadius: 0.0,
                            shape: const CircleBorder(),
                            tristate: true,
                            value: controller.areaEntered.value,
                            onChanged: (newValue) {
                              controller.areaEnteredStatus();
                            },
                            activeColor: AppColors.primaryBlue,
                            focusColor: AppColors.primaryBlue,
                            hoverColor: AppColors.primaryBlue,
                          ),
                        ),
                        CText(
                          text: 'Area Entered',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w300,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 7.h),
                    child: Row(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Checkbox(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            splashRadius: 0.0,
                            shape: const CircleBorder(),
                            tristate: true,
                            value: controller.areaExit.value,
                            onChanged: (newValue) {
                              controller.areaExittatus();
                            },
                            activeColor: AppColors.primaryBlue,
                            focusColor: AppColors.primaryBlue,
                            hoverColor: AppColors.primaryBlue,
                          ),
                        ),
                        CText(
                          text: 'Area Exited',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w300,
                        )
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(top: 7.h),
                  //   child: Row(
                  //     children: <Widget>[
                  //       Align(
                  //         alignment: Alignment.centerLeft,
                  //         child: Checkbox(
                  //           materialTapTargetSize:
                  //               MaterialTapTargetSize.shrinkWrap,
                  //           splashRadius: 0.0,
                  //           // shape: const CircleBorder(),
                  //           tristate: true,
                  //           value: controller.previousLocation.value,
                  //           onChanged: (newValue) {
                  //             controller.previousLocationStatus();
                  //           },
                  //           activeColor: AppColors.primaryBlue,
                  //           focusColor: AppColors.primaryBlue,
                  //           hoverColor: AppColors.primaryBlue,
                  //         ),
                  //       ),
                  //       CText(
                  //         text: 'Trigger if previous location unknown',
                  //         fontSize: 12.sp,
                  //         fontWeight: FontWeight.w300,
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(top: 15.h),
                  //   child: SizedBox(
                  //     width: 311.w,
                  //     child: Row(
                  //       children: [
                  //         CText(
                  //           text: 'Location Update Rate',
                  //           alignText: TextAlign.start,
                  //           // maxLines: 2,
                  //           fontSize: 14.sp,
                  //           fontWeight: FontWeight.w300,
                  //         ),
                  //         Padding(
                  //           padding: EdgeInsets.only(
                  //             left: 10.w,
                  //           ),
                  //           child: Text(
                  //             '5 Minutes',
                  //             style: TextStyle(
                  //               fontSize: 16.sp,
                  //               fontWeight: FontWeight.w300,
                  //               color: AppColors.primaryBlue,
                  //               decoration: TextDecoration.underline,
                  //               decorationColor: AppColors.primaryBlue,
                  //             ),
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: SizedBox(
                      width: 283.w,
                      child: CText(
                        text:
                            'High frequency update rates may cause additional batter drain.',
                        alignText: TextAlign.start,
                        maxLines: 2,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      // backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}

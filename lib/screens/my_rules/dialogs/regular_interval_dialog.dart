import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:silenttime/screens/my_rules/dialogs/time_picker.dart';
import 'package:silenttime/screens/my_rules/controller/myrules_controller.dart';
import 'package:silenttime/utils/colors.dart';
import 'package:silenttime/widges/custom_text.dart';
import 'package:silenttime/widges/text_field.dart';

regularIntervalDialog(context) {
  String formatTime(TimeOfDay time) {
    String hour = time.hourOfPeriod.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    String period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: GetBuilder<MyRulesController>(
              init: MyRulesController(),
              builder: (controller) {
                return Container(
                    width: Get.width * 0.9,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CText(
                          text: "Regular Interval",
                          fontSize: 24.sp,
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        CText(
                          text: "Set your time",
                          fontSize: 18.sp,
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        CText(
                          text:
                              "Choose a specific time of days when you would like to set your mobile phone to silent mode.",
                          fontSize: 14.sp,
                          maxLines: 5,
                          alignText: TextAlign.center,
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CText(
                              text: "Hours",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    log('Hours======');
                                    if (controller.hours.value > 0) {
                                      controller.updateHMS(
                                        controller.hours,
                                        controller.hours.value - 1,
                                      );
                                    }
                                  },
                                  child: const Icon(
                                    Icons.remove,
                                    size: 25,
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Container(
                                    alignment: Alignment.center,
                                    width: 130.w,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: AppColors.primaryBlue
                                                    .withOpacity(0.3)))),
                                    child: CText(
                                      text: controller.hours.value.toString(),
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.grey,
                                    )),
                                SizedBox(
                                  width: 20.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (controller.hours.value < 60) {
                                      controller.updateHMS(
                                        controller.hours,
                                        controller.hours.value + 1,
                                      );
                                    }
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    size: 25,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CText(
                              text: "Minutes",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (controller.minutes.value > 0) {
                                      controller.updateHMS(controller.minutes,
                                          controller.minutes.value - 1);
                                    }
                                  },
                                  child: const Icon(
                                    Icons.remove,
                                    size: 25,
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Container(
                                    alignment: Alignment.center,
                                    width: 130.w,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: AppColors.primaryBlue
                                                    .withOpacity(0.3)))),
                                    child: CText(
                                      text: controller.minutes.value.toString(),
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.grey,
                                    )),
                                SizedBox(
                                  width: 20.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (controller.minutes.value < 60) {
                                      controller.updateHMS(controller.minutes,
                                          controller.minutes.value + 1);
                                    }
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    size: 25,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CText(
                              text: "Seconds",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (controller.seconds.value > 0) {
                                      controller.updateHMS(controller.seconds,
                                          controller.seconds.value - 1);
                                    }
                                  },
                                  child: const Icon(
                                    Icons.remove,
                                    size: 25,
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Container(
                                    alignment: Alignment.center,
                                    width: 130.w,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: AppColors.primaryBlue
                                                    .withOpacity(0.3)))),
                                    child: CText(
                                      text: controller.seconds.value.toString(),
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.grey,
                                    )),
                                SizedBox(
                                  width: 20.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (controller.seconds < 60) {
                                      controller.updateHMS(controller.seconds,
                                          controller.seconds.value + 1);
                                    }
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    size: 25,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 50.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                text: formatTime(controller.fromTime),
                                label: "From time",
                                onTap: () async {
                                  var time = await timePiker(Get.context);
                                  controller.updateFromTime(time);
                                },
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(Icons.arrow_forward),
                            ),
                            Expanded(
                              child: CustomTextField(
                                text: formatTime(controller.toTime),
                                label: "To time",
                                onTap: () async {
                                  var time = await timePiker(Get.context);
                                  controller.updateToTime(time);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        // CText(
                        //   text:
                        //       "Use this option if your trigger time is not firing accurately (and you need it to.)",
                        //   fontSize: 14.sp,
                        //   maxLines: 5,
                        // ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  controller.disposeThins();
                                  Get.back();
                                },
                                child: CText(
                                  text: "Cancel",
                                  fontSize: 18.sp,
                                  color: AppColors.primaryBlue,
                                  fontWeight: FontWeight.w600,
                                )),
                            const SizedBox(
                              width: 20,
                            ),
                            TextButton(
                                onPressed: () {
                                  MyRulesController myRulesController =
                                      Get.put(MyRulesController());
                                  myRulesController.setup2Status();
                                  myRulesController.changeTabVal(1);
                                  Get.back();
                                },
                                child: CText(
                                  text: "OK",
                                  fontSize: 18.sp,
                                  color: AppColors.primaryBlue,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ],
                    ));
              }),
        );
      });
}

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:silenttime/screens/my_rules/dialogs/time_picker.dart';
import 'package:silenttime/screens/my_rules/controller/myrules_controller.dart';
import 'package:silenttime/utils/colors.dart';
import 'package:silenttime/utils/toast.dart';
import 'package:silenttime/widges/custom_text.dart';
import 'package:silenttime/widges/text_field.dart';

String formatTimeOfDayToString(TimeOfDay time) {
  String hour = time.hourOfPeriod.toString().padLeft(2, '0');
  String minute = time.minute.toString().padLeft(2, '0');
  String period = time.period == DayPeriod.am ? 'AM' : 'PM';
  return '$hour:$minute $period';
}

dayTimeDialog(context) {
  MyRulesController myRulesController = Get.put(MyRulesController());
  myRulesController.clearDaysName();
  Widget dayCheckBox(
      {required name, required value, required Function(bool?)? onChanged}) {
    return Column(
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 17.0),
        ),
        Checkbox(
            checkColor: AppColors.black,
            activeColor: AppColors.primaryBlue,
            value: value,
            visualDensity: VisualDensity.compact,
            onChanged: onChanged),
      ],
    );
  }

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 30.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: GetBuilder<MyRulesController>(
            init: MyRulesController(),
            builder: (controller) {
              return Container(
                  width: Get.width * 0.9,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CText(
                        text: "Day/Time Trigger",
                        fontSize: 24.sp,
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          dayCheckBox(
                              name: "M",
                              value: controller.mon.value,
                              onChanged: (v) {
                                controller.mon.value = v!;
                                if (v == true) {
                                  controller.saveDayName("Mon");
                                } else {
                                  controller.removeDayName("Mon");
                                }
                              }),
                          dayCheckBox(
                              name: "T",
                              value: controller.tue.value,
                              onChanged: (v) {
                                controller.tue.value = v!;
                                if (v == true) {
                                  controller.saveDayName("Tue");
                                } else {
                                  controller.removeDayName("Tue");
                                }
                              }),
                          dayCheckBox(
                              name: "W",
                              value: controller.wed.value,
                              onChanged: (v) {
                                controller.wed.value = v!;
                                if (v == true) {
                                  controller.saveDayName("Wed");
                                } else {
                                  controller.removeDayName("Wed");
                                }
                              }),
                          dayCheckBox(
                              name: "T",
                              value: controller.thru.value,
                              onChanged: (v) {
                                controller.thru.value = v!;
                                if (v == true) {
                                  controller.saveDayName("Thu");
                                } else {
                                  controller.removeDayName("Thu");
                                }
                              }),
                          dayCheckBox(
                              name: "F",
                              value: controller.fri.value,
                              onChanged: (v) {
                                controller.fri.value = v!;

                                if (v == true) {
                                  controller.saveDayName("Fri");
                                } else {
                                  controller.removeDayName("Fri");
                                }
                              }),
                          dayCheckBox(
                              name: "S",
                              value: controller.sat.value,
                              onChanged: (v) {
                                controller.sat.value = v!;
                                if (v == true) {
                                  controller.saveDayName("Sat");
                                } else {
                                  controller.removeDayName("Sat");
                                }
                              }),
                          dayCheckBox(
                              name: "S",
                              value: controller.sun.value,
                              onChanged: (v) {
                                controller.sun.value = v!;
                                if (v == true) {
                                  controller.saveDayName("Sun");
                                } else {
                                  controller.removeDayName("Sun");
                                }
                              }),
                        ],
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
                        height: 50.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              text:
                                  formatTimeOfDayToString(controller.fromTime),
                              label: "From time",
                              onTap: () async {
                                var time = await timePiker(Get.context);
                                log('time: $time');

                                controller.updateFromTime(time);
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: const Icon(Icons.arrow_forward),
                          ),
                          Expanded(
                            child: CustomTextField(
                              text: formatTimeOfDayToString(controller.toTime),
                              label: "To time",
                              onTap: () async {
                                var time = await timePiker(Get.context);
                                log('time: $time');
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
                      // SizedBox(
                      //   height: 30.h,
                      // ),
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
                          SizedBox(width: 20.w),
                          TextButton(
                              onPressed: () {
                                if (controller.selectedDayName.isEmpty) {
                                  AppToast.failToast("Select any Day");
                                } else {
                                  MyRulesController myRulesController =
                                      Get.put(MyRulesController());
                                  myRulesController.setup2Status();
                                  myRulesController.changeTabVal(1);
                                  Get.back();
                                }
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
            },
          ),
        );
      });
}

import 'dart:developer';
import 'package:silenttime/models/notification_model.dart';
import 'package:silenttime/screens/notification/notification_controller.dart';
import 'package:silenttime/services/local_notification_services.dart';
import 'package:silenttime/utils/toast.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:silenttime/models/triger_model.dart';
import 'package:silenttime/screens/bottom_navbar/bottombar_screen.dart';
import 'package:silenttime/screens/my_rules/controller/myrules_controller.dart';
import 'package:silenttime/utils/colors.dart';
import 'package:silenttime/widges/custom_text.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyRulesController>(
        init: MyRulesController(),
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.sp, horizontal: 15.w),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey, width: 0.2)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 20.w),
                          decoration: const BoxDecoration(
                            color: AppColors.primaryBlue,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.question_mark_sharp,
                                color: AppColors.whiteColor,
                                size: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 16.w),
                                child: CText(
                                  text: 'Rule Details',
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.whiteColor,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20.h, left: 16.w),
                          child: CText(
                            text: 'Enter rule name:',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.h, left: 16.w),
                          child: SizedBox(
                            height: 45.h,
                            child: TextField(
                              autofocus: true,
                              controller: controller.ruleNameController,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.grey,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.transparent,
                                hintText: 'Enter your rule name here',
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: AppColors.blueF4,
                                ),
                                // suffixIcon: const Icon(
                                //   Icons.image_outlined,
                                //   color: AppColors.grayEA,
                                //   size: 20,
                                // ),
                                contentPadding: const EdgeInsets.only(
                                    bottom: 8.0, top: 8.0),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: 50,
                  // ),
                  // // Padding(
                  // //   padding: EdgeInsets.only(top: 24.h),
                  // //   child: CText(
                  // //     text: 'Show rule popup when launched',
                  // //     fontSize: 16.sp,
                  // //     fontWeight: FontWeight.w300,
                  // //     // color: AppColors.blue42,
                  // //   ),
                  // // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     SizedBox(
                  //       child: Row(
                  //         children: <Widget>[
                  //           Checkbox(
                  //             materialTapTargetSize:
                  //                 MaterialTapTargetSize.shrinkWrap,
                  //             tristate: true,
                  //             value: controller.rulePopupWhenLounch.value == 0
                  //                 ? true
                  //                 : false,
                  //             onChanged: (vak) {
                  //               controller.rulePopupNumber(0);
                  //             },
                  //             activeColor: AppColors.primaryBlue,
                  //             shape: const CircleBorder(),
                  //           ),
                  //           CText(
                  //             text: 'Default',
                  //             fontSize: 16.sp,
                  //             // color: AppColors.black,
                  //             fontWeight: FontWeight.w300,
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       child: Row(
                  //         children: <Widget>[
                  //           Checkbox(
                  //             materialTapTargetSize:
                  //                 MaterialTapTargetSize.shrinkWrap,
                  //             tristate: true,
                  //             value: controller.rulePopupWhenLounch.value == 1
                  //                 ? true
                  //                 : false,
                  //             onChanged: (vak) {
                  //               controller.rulePopupNumber(1);
                  //             },
                  //             activeColor: AppColors.primaryBlue,
                  //             shape: const CircleBorder(),
                  //           ),
                  //           CText(
                  //             text: 'Yes',
                  //             fontSize: 16.sp,
                  //             // color: AppColors.black,
                  //             fontWeight: FontWeight.w300,
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       child: Row(
                  //         children: <Widget>[
                  //           Checkbox(
                  //             materialTapTargetSize:
                  //                 MaterialTapTargetSize.shrinkWrap,
                  //             tristate: true,
                  //             value: controller.rulePopupWhenLounch.value == 2
                  //                 ? true
                  //                 : false,
                  //             onChanged: (vak) {
                  //               controller.rulePopupNumber(2);
                  //             },
                  //             activeColor: AppColors.primaryBlue,
                  //             shape: const CircleBorder(),
                  //           ),
                  //           CText(
                  //             text: 'No',
                  //             fontSize: 16.sp,
                  //             // color: AppColors.black,
                  //             fontWeight: FontWeight.w300,
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 80.h),
                  // const Flexible(child: SizedBox()),

                  InkWell(
                    onTap: () {
                      if (controller.ruleNameController.text.isNotEmpty) {
                        var uuid = const Uuid();

                        // controller.selectedDayName.value;
                        List dayname = [];
                        // ignore: invalid_use_of_protected_member
                        for (var element in controller.selectedDayName.value) {
                          dayname.add(element);
                        }
                        log('dayname.............  ${dayname}');

                        var todo = TrigerModel(
                          trigerCreatedDateTime: DateTime.now(),
                          trigerAction: controller.trigerAction.value,
                          trigerDayName: dayname,
                          // controller.selectedDayName,
                          trigerStateONOFF: true,
                          trigerFromTimeHour:
                              controller.fromTime.hour.toString(),
                          trigerFromTimeMint: "${controller.fromTime.minute}",
                          // "${controller.fromTime.minute + 1}",
                          trigerFromTimePeriod:
                              controller.fromTime.period == DayPeriod.am
                                  ? 'AM'
                                  : 'PM',
                          trigerToTimeHour: controller.toTime.hour.toString(),
                          trigerToTimeMint: controller.toTime.minute.toString(),
                          trigerToTimePeriod:
                              controller.toTime.period == DayPeriod.am
                                  ? 'AM'
                                  : 'PM',
                          trigerId: uuid.v1(),
                          trigerTitle: controller.trigerTitle.value,
                          trigerDayNumber: controller.selectedDay.value,
                          trigerMonthName: controller.selectedMonth.value,
                          trigerHours: controller.hours.value,
                          trigerMinutes: controller.minutes.value,
                          trigerSeconds: controller.seconds.value,
                          zoneName: controller.zoneNameController.text,
                          zoneRadious: controller.zoneRadiousController.text,
                          locationName: controller.locationName.value,
                          locationLat: controller.locationLat.value,
                          locationLong: controller.locationLong.value,
                          areaEntered: controller.areaEntered.value,
                          trigerZoneName: controller.trigerName.value,
                          trigerActionButtonNumber:
                              controller.actionButtonNum.value,
                          trigerRuleName: controller.ruleNameController.text,
                          rulePopupWhenLounch:
                              controller.rulePopupWhenLounch.value,
                          trigerStatus: true,
                          isTriggered: false,
                        );
                        controller.trigerModelList.add(todo);

                        log("Days: ${controller.trigerModelList[0].trigerDayName}");
                        controller.saveTriggers();
                        controller.titleController.text = '';
                        controller.descriptionController.text = '';

                        // Notification
                        NotificationController notificationController =
                            Get.put(NotificationController());
                        notificationController.saveNotification(
                          notification: NotificationModel(
                            title: controller.trigerTitle.value,
                            description:
                                "${controller.trigerTitle.value} created",
                            createdAt: DateTime.now(),
                          ),
                        );
                        FCMServices.displyNotification(
                            title: controller.trigerTitle.value,
                            body: "${controller.trigerTitle.value} created");

                        controller.titleController.clear();
                        controller.descriptionController.clear();
                        controller.zoneNameController.clear();
                        controller.zoneRadiousController.clear();
                        controller.disposeThins();
                        Get.off(() => const BottombarScreen());
                      } else {
                        AppToast.failToast('Rule Name Required');
                      }
                    },
                    child: Container(
                      // height: 56.h,
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 20.w),
                      decoration: const BoxDecoration(
                          color: AppColors.primaryBlue,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: CText(
                          text: 'Save',
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

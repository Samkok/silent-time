import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:silenttime/screens/my_rules/dialogs/time_picker.dart';
import 'package:silenttime/screens/my_rules/controller/myrules_controller.dart';
import 'package:silenttime/screens/update_triger.dart/update_DayofWeekMonth.dart';
import 'package:silenttime/utils/colors.dart';
import 'package:silenttime/widges/custom_text.dart';
import 'package:silenttime/widges/text_field.dart';

dayWeekMonthDialog(context) {
  String formatTime(TimeOfDay time) {
    String hour = time.hourOfPeriod.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    String period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  var itemsss = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: GetBuilder<MyRulesController>(
              init: MyRulesController(),
              builder: (controller) {
                return Container(
                    width: Get.width * 0.9,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CText(
                          text: "Day of the month",
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
                          children: [
                            // Month dropdown
                            // Expanded(
                            //   child: DropdownButtonFormField<String>(
                            //     value: controller.selectedMonth.value ??
                            //         months[0], // Set default value
                            //     decoration: InputDecoration(
                            //       labelText: 'Month',
                            //       contentPadding: EdgeInsets.symmetric(
                            //           vertical: 0, horizontal: 10.w),
                            //       border: const OutlineInputBorder(),
                            //     ),
                            //     onChanged: (String? newValue) {
                            //       // Handle month selection
                            //       controller.updateSelectedMonth(newValue);
                            //       // Update days list when month changes
                            //       controller.updateselectedMonthVal(
                            //           months.indexOf(newValue!) + 1);
                            //     },
                            //     items: itemsss.map<DropdownMenuItem<String>>(
                            //         (String value) {
                            //       return DropdownMenuItem<String>(
                            //         value: value,
                            //         child: Text(value),
                            //       );
                            //     }).toList(),
                            //   ),
                            // ),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: 'Month',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10.w),
                                  border: const OutlineInputBorder(),
                                ),
                                value: null, // Initially no value selected
                                onChanged: (String? newValue) {
                                  // Handle month selection
                                  controller.updateSelectedMonth(newValue);
                                  controller.updateSelectedDay(1);
                                  controller.updateselectedMonthVal(
                                      months.indexOf(newValue!) + 1);
                                },
                                items: months.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),

                            SizedBox(width: 20.w),
                            // Day dropdown
                            Expanded(
                              child: DropdownButtonFormField<int>(
                                decoration: InputDecoration(
                                  labelText: 'Day',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10.w),
                                  border: const OutlineInputBorder(),
                                ),
                                value: controller.selectedDay.value,
                                onChanged: (int? newValue) {
                                  controller.updateSelectedDay(newValue);
                                },
                                items: List.generate(
                                        getDaysInMonthListMethod()[controller
                                                    .selectedMonthVal.value -
                                                1] ??
                                            0,
                                        (index) => index + 1)
                                    .map<DropdownMenuItem<int>>((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(value.toString()),
                                  );
                                }).toList(),
                              ),
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
                                text: "${formatTime(controller.fromTime)}",
                                label: "From time",
                                onTap: () async {
                                  var time = await timePiker(Get.context);
                                  print('time: ${time}');
                                  controller.updateFromTime(time);
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(Icons.arrow_forward),
                            ),
                            Expanded(
                              child: CustomTextField(
                                text: "${formatTime(controller.toTime)}",
                                label: "To time",
                                onTap: () async {
                                  var time = await timePiker(Get.context);
                                  print('time: ${time}');
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
                            SizedBox(
                              width: 20,
                            ),
                            TextButton(
                                onPressed: () {
                                  MyRulesController myRulesController =
                                      Get.put(MyRulesController());
                                  myRulesController.setup2Status();
                                  myRulesController.changetabVal(1);
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

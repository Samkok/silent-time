import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:silenttime/screens/my_rules/controller/myrules_controller.dart';
import 'package:silenttime/screens/update_triger.dart/update_DayTimeTriger.dart';
import 'package:silenttime/utils/colors.dart';
import '../../widges/custom_text.dart';
import '../../widges/text_field.dart';
import 'dart:async';

String formatTime(TimeOfDay time) {
  String hour = time.hourOfPeriod.toString().padLeft(2, '0');
  String minute = time.minute.toString().padLeft(2, '0');
  String period = time.period == DayPeriod.am ? 'AM' : 'PM';
  return '$hour:$minute $period';
}

final List<String> months = [
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

// List<int> daysInMonthList = [
//   31, // January
//   28, // February (considering a non-leap year)
//   31, // March
//   30, // April
//   31, // May
//   30, // June
//   31, // July
//   31, // August
//   30, // September
//   31, // October
//   30, // November
//   31, // December
// ];

List<int> getDaysInMonthListMethod() {
  List<int> daysInMonthList = [
    31, // January
    isLeapYear() ? 29 : 28, // February
    31, // March
    30, // April
    31, // May
    30, // June
    31, // July
    31, // August
    30, // September
    31, // October
    30, // November
    31, // December
  ];

  return daysInMonthList;
}

bool isLeapYear() {
  int year = DateTime.now().year;
  return (year % 4 == 0) && (year % 100 != 0 || year % 400 == 0);
}

class UpdateDayofWeekMonthTriger extends StatefulWidget {
  const UpdateDayofWeekMonthTriger({Key? key}) : super(key: key);

  @override
  State<UpdateDayofWeekMonthTriger> createState() =>
      _UpdateDayofWeekMonthTrigerState();
}

class _UpdateDayofWeekMonthTrigerState
    extends State<UpdateDayofWeekMonthTriger> {
  MyRulesController myRulesController = Get.put(MyRulesController());
// Defaulting to January

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      log("day>>>> ${myRulesController.selectedDay.value}");
      myRulesController.updateSelectedDay(myRulesController.selectedDay.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyRulesController>(
        init: MyRulesController(),
        builder: (controller) {
          return Container(
              width: Get.width * 0.9,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Month',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10.w),
                            border: const OutlineInputBorder(),
                          ),
                          value: controller.selectedMonth.value,
                          onChanged: (String? newValue) {
                            // Handle month selection
                            controller.updateSelectedMonth(newValue);
                            controller.updateSelectedDay(1);

                            controller.updateselectedMonthVal(
                                months.indexOf(newValue!) + 1);
                          },
                          items: months
                              .map<DropdownMenuItem<String>>((String value) {
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
                                  getDaysInMonthListMethod()[
                                      controller.selectedMonthVal.value - 1],
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
                          text: formatTime(controller.fromTime),
                          label: "From time..",
                          onTap: () async {
                            var time = await timePikerUpdate(
                                Get.context, controller.fromTime);
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
                            var time = await timePikerUpdate(
                                Get.context, controller.toTime);
                            controller.updateToTime(time);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
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
                            log('day == ${controller.selectedMonth.value}');
                            log('day ==  ${controller.selectedDay.value}');
                            MyRulesController myRulesController =
                                Get.put(MyRulesController());
                            myRulesController.updateTrigerSteps(1);
                            // myRulesController.setup2Status();
                            // myRulesController.changetabVal(1);
                            // Get.back();
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
        });
  }
}









// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:silenttime/screens/my_rules/controller/myrules_controller.dart';
// import 'package:silenttime/screens/my_rules/dialogs/time_picker.dart';
// import 'package:silenttime/screens/update_triger.dart/update_DayTimeTriger.dart';
// import 'package:silenttime/utils/colors.dart';
// import '../../widges/custom_text.dart';
// import '../../widges/text_field.dart';

// String formatTime(TimeOfDay time) {
//   String hour = time.hourOfPeriod.toString().padLeft(2, '0');
//   String minute = time.minute.toString().padLeft(2, '0');
//   String period = time.period == DayPeriod.am ? 'AM' : 'PM';
//   return '$hour:$minute $period';
// }

// final List<String> months = [
//   'January',
//   'February',
//   'March',
//   'April',
//   'May',
//   'June',
//   'July',
//   'August',
//   'September',
//   'October',
//   'November',
//   'December'
// ];

// class UpdateDayofWeekMonthTriger extends StatefulWidget {
//   const UpdateDayofWeekMonthTriger({super.key});

//   @override
//   State<UpdateDayofWeekMonthTriger> createState() =>
//       _UpdateDayofWeekMonthTrigerState();
// }

// class _UpdateDayofWeekMonthTrigerState
//     extends State<UpdateDayofWeekMonthTriger> {
//   MyRulesController myRulesController = Get.put(MyRulesController());

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Future.delayed(Duration(seconds: 1), () {
//       log("day>>>> ${myRulesController.selectedDay.value}");
//       myRulesController.updateSelectedDay(myRulesController.selectedDay.value);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<MyRulesController>(
//         init: MyRulesController(),
//         builder: (controller) {
//           return Container(
//               width: Get.width * 0.9,
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   CText(
//                     text: "Day of the month",
//                     fontSize: 24.sp,
//                     color: AppColors.primaryBlue,
//                     fontWeight: FontWeight.w600,
//                   ),
//                   SizedBox(
//                     height: 30.h,
//                   ),
//                   CText(
//                     text: "Set your time",
//                     fontSize: 18.sp,
//                     color: AppColors.primaryBlue,
//                     fontWeight: FontWeight.w500,
//                   ),
//                   SizedBox(
//                     height: 10.h,
//                   ),
//                   CText(
//                     text:
//                         "Choose a specific time of days when you would like to set your mobile phone to silent mode.",
//                     fontSize: 14.sp,
//                     maxLines: 5,
//                     alignText: TextAlign.center,
//                   ),
//                   SizedBox(
//                     height: 30.h,
//                   ),
//                   Row(
//                     children: [
//                       // Day dropdown
//                       Expanded(
//                         child: DropdownButtonFormField<int>(
//                           decoration: InputDecoration(
//                             labelText: 'Day',
//                             contentPadding: EdgeInsets.symmetric(
//                                 vertical: 0, horizontal: 10.w),
//                             border: const OutlineInputBorder(),
//                           ),
//                           value: controller.selectedDay.value,
//                           onChanged: (int? newValue) {
//                             controller.updateSelectedDay(newValue);
//                           },
//                           items: List.generate(31, (index) => index + 1)
//                               .map<DropdownMenuItem<int>>((int value) {
//                             return DropdownMenuItem<int>(
//                               value: value,
//                               child: Text(value.toString()),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                       SizedBox(width: 20.w),
//                       // Month dropdown
//                       Expanded(
//                         child: DropdownButtonFormField<String>(
//                           decoration: InputDecoration(
//                             labelText: 'Month',
//                             contentPadding: EdgeInsets.symmetric(
//                                 vertical: 0, horizontal: 10.w),
//                             border: const OutlineInputBorder(),
//                           ),
//                           value: controller.selectedMonth.value,
//                           onChanged: (String? newValue) {
//                             // Handle month selection
//                             controller.updateSelectedMonth(newValue);
//                           },
//                           items: months
//                               .map<DropdownMenuItem<String>>((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 50.h,
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: CustomTextField(
//                           text: formatTime(controller.fromTime),
//                           label: "From time..",
//                           onTap: () async {
//                             var time = await timePikerUpdate(
//                                 Get.context, controller.fromTime);
//                             controller.updateFromTime(time);
//                           },
//                         ),
//                       ),
//                       const Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 10),
//                         child: Icon(Icons.arrow_forward),
//                       ),
//                       Expanded(
//                         child: CustomTextField(
//                           text: formatTime(controller.toTime),
//                           label: "To time",
//                           onTap: () async {
//                             var time = await timePikerUpdate(
//                                 Get.context, controller.toTime);
//                             controller.updateToTime(time);
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 50.h,
//                   ),
//                   // CText(
//                   //   text:
//                   //       "Use this option if your trigger time is not firing accurately (and you need it to.)",
//                   //   fontSize: 14.sp,
//                   //   maxLines: 5,
//                   // ),
//                   SizedBox(
//                     height: 30.h,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                           onPressed: () {
//                             Get.back();
//                           },
//                           child: CText(
//                             text: "Cancel",
//                             fontSize: 18.sp,
//                             color: AppColors.primaryBlue,
//                             fontWeight: FontWeight.w600,
//                           )),
//                       const SizedBox(
//                         width: 20,
//                       ),
//                       TextButton(
//                           onPressed: () {
//                             log('day == ${controller.selectedMonth.value}');
//                             log('day ==  ${controller.selectedDay.value}');
//                             MyRulesController myRulesController =
//                                 Get.put(MyRulesController());
//                             myRulesController.updateTrigerSteps(1);
//                             // myRulesController.setup2Status();
//                             // myRulesController.changetabVal(1);
//                             // Get.back();
//                           },
//                           child: CText(
//                             text: "OK",
//                             fontSize: 18.sp,
//                             color: AppColors.primaryBlue,
//                             fontWeight: FontWeight.w600,
//                           )),
//                     ],
//                   ),
//                 ],
//               ));
//         });
//   }
// }

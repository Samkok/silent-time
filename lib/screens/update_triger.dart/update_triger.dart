import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:silenttime/models/triger_model.dart';
import 'package:silenttime/screens/my_rules/controller/myrules_controller.dart';
import 'package:silenttime/screens/update_triger.dart/update_DayTimeTriger.dart';
import 'package:silenttime/screens/update_triger.dart/update_rule_screen.dart';
import 'package:silenttime/utils/colors.dart';
import 'package:silenttime/widges/custom_text.dart';
import '../../utils/app_imaes.dart';
import '../my_rules/pages/set_location_screen.dart';
import 'update_DayofWeekMonth.dart';
import 'update_action_screen.dart';
import 'update_locationPicker_screen.dart';
import 'update_regularTime_screen.dart';

// ignore: must_be_immutable
class UpdateTrigger extends StatelessWidget {
  TriggerModel triggerModelIndex;
  int ind;
  UpdateTrigger({super.key, required this.triggerModelIndex, required this.ind});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyRulesController>(
        init: MyRulesController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.primaryBlue,
              title: CText(
                text: 'Edit Trigger',
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
              ),
              leading: IconButton(
                onPressed: () {                   
                    if (controller.tabVal.value == 1) {
                        return  controller.updateTrigerSteps(0);
                      }else if (controller.tabVal.value == 2) {
                        return  controller.updateTrigerSteps(1);
                      }else return Get.back();
                },
                icon: const Icon(
                  Icons.arrow_circle_left,
                  size: 25,
                ),
                color: AppColors.whiteColor,
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 15.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 124.w,
                          height: 48.h,
                          decoration: BoxDecoration(
                            // color: AppColors.primaryBlue,
                            image: DecorationImage(
                              image: AssetImage(controller.step1.value
                                  ? AppImaes.arrowImage
                                  : AppImaes.arrowlightlogo),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image(
                                height: 20.h,
                                width: 20.w,
                                image: const AssetImage(AppImaes.trigerlogo),
                              ),
                              CText(
                                text: 'Trigger',
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.whiteColor,
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 130.w,
                          height: 48.h,
                          decoration: BoxDecoration(
                            // color: AppColors.black,
                            image: DecorationImage(
                              image: AssetImage(controller.step2.value
                                  ? AppImaes.arrowImage
                                  : AppImaes.arrowlightlogo),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // mainAxisSize: MainAxisSize.min,
                            children: [
                              Image(
                                height: 25.h,
                                width: 25.w,
                                image: const AssetImage(AppImaes.actionlogo),
                              ),
                              CText(
                                text: 'Action',
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.whiteColor,
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 130.w,
                          height: 48.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                controller.step3.value
                                    ? AppImaes.arrowImage
                                    : AppImaes.arrowlightlogo,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image(
                                height: 25.h,
                                width: 25.w,
                                image: const AssetImage(AppImaes.ruleLogog),
                              ),
                              CText(
                                text: 'Rules',
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.whiteColor,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(child: () {
                      if (controller.tabVal.value == 0) {
                        return triggerModelIndex.trigerTitle ==
                                'Day/Time Trigger'
                            ? const UpdateDayTimeTrigger()
                            : triggerModelIndex.trigerTitle == 'Location Trigger'
                                // ? const UpdateLocationPickerScreen()
                                ? const SetLocationScreen()
                                : triggerModelIndex.trigerTitle ==
                                        'Geofence Trigger'
                                    ? const SetLocationScreen()
                                    // UpdateLocationPickerScreen()
                                    : triggerModelIndex.trigerTitle ==
                                            'Day of Week/Month'
                                        ? const UpdateDayofWeekMonthTriger()
                                        : triggerModelIndex.trigerTitle ==
                                                'Regular Interval'
                                            ? const UpdateRegularIntervalScreen()
                                            : Text(triggerModelIndex
                                                    .trigerTitle!.isEmpty
                                                ? 'Empty Title'
                                                : triggerModelIndex
                                                    .trigerTitle!);
                      } else if (controller.tabVal.value == 1) {
                        return const UpdateActionScreen();
                      } else if (controller.tabVal.value == 2) {
                        return const UpdateRuleScreen();
                      } else {
                        return triggerModelIndex.trigerTitle ==
                                'Day/Time Trigger'
                            ? const UpdateDayTimeTrigger()
                            : triggerModelIndex.trigerTitle == 'Location Trigger'
                                ? const Text('Location Trigger')
                                : triggerModelIndex.trigerTitle ==
                                        'Geofence Trigger'
                                    ? const Text('Geofence Trigger')
                                    : triggerModelIndex.trigerTitle ==
                                            'Day of Week/Month'
                                        ? const Text('Day of Week/Month')
                                        : triggerModelIndex.trigerTitle ==
                                                'Regular Interval'
                                            ? const Text('Day of Week/Month')
                                            : const Text('Day/Time Trigger');
                      }
                    }()),
                    const SizedBox(height: 70)
                  ],
                ),
              ),
            ),
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:silenttime/screens/my_rules/controller/myrules_controller.dart';
import 'package:silenttime/utils/colors.dart';
import 'package:silenttime/widges/action_button_widget.dart';
import 'package:silenttime/widges/custom_text.dart';

import '../../../utils/app_imaes.dart';

class ActionScreen extends StatelessWidget {
  const ActionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color borderColor = Theme.of(context).brightness == Brightness.light
        ? AppColors.orange
        : AppColors.yellow; 
    Color textColor = Theme.of(context).brightness == Brightness.light
        ? AppColors.black
        : AppColors.whiteColor; 
    return GetBuilder<MyRulesController>(
        init: MyRulesController(),
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.sp, horizontal: 15.w),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey, width: 0.2)),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 20.w),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryBlue, 
                          border: Border(bottom: BorderSide(color: AppColors.grey, width: 0.2))                        
                        ),
                        child: Row(
                          children: [
                            // const Icon(
                            //   Icons.question_mark,
                            //   color: AppColors.whiteColor,
                            //   size: 20,
                            // ),
                            CText(
                              text: 'Add Action',
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.whiteColor,
                            )
                          ],
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.mic,
                          color: AppColors.primaryBlue,
                          size: 30,
                        ),
                        title: CText(
                          text: 'Set Sound Mode Action',
                          fontSize: 16.sp,
                          color: textColor,
                          fontWeight: FontWeight.w500,
                        ),
                        subtitle: SizedBox(
                          width: 255.w,
                          child: CText(
                            maxLines: 2,
                            text:
                                'Set device sound mode to Normal/ Vibrate Silent.',
                            fontSize: 12.sp,
                            color: AppColors.grey,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        // trailing: const Icon(
                        //   Icons.arrow_back_ios_rounded,
                        //   color: AppColors.primaryBlue,
                        //   size: 25,
                        // ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 24.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ActionButtonWidget(
                        buttonIcon: AppImaes.notdisturbicon,
                        buttonText: 'Priority Mode / Do Not Disturb',
                        onPressed: () {
                          controller.saveTrigerAction('Do-Not-Disturb');
                          controller.changeActionNumber(0);
                        },
                        buttonColor: AppColors.primaryBlue,
                        borderColor: controller.actionButtonNum.value == 0
                            ? borderColor
                            : AppColors.primaryBlue,
                            
                      ),
                      ActionButtonWidget(
                        buttonIcon: AppImaes.vibrationIcon,
                        buttonText: 'Silent - Vibrate off',
                        onPressed: () {
                          controller.saveTrigerAction('Silent');
                          controller.changeActionNumber(1);
                        },
                        buttonColor: AppColors.primaryBlue,
                        borderColor: controller.actionButtonNum.value == 1
                            ? borderColor
                            : AppColors.primaryBlue,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ActionButtonWidget(
                        buttonIcon: AppImaes.speackerIcon,
                        buttonText: 'Speaker Phone ON/OFF',
                        onPressed: () {
                          controller.saveTrigerAction('Speaker-ON/OFF');
                          controller.changeActionNumber(2);
                        },
                         buttonColor: AppColors.primaryBlue,
                        borderColor: controller.actionButtonNum.value == 2
                            ? borderColor
                            : AppColors.primaryBlue,
                      ),
                      ActionButtonWidget(
                        buttonIcon: AppImaes.vibrationIcon,
                        buttonText: 'Vibrate Enable/Disable',
                        onPressed: () {
                          controller.saveTrigerAction('Vibrate-Enable/Disable');
                          controller.changeActionNumber(3);
                        },
                         buttonColor: AppColors.primaryBlue,
                        borderColor: controller.actionButtonNum.value == 3
                            ? borderColor
                            : AppColors.primaryBlue,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ActionButtonWidget(
                        buttonIcon: AppImaes.volumnchangeIcon,
                        buttonText: 'Volume Change',
                        onPressed: () {
                          controller.saveTrigerAction('Volume-Change');
                          controller.changeActionNumber(4);
                        },
                        buttonColor: AppColors.primaryBlue,
                        borderColor: controller.actionButtonNum.value == 4
                            ? borderColor
                            : AppColors.primaryBlue,
                      ),
                      ActionButtonWidget(
                        buttonIcon: AppImaes.volumupdownIcon,
                        buttonText: 'Volume up/ down',
                        onPressed: () {
                          controller.saveTrigerAction('Volume-Up-Down');
                          controller.changeActionNumber(5);
                        },
                         buttonColor: AppColors.primaryBlue,
                        borderColor: controller.actionButtonNum.value == 5
                            ? borderColor
                            : AppColors.primaryBlue,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.setup3Status();
                    controller.changeTabVal(2);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 180.h),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                    decoration: const BoxDecoration(
                        color: AppColors.primaryBlue,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                      child: CText(
                        text: 'Next',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

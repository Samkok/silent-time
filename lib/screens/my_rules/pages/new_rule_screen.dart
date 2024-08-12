import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:silenttime/screens/my_rules/dialogs/day_time_trigger.dart';
import 'package:silenttime/screens/my_rules/controller/myrules_controller.dart';
import 'package:silenttime/screens/my_rules/dialogs/day_week_month.dart';
import 'package:silenttime/screens/my_rules/dialogs/regular_interval_dialog.dart';
import 'package:silenttime/screens/my_rules/pages/action_screen.dart';
import 'package:silenttime/screens/my_rules/pages/rules_screen.dart';
import 'package:silenttime/utils/app_imaes.dart';
import 'package:silenttime/utils/colors.dart';
import 'package:silenttime/widges/custom_appbar.dart';
import 'package:silenttime/widges/custom_text.dart';
import 'package:silenttime/widges/select_are_mode_dialog.dart';
import 'package:silenttime/widges/triger_title_button.dart';
import 'myZone_screen.dart';

class NewRuleScreen extends StatefulWidget {
  const NewRuleScreen({super.key});

  @override
  State<NewRuleScreen> createState() => _NewRuleScreenState();
}

class _NewRuleScreenState extends State<NewRuleScreen> {
  MyRulesController myRulesController = Get.put(MyRulesController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyRulesController>(
        init: MyRulesController(),
        builder: (controller) {
          return Scaffold(
              appBar: CustomAppBar(
                text: 'New Rules',
                autoleadingIcon: true,
                actionIconVal: false,
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
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
                            // mainAxisSize: MainAxisSize.min,
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
                    controller.tabVal.value == 0
                        ? Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 24.h),
                                height: 40.h,
                                width: 3888.w,
                                decoration: const BoxDecoration(
                                  color: AppColors.primaryBlue,
                                ),
                                child: Row(
                                  children: [
                                    Image(
                                      image: const AssetImage(
                                        AppImaes.trigerlogo,
                                      ),
                                      height: 25.h,
                                      width: 25.h,
                                    ),
                                    CText(
                                      text: 'Add Trigger',
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.whiteColor,
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.grey, width: 0.3)),
                                child: Column(
                                  children: [
                                    ExpansionTile(
                                      iconColor: AppColors.primaryBlue,
                                      collapsedIconColor: AppColors.primaryBlue,
                                      childrenPadding:
                                          EdgeInsets.symmetric(horizontal: 3.w),
                                      shape: const Border(
                                          bottom: BorderSide(
                                              color: AppColors.grey,
                                              width: 0.3)),
                                      title: Row(
                                        children: [
                                          Image(
                                            image: const AssetImage(
                                                AppImaes.locationLogog),
                                            height: 24.h,
                                            width: 24.w,
                                          ),
                                          SizedBox(width: 12.w),
                                          CText(
                                            text: 'Location Trigger',
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primaryBlue
                                                .withOpacity(0.6),
                                          )
                                        ],
                                      ),
                                      children: [
                                        CText(
                                          maxLines: 2,
                                          alignText: TextAlign.center,
                                          text:
                                              'Enters or exists a designed region, See developer site for location trigger tips and tricks.',
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w300,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 16.h, bottom: 24.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  controller.saveTrigerTitle(
                                                    'Location Trigger',
                                                  );

                                                  // showDialog(
                                                  //     context: context,
                                                  //     builder: (BuildContext
                                                  //         context) {
                                                  //       return const LocationPermishionDialog();
                                                  //     });
                                                  // Navigator.pop(context);
                                                  // showDialog(
                                                  //     context: context,
                                                  //     builder: (BuildContext
                                                  //         context) {
                                                  //       return const SelectAreaModeDialog();
                                                  //     });

                                                  Get.to(() =>
                                                      const MyZoneScreen());
                                                },
                                                child: TrigerTitleWidget(
                                                  widgetTitle:
                                                      'Location Trigger',
                                                  icondata:
                                                      Icons.calendar_month,
                                                  selectedTab: true,
                                                ),

                                                // Container(
                                                //   height: 64.h,
                                                //   width: 182.w,
                                                //   decoration: BoxDecoration(
                                                //     color:
                                                //         AppColors.primaryBlue,
                                                //     borderRadius:
                                                //         BorderRadius.all(
                                                //       Radius.circular(8.r),
                                                //     ),
                                                //   ),
                                                //   child: Row(
                                                //     mainAxisAlignment:
                                                //         MainAxisAlignment
                                                //             .spaceEvenly,
                                                //     children: [
                                                //       const Icon(
                                                //         Icons.calendar_month,
                                                //         color: AppColors
                                                //             .whiteColor,
                                                //         size: 24.0,
                                                //       ),
                                                //       CText(
                                                //         text:
                                                //             'Location Trigger',
                                                //         fontSize: 16.sp,
                                                //         fontWeight:
                                                //             FontWeight.w300,
                                                //         color: AppColors
                                                //             .whiteColor,
                                                //       )
                                                //     ],
                                                //   ),
                                                // ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  controller.saveTrigerTitle(
                                                    'Geofence Trigger',
                                                  );
                                                  Navigator.pop(context);
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return const SelectAreaModeDialog();
                                                      });
                                                  // showDialog(
                                                  //     context: context,
                                                  //     builder: (BuildContext
                                                  //         context) {
                                                  //       return const LocationPermishionDialog();
                                                  //     });
                                                },
                                                child: TrigerTitleWidget(
                                                  widgetTitle:
                                                      'Geofence Trigger',
                                                  icondata:
                                                      Icons.calendar_month,
                                                  selectedTab: true,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    ExpansionTile(
                                      iconColor: AppColors.primaryBlue,
                                      collapsedIconColor: AppColors.primaryBlue,
                                      shape: const Border(),
                                      childrenPadding:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                      title: Row(
                                        children: [
                                          const Icon(
                                            Icons.calendar_month,
                                            size: 24,
                                            color: AppColors.primaryBlue,
                                          ),
                                          SizedBox(width: 12.w),
                                          CText(
                                            text: 'Day/Time Trigger',
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primaryBlue
                                                .withOpacity(0.6),
                                          )
                                        ],
                                      ),
                                      children: [
                                        CText(
                                          maxLines: 2,
                                          alignText: TextAlign.center,
                                          text:
                                              'Trigger on defined time of day on selected days of week.',
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w300,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 16.h, bottom: 15.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  controller.saveTrigerTitle(
                                                    'Day/Time Trigger',
                                                  );
                                                  dayTimeDialog(context);
                                                },
                                                child: TrigerTitleWidget(
                                                  widgetTitle:
                                                      'Day/Time Trigger',
                                                  icondata:
                                                      Icons.access_time_rounded,
                                                  selectedTab: true,
                                                ),
                                              ),
                                              // InkWell(
                                              //   onTap: () {
                                              //     dayTimeDialog(context);
                                              //   },
                                              //   child: Container(
                                              //     height: 64.h,
                                              //     width: 182.w,
                                              //     decoration: BoxDecoration(
                                              //       color:
                                              //           AppColors.primaryBlue,
                                              //       borderRadius:
                                              //           BorderRadius.all(
                                              //         Radius.circular(8.r),
                                              //       ),
                                              //     ),
                                              //     child: Row(
                                              //       mainAxisAlignment:
                                              //           MainAxisAlignment
                                              //               .spaceEvenly,
                                              //       children: [
                                              //         const Icon(
                                              //           Icons
                                              //               .access_time_rounded,
                                              //           color: AppColors
                                              //               .whiteColor,
                                              //           size: 24.0,
                                              //         ),
                                              //         SizedBox(
                                              //           width: 90.w,
                                              //           child: CText(
                                              //             alignText:
                                              //                 TextAlign.start,
                                              //             maxLines: 2,
                                              //             text:
                                              //                 'Day/Time Trigger',
                                              //             fontSize: 16.sp,
                                              //             fontWeight:
                                              //                 FontWeight.w300,
                                              //             color: AppColors
                                              //                 .whiteColor,
                                              //           ),
                                              //         )
                                              //       ],
                                              //     ),
                                              //   ),
                                              // ),
                                              InkWell(
                                                onTap: () {
                                                  controller.saveTrigerTitle(
                                                    'Day of Week/Month',
                                                  );
                                                  dayWeekMonthDialog(context);
                                                },
                                                child: TrigerTitleWidget(
                                                  widgetTitle:
                                                      'Day of Week/Month',
                                                  icondata:
                                                      Icons.access_time_rounded,
                                                  selectedTab: true,
                                                ),
                                              ),
                                              // InkWell(
                                              //   onTap: () {
                                              //     dayWeekMonthDialog(context);
                                              //   },
                                              //   child: Container(
                                              //     height: 64.h,
                                              //     width: 182.w,
                                              //     decoration: BoxDecoration(
                                              //       color:
                                              //           AppColors.primaryBlue,
                                              //       borderRadius:
                                              //           BorderRadius.all(
                                              //         Radius.circular(8.r),
                                              //       ),
                                              //     ),
                                              //     child: Row(
                                              //       mainAxisAlignment:
                                              //           MainAxisAlignment
                                              //               .spaceEvenly,
                                              //       children: [
                                              //         const Icon(
                                              //           Icons
                                              //               .access_time_rounded,
                                              //           color: AppColors
                                              //               .whiteColor,
                                              //           size: 24.0,
                                              //         ),
                                              //         SizedBox(
                                              //           // color: AppColors.blueFD,
                                              //           width: 96,
                                              //           child: CText(
                                              //             alignText:
                                              //                 TextAlign.start,
                                              //             maxLines: 2,
                                              //             text:
                                              //                 'Day of Week/Month',
                                              //             fontSize: 16.sp,
                                              //             fontWeight:
                                              //                 FontWeight.w300,
                                              //             color: AppColors
                                              //                 .whiteColor,
                                              //           ),
                                              //         )
                                              //       ],
                                              //     ),
                                              //   ),
                                              // )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 16.h),
                                          child: InkWell(
                                            onTap: () {
                                              controller.saveTrigerTitle(
                                                'Regular Interval',
                                              );
                                              regularIntervalDialog(context);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15.w),
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 15.w),
                                              height: 64.h,
                                              // width: 182.w,
                                              decoration: BoxDecoration(
                                                color: AppColors.primaryBlue,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(8.r),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  const Icon(
                                                    Icons.timer_outlined,
                                                    color: AppColors.whiteColor,
                                                    size: 24.0,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 15.w),
                                                    child: CText(
                                                      maxLines: 2,
                                                      text: 'Regular Interval',
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color:
                                                          AppColors.whiteColor,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        : controller.tabVal.value == 1
                            ? const ActionScreen()
                            : controller.tabVal.value == 2
                                ? const RulesScreen()
                                : const SizedBox()
                  ],
                ),
              ));
        });
  }
}

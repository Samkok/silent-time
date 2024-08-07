import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_mute/flutter_mute.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:silenttime/controllers/switchbutton_controller.dart';
import 'package:silenttime/screens/my_rules/pages/new_rule_screen.dart';
import 'package:silenttime/services/background_location_services.dart';
import 'package:silenttime/utils/app_imaes.dart';
import 'package:silenttime/utils/colors.dart';
import 'package:silenttime/utils/toast.dart';
import 'package:silenttime/widges/custom_alert_dialog.dart';
import 'package:silenttime/widges/custom_appbar.dart';
import 'package:silenttime/widges/custom_text.dart';
import '../../models/triger_model.dart';
import '../my_rules/controller/myrules_controller.dart';
import '../update_triger.dart/update_triger.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool status = false;
  bool isexpand = false;

  MyRulesController myRulesController = Get.put(MyRulesController());
  SwitchButtonController switcherController = Get.put(SwitchButtonController());

  @override
  void initState() {
    myRulesController.getAllTriggers();
    myRulesController.checkPermission();
    BackgroundLocationService().getCurrentLocationm();
    Future.delayed(Duration(milliseconds: 500), () async {
      await switcherController.checkStatus();
      myRulesController.checkAndStopServices();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyRulesController>(
        init: MyRulesController(),
        builder: (controller) {
          return Scaffold(
              appBar: CustomAppBar(
                text: 'Silent Time',
                autoleadingIcon: false,
                actionIconVal: true,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              floatingActionButton: CircleAvatar(
                  backgroundColor: AppColors.primaryBlue,
                  child: IconButton(
                    onPressed: () {
                      controller.checkPermission();
                      myRulesController.setdefaultStartandEndTime();

                      controller.disposeThins();
                      Get.to(() => const NewRuleScreen());
                    },
                    icon: const Icon(
                      Icons.add,
                      color: AppColors.whiteColor,
                    ),
                  )),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    controller.isPermissionEnabled.value
                        ? const SizedBox()
                        : Container(
                            decoration:
                                const BoxDecoration(color: AppColors.readColor),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(
                                  AppImaes.infoImage,
                                  height: 30,
                                  width: 30,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: SizedBox(
                                      // width: 230,
                                      child: CText(
                                        text:
                                            'Allow Do not Disrupt Access for this App',
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    print("Click");
                                    FlutterMute
                                        .openNotificationPolicySettings();

                                    myRulesController
                                        .updateisPermissionEnabled(true);
                                  },
                                  child: Container(
                                    height: 39.h,
                                    width: 66.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16.r),
                                        bottomRight: Radius.circular(16.r),
                                      ),
                                      color: AppColors.primaryBlue,
                                    ),
                                    child: Center(
                                      child: CText(
                                        text: 'Fix it',
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                    controller.trigerModelList.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: Get.height * 0.15,
                                  ),
                                  child: const SizedBox(
                                    // height: Get.height * 0.1,
                                    width: 222,
                                    child: Image(
                                      image: AssetImage(AppImaes.noFigured),
                                    ),
                                  ),
                                ),
                                CText(
                                  text: 'No Rules Configured',
                                  fontSize: 16.sp,
                                )
                              ],
                            ),
                          )
                        : SizedBox(
                            // height: 400,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.trigerModelList.isEmpty
                                  ? 0
                                  : controller.trigerModelList.length,
                              itemBuilder: (context, index) {
                                TrigerModel item =
                                    controller.trigerModelList[index];
                                return Padding(
                                  padding: EdgeInsets.only(
                                      right: 15.w, left: 15.w, top: 20.h),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.grayEA,
                                            width: 0.3)),
                                    child: ExpansionTile(
                                      tilePadding: EdgeInsets.only(left: 25.w),
                                      childrenPadding:
                                          EdgeInsets.only(left: 25.w),
                                      trailing: const SizedBox(),
                                      shape:
                                          Border.all(color: AppColors.grayEA),
                                      title: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 10.w),
                                            child: const Icon(
                                              Icons.star_border,
                                              color: AppColors.primaryBlue,
                                            ),
                                          ),
                                          CText(
                                            text: item.trigerRuleName!,
                                            fontSize: 16,
                                          ),
                                          const Expanded(child: SizedBox()),
                                          const Icon(Icons
                                              .keyboard_arrow_down_outlined)
                                        ],
                                      ),
                                      subtitle: Column(children: [
                                        Divider(
                                            color: AppColors.grey
                                                .withOpacity(0.4)),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 13.h, top: 13.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CText(
                                                    text: 'Trigger',
                                                    fontSize: 14.sp,
                                                    color:
                                                        AppColors.primaryBlue,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                  CText(
                                                    text: item.trigerTitle!,
                                                    ellipsisText: true,
                                                    // text: 'ahmad',
                                                    fontSize: 14.sp,
                                                    color: AppColors.grey,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CText(
                                                    text: 'Action',
                                                    fontSize: 14.sp,
                                                    color:
                                                        AppColors.primaryBlue,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                  CText(
                                                    text: item.trigerAction!,
                                                    // trigeraction.length > 10
                                                    //     ? '${trigeraction.substring(0, 25)}...'
                                                    //     : trigeraction,
                                                    ellipsisText: true,
                                                    // text: 'ahmad',
                                                    fontSize: 14.sp,
                                                    color: AppColors.grey,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ]),
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            right: 29.w,
                                          ),
                                          child: Divider(
                                              color: AppColors.grey
                                                  .withOpacity(0.4)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: 14.h,
                                            bottom: 14.h,
                                            right: 29.w,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Obx(
                                                () => InkWell(
                                                  onTap: () {
                                                    if (switcherController
                                                        .pressedBool.value) {
                                                      controller
                                                          .trigerStatusUpdate(
                                                              index);
                                                    } else {
                                                      AppToast.infoToast(
                                                          "Switch on Triggers Firstly");
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .lueLightColor
                                                            .withOpacity(0.8),
                                                        border: const Border(
                                                            bottom: BorderSide(
                                                          color: AppColors
                                                              .primaryBlue,
                                                          width: 3,
                                                        ))),
                                                    height: 40.h,
                                                    width: 100.w,
                                                    child: Center(
                                                      child: CText(
                                                        text: switcherController
                                                                    .pressedBool
                                                                    .value ==
                                                                false
                                                            ? "OFF"
                                                            : item.trigerStatus ==
                                                                    true
                                                                ? 'ON'
                                                                : 'OFF',
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                decoration: const BoxDecoration(
                                                    color: AppColors.grey),
                                                height: 40.h,
                                                width: 1.w,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  controller.updateMasterFun(
                                                    item,
                                                    index,
                                                  );
                                                  log("Edit...........${controller.trigerModelList[index].trigerDayName}");
                                                  log("Edit.  trigerToTimeMint..........${controller.trigerModelList[index].trigerToTimeMint}");

                                                  Get.to(
                                                    () => UpdateTriger(
                                                      trigerModelIndex: controller
                                                              .trigerModelList[
                                                          index],
                                                      ind: index,
                                                    ),
                                                  );

                                                  // if (item.trigerTitle ==
                                                  //     'Location Trigger') {
                                                  //   Navigator.pop(context);
                                                  //   showDialog(
                                                  //       context: context,
                                                  //       builder: (BuildContext
                                                  //           context) {
                                                  //         return const SelectAreaModeDialog();
                                                  //       });
                                                  // } else {

                                                  // }
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue[100],
                                                      border: const Border(
                                                          bottom: BorderSide(
                                                        color: AppColors
                                                            .primaryBlue,
                                                        width: 3,
                                                      ))),
                                                  height: 40.h,
                                                  width: 100.w,
                                                  child: Center(
                                                    child: CText(
                                                      text: 'Edit',
                                                      fontSize: 16.sp,
                                                      color:
                                                          AppColors.primaryBlue,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                decoration: const BoxDecoration(
                                                    color: AppColors.grey),
                                                height: 40.h,
                                                width: 1.w,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return CustomDialog(
                                                          title:
                                                              'Are you sure you want to delete this Triger ',
                                                          onPress: () {
                                                            controller
                                                                .deleteTrigger(
                                                                    index);
                                                          },
                                                        );
                                                      });
                                                  // controller
                                                  //     .deleteTrigger(index);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue[100],
                                                      border: const Border(
                                                          bottom: BorderSide(
                                                        color: AppColors
                                                            .primaryBlue,
                                                        width: 3,
                                                      ))),
                                                  height: 40.h,
                                                  width: 100.w,
                                                  child: Center(
                                                    child: CText(
                                                      text: 'Delete',
                                                      fontSize: 16.sp,
                                                      color:
                                                          AppColors.primaryBlue,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                  ],
                ),
              ));
        });
  }
}

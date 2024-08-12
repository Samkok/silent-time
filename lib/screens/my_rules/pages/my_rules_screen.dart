import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:silenttime/controllers/theme_controller.dart';
import 'package:silenttime/models/triger_model.dart';
import 'package:silenttime/screens/my_rules/controller/myrules_controller.dart';
import 'package:silenttime/screens/my_rules/pages/new_rule_screen.dart';
import 'package:silenttime/screens/update_triger.dart/update_triger.dart';
import 'package:silenttime/utils/app_imaes.dart';
import 'package:silenttime/utils/colors.dart';
import 'package:silenttime/widges/custom_alert_dialog.dart';
import 'package:silenttime/widges/custom_appbar.dart';
import 'package:silenttime/widges/custom_text.dart';
import 'package:silenttime/widges/select_are_mode_dialog.dart';
import 'package:silenttime/widges/tabNameWidget.dart';

final MyRulesController myController = Get.put(MyRulesController());

class MyRulesScreen extends StatefulWidget {
  const MyRulesScreen({super.key});

  @override
  State<MyRulesScreen> createState() => _MyRulesScreenState();
}

class _MyRulesScreenState extends State<MyRulesScreen>
    with TickerProviderStateMixin {
  ThemeController themeController = Get.put(ThemeController());
  MyRulesController myRulesController = Get.put(MyRulesController());
  @override
  void initState() {
    super.initState();
    myRulesController.checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyRulesController>(
        init: MyRulesController(),
        builder: (controller) {
          return Scaffold(
              appBar: CustomAppBar(
                text: 'My Rules',
                autoleadingIcon: false,
                actionIconVal: false,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              floatingActionButton: CircleAvatar(
                  backgroundColor: AppColors.primaryBlue,
                  child: IconButton(
                    onPressed: () {
                      controller.setDefaultStartAndEndTime();

                      controller.disposeThins();
                      myRulesController.changeTabVal(0);
                      Get.to(() => const NewRuleScreen());

                      // print(controller.trigerModelList[0].zoneName);
                      // print(controller.trigerModelList[0].areaEntered);
                      // DateTime now = DateTime.now();
                      // int currentDay = now.day;

                      // Step 4: Read your list of model objects from Hive box
                      // final List<TrigerModel> retrievedPersons = [];
                      // for (int i = 0; i < personsBox.length; i++) {
                      //   retrievedPersons
                      //       .add(TrigerModel.fromJson(personsBox.get(i)));
                      // }

                      // retrievedPersons.forEach((trigger) {
                      //   print('${trigger.trigerTitle}');
                      // });
                    },
                    icon: const Icon(
                      Icons.add,
                      color: AppColors.whiteColor,
                    ),
                  )),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: AppColors.buleF9, width: 1))),
                      padding: EdgeInsets.only(bottom: 19.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.changeTabVal(0);
                            },
                            child: TabNameWidget(
                              tabName:
                                  'All(${controller.trigerModelList.length})',
                              onTap: () {},
                              tabtcolor: controller.tabVal.value == 0
                                  ? AppColors.primaryBlue
                                  : themeController.isLightTheme.value
                                      ? Colors.black
                                      : Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.changeTabVal(1);
                            },
                            child: TabNameWidget(
                              tabName: 'Active',
                              tabtcolor: controller.tabVal.value == 1
                                  ? AppColors.primaryBlue
                                  : themeController.isLightTheme.value
                                      ? Colors.black
                                      : Colors.white,
                              onTap: () {},
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.changeTabVal(2);
                            },
                            child: TabNameWidget(
                              tabName: 'Disabled',
                              tabtcolor: controller.tabVal.value == 2
                                  ? AppColors.primaryBlue
                                  : themeController.isLightTheme.value
                                      ? Colors.black
                                      : Colors.white,
                              onTap: () {},
                            ),
                          ),
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
                                    fontSize: 16.sp)
                              ],
                            ),
                          )
                        : SizedBox(
                            // height: 400,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.trigerFiilterList.isEmpty
                                  ? 0
                                  : controller.trigerFiilterList.length,
                              itemBuilder: (context, index) {
                                TriggerModel item =
                                    controller.trigerFiilterList[index];
                                return InkWell(
                                  onTap: () {
                                    // if (isexpand == true) {
                                    //   setState(() {
                                    //     isexpand = false;
                                    //     log(isexpand.toString());
                                    //   });
                                    // } else {
                                    //   setState(() {
                                    //     isexpand = true;
                                    //     log(isexpand.toString());
                                    //   });
                                    // }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: 15.w, left: 15.w, top: 20.h),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.grayEA,
                                              width: 0.3)),
                                      child: ExpansionTile(
                                        tilePadding:
                                            EdgeInsets.only(left: 25.w),
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                    CText(
                                                      text: item.trigerTitle!,
                                                      ellipsisText: true,
                                                      // text: 'ahmad',
                                                      fontSize: 14.sp,
                                                      color: AppColors.grey,
                                                      fontWeight:
                                                          FontWeight.w300,
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
                                                      fontWeight:
                                                          FontWeight.w300,
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
                                                      fontWeight:
                                                          FontWeight.w300,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    print("object");
                                                    controller
                                                        .trigerStatusUpdate(
                                                            index);
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
                                                        text:
                                                            item.trigerStatus ==
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
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          color:
                                                              AppColors.grey),
                                                  height: 40.h,
                                                  width: 1.w,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    controller.disposeThins();

                                                    controller.updateMasterFun(
                                                        item,
                                                        index,
                                                       );
                                                    if (item.trigerTitle ==
                                                        'Location Trigger') {
                                                      Navigator.pop(context);
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return const SelectAreaModeDialog();
                                                          });
                                                    } else {
                                                      Get.to(
                                                        () => UpdateTrigger(
                                                          triggerModelIndex:
                                                              controller
                                                                      .trigerModelList[
                                                                  index],
                                                          ind: index,
                                                        ),
                                                      );
                                                    }
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
                                                        color: AppColors
                                                            .primaryBlue,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          color:
                                                              AppColors.grey),
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
                                                        color: AppColors
                                                            .primaryBlue,
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
                                  ),

                                  //  TrigerWidget(
                                  //   trigerTitle: item.trigerTitle!,
                                  //   trigername: item.trigerAction.toString(),
                                  //   trigeraction: item.trigerAction!,
                                  //   isexpand: false,
                                  // ),
                                );
                                //  CText(
                                //     text: item.trigerAction == null
                                //         ? 'No title'
                                //         : item.trigerAction!,
                                //     fontSize: 12);
                                // ListTile(
                                //   title: Text(item.trigerTitle!),
                                //   subtitle: Text('\$${item.trigerAction!}'),
                                //   trailing: IconButton(
                                //     icon: Icon(Icons.delete),
                                //     onPressed: () => controller.deleteItem(index),
                                //   ),
                                // );
                              },
                            ),
                          ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(
                    //       vertical: 10.h, horizontal: 12.w),
                    //   child: Column(
                    //     children: [
                    //       InkWell(
                    //         onTap: () {
                    //           if (isexpand == true) {
                    //             setState(() {
                    //               isexpand = false;
                    //               log(isexpand.toString());
                    //             });
                    //           } else {
                    //             setState(() {
                    //               isexpand = true;
                    //               log(isexpand.toString());
                    //             });
                    //           }
                    //         },
                    //         child: TrigerWidget(
                    //           trigerTitle: 'Teaching Duration',
                    //           trigername: 'Area Entered (School)',
                    //           trigeraction: 'Silent - Vibrate Off (Enable)',
                    //           isexpand: isexpand,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ));
        });

    // return Scaffold(
    //   floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    //   floatingActionButton: CircleAvatar(
    //       backgroundColor: AppColors.primaryBlue,
    //       child: IconButton(
    //         onPressed: () {
    //           // Get.to(const NewRuleScreen());
    //           Get.to(() => const NewRuleScreen());
    //         },
    //         icon: const Icon(
    //           Icons.add,
    //           color: AppColors.whiteColor,
    //         ),
    //       )),
    // appBar: CustomAppBar(
    //   text: 'My Rules',
    //   autoleadingIcon: false,
    //   actionIconVal: false,
    // ),
    //   body: GetBuilder<MyRulesController>(
    //     init: MyRulesController(),
    //     builder: (controller) {
    //       return Column(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Container(
    //             decoration: const BoxDecoration(
    //                 border: Border(
    //                     bottom: BorderSide(color: AppColors.buleF9, width: 1))),
    //             padding: EdgeInsets.only(bottom: 19.h),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //               children: [
    //                 TabNameWidget(
    //                   tabName: 'All(4)',
    //                   onTap: () {
    //                     controller.changetabVal(0);
    //                   },
    //                   tabtcolor: controller.tabval.value == 0
    //                       ? AppColors.primaryBlue
    //                       : themeController.isLightTheme.value
    //                           ? Colors.black
    //                           : Colors.white,
    //                 ),
    //                 TabNameWidget(
    //                   tabName: 'Active (4)',
    //                   tabtcolor: controller.tabval.value == 1
    //                       ? AppColors.primaryBlue
    //                       : themeController.isLightTheme.value
    //                           ? Colors.black
    //                           : Colors.white,
    //                   onTap: () {
    //                     controller.changetabVal(1);
    //                   },
    //                 ),
    //                 TabNameWidget(
    //                   tabName: 'Disabled(0)',
    //                   tabtcolor: controller.tabval.value == 2
    //                       ? AppColors.primaryBlue
    //                       : themeController.isLightTheme.value
    //                           ? Colors.black
    //                           : Colors.white,
    //                   onTap: () {
    //                     controller.changetabVal(2);
    //                   },
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Padding(
    //             padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
    //             child: Column(
    //               children: [
    //                 InkWell(
    //                   onTap: () {},
    //                   child: TrigerWidget(
    //                     trigerTitle: 'Study Time',
    //                     trigername: 'Area Entered (School)',
    //                     trigeraction: 'Silent - Vibrate Off (Enable)',
    //                     isexpand: true,
    //                   ),
    //                 ),
    //                 InkWell(
    //                   onTap: () {},
    //                   child: TrigerWidget(
    //                     trigerTitle: 'Study Time',
    //                     trigername: 'Area Entered (School)',
    //                     trigeraction: 'Silent - Vibrate Off (Enable)',
    //                     isexpand: false,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           )
    //         ],
    //       );
    //     },
    //   ),
    // );
  }
}

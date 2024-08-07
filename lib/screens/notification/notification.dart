import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:silenttime/models/notification_model.dart';
import 'package:silenttime/screens/notification/notification_controller.dart';
import 'package:silenttime/utils/app_imaes.dart';
import 'package:silenttime/utils/colors.dart';
import 'package:silenttime/widges/custom_appbar.dart';
import 'package:silenttime/widges/custom_text.dart';

// ignore: must_be_immutable
class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key});
  NotificationController notificationController =
      Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    notificationController.getAllNotification();
    return Scaffold(
        appBar: CustomAppBar(
            text: "Notification", autoleadingIcon: true, actionIconVal: false),
        body: GetBuilder<NotificationController>(
            init: NotificationController(),
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: controller.notificationList.isEmpty
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
                                  text: 'Notification is Empty',
                                  fontSize: 16.sp)
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 30.h, bottom: 10.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // CText(
                                  //   text: "Today",
                                  //   fontSize: 20.sp,
                                  //   fontWeight: FontWeight.w400,
                                  // ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.notificationList.clear();
                                      controller.saveNotification(
                                          notification: NotificationModel(
                                              title: "null",
                                              description: "null",
                                              createdAt: DateTime.now()));
                                    },
                                    child: CText(
                                      text: "Clear All",
                                      fontSize: 20.sp,
                                      color: AppColors.primaryBlue,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: controller.notificationList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        // congratulationDialog(context);
                                      },
                                      child: card(
                                          controller.notificationList[index]));
                                })
                          ],
                        ),
                ),
              );
            }));
  }

  Widget card(NotificationModel noti) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primaryBlue.withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(4.r)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
            ),
            child: Row(
              children: [
                SvgPicture.asset("assets/svg/unMute.svg"),
                const SizedBox(width: 10),
                CText(
                  text: noti.title,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
          Divider(
            color: AppColors.primaryBlue.withOpacity(0.3),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CText(
                  text: noti.description,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CText(
                      text: formatDate(noti.createdAt),
                      fontSize: 14.sp,
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formatDate(DateTime dateTime) {
    // Format the time part with leading zeros for hour and minute, and with AM/PM indicator
    String formattedTime = DateFormat('h.mm a').format(dateTime);

    // Combine the formatted time with the space separator
    return formattedTime;
  }
}

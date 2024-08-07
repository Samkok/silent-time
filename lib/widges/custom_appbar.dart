import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:silenttime/screens/my_rules/controller/myrules_controller.dart';
import 'package:silenttime/utils/colors.dart';
import '../controllers/switchbutton_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final bool autoleadingIcon;
  final bool actionIconVal;
  CustomAppBar({
    Key? key,
    required this.text,
    required this.autoleadingIcon,
    required this.actionIconVal,
  }) : super(key: key);
  final SwitchButtonController pressController =
      Get.put(SwitchButtonController());

  final MyRulesController myRulesController = Get.put(MyRulesController());
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(81.h),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff6865FF),
              Color(0xff6966F0),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: AppBar(
            automaticallyImplyLeading: autoleadingIcon ? true : false,
            leading: autoleadingIcon
                ? GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black.withOpacity(0.5),
                        size: 20,
                      ),
                    ),
                  )
                : const Icon(
                    Icons.dashboard,
                    color: Colors.white,
                  ),
            leadingWidth: 25,
            title: Text(
              text,
              style: TextStyle(
                fontSize: 24.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              actionIconVal
                  ? Obx(() {
                      return Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: FlutterSwitch(
                          activeText: 'ON',
                          inactiveText: 'Off',
                          activeTextColor: AppColors.primaryBlue,
                          activeColor: AppColors.whiteColor,
                          activeToggleColor: AppColors.primaryBlue,
                          inactiveColor: AppColors.grey,
                          width: 55.0,
                          height: 25.0,
                          valueFontSize: 12.0,
                          toggleSize: 13.0,
                          value: pressController.pressedBool.value,
                          borderRadius: 30.0,
                          showOnOff: true,
                          onToggle: (val) {
                            pressController.changeStatus(val);
                            // myRulesController.allTrigerOnOFF(
                            //     pressController.pressedBool.value);
                          },
                        ),
                      );
                    })
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(81.h);
}

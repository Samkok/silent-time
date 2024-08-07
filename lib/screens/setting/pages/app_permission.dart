import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:silenttime/screens/setting/controller/setting_controller.dart';
import 'package:silenttime/utils/colors.dart';
import 'package:silenttime/widges/custom_appbar.dart';
import 'package:silenttime/widges/custom_text.dart';

class AppPermission extends StatelessWidget {
  const AppPermission({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "App Permissions",
        autoleadingIcon: true,
        actionIconVal: false,
      ),
      body: GetBuilder<SettinsController>(
        init: SettinsController(),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                tile(
                    icon: "assets/svg/ph_camera.svg",
                    text: "Camera",
                    statusValue: controller.cameraBool.value,
                    onToggle: (val) {
                      controller.changeCameraStatus();
                    }),
                tile(
                    icon: "assets/svg/storage.svg",
                    text: "Storage",
                    statusValue: controller.storageBool.value,
                    onToggle: (val) {
                      controller.changeStorageStatus();
                    }),
                tile(
                    icon: "assets/svg/location.svg",
                    text: "Location",
                    statusValue: controller.locationBool.value,
                    onToggle: (val) {
                      controller.changeLocationBoolStatus();
                    }),
                tile(
                    icon: "assets/svg/microphone-outline.svg",
                    text: "Microphone",
                    statusValue: controller.microphoneBool.value,
                    onToggle: (val) {
                      controller.changeMicrophoneStatus();
                    }),
                tile(
                    icon: "assets/svg/contact.svg",
                    text: "Contacts",
                    statusValue: controller.contactsBool.value,
                    onToggle: (val) {
                      controller.changeContactsBoolStatus();
                    }),
                tile(
                    icon: "assets/svg/phone.svg",
                    text: "Phone",
                    statusValue: controller.phoneBool.value,
                    onToggle: (val) {
                      controller.changePhoneBoolStatus();
                    }),
                tile(
                    icon: "assets/svg/sms.svg",
                    text: "Message",
                    statusValue: controller.messageBool.value,
                    onToggle: (val) {
                      controller.changeMessageBoolStatus();
                    }),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget tile({
    required icon,
    required text,
    required statusValue,
    required Function(bool) onToggle,
  }) {
    return ListTile(
      leading: SvgPicture.asset(icon),
      title: CText(
        text: "$text",
        fontSize: 20.sp,
        fontWeight: FontWeight.w300,
      ),
      trailing: Padding(
        padding: EdgeInsets.only(right: 10.w),
        child: SizedBox(
          width: 60.w,
          child: FlutterSwitch(
            activeText: 'ON',
            inactiveText: 'OFF',
            activeTextColor: AppColors.whiteColor,
            activeColor: AppColors.primaryBlue,
            activeToggleColor: AppColors.whiteColor,
            inactiveColor: AppColors.grey,
            width: 55.0,
            height: 25.0,
            valueFontSize: 12.0,
            toggleSize: 13.0,
            value: statusValue,
            borderRadius: 30.0,
            showOnOff: true,
            onToggle: onToggle,
          ),
        ),
      ),
      shape: Border(
        bottom: BorderSide(
          color: AppColors.primaryBlue.withOpacity(0.3),
        ),
      ),
      contentPadding: const EdgeInsets.only(
        left: 0,
        right: 0,
        bottom: 0,
        top: 10,
      ),
    );
  }
}

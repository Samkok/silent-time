import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:silenttime/controllers/theme_controller.dart';
import 'package:silenttime/screens/setting/pages/app_permission.dart';
import 'package:silenttime/screens/setting/pages/copyright_info.dart';
import 'package:silenttime/screens/setting/pages/terms_conditions.dart';
import 'package:silenttime/utils/app_imaes.dart';
import 'package:silenttime/utils/colors.dart';
import 'package:silenttime/widges/custom_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class Settings extends StatelessWidget {
  Settings({super.key});
  ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 80.h, bottom: 24.h),
                height: 170.h,
                width: 300.w,
                child: Image.asset(
                  "assets/app_images/logo_trnsp.PNG",
                ),
              ),
              CText(
                text: "Silent Time",
                color: AppColors.primaryBlue,
                fontSize: 32.sp,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: 55.h,
              ),
              // tile(
              //     icon: "assets/svg/permissionchecker.svg",
              //     text: "App Permissions",
              //     onTap: () {
              //       Get.to(const AppPermission());
              //     }),
              themeModetile(),
              tile(
                  icon: "assets/svg/termsConidtion.svg",
                  text: "Terms and Conditions",
                  onTap: () {
                    Get.to(TermsConditions());
                  }),
              tile(
                  icon: "assets/svg/copyright.svg",
                  text: "Copyright Information",
                  onTap: () {
                    Get.to(CopyRightInformation());
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget tile({required icon, required text, required onTap}) {
    return ListTile(
      leading: SvgPicture.asset(icon),
      title: CText(
        text: "$text",
        fontSize: 20.sp,
        color: AppColors.primaryBlue,
        fontWeight: FontWeight.w300,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: AppColors.grey,
        size: 15,
      ),
      shape: Border(
        bottom: BorderSide(
          color: AppColors.primaryBlue.withOpacity(0.3),
        ),
      ),
      contentPadding:
          const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 10),
      onTap: onTap,
    );
  }

  Widget themeModetile() {
    return ListTile(
      leading: SvgPicture.asset("assets/svg/lightdarkicon.svg"),
      title: Obx(
        () => CText(
          text: "${themeController.isLightTheme.value ? 'Dark' : 'Light'} Mode",
          fontSize: 20.sp,
          color: AppColors.primaryBlue,
          fontWeight: FontWeight.w300,
        ),
      ),
      trailing: ObxValue(
        (data) => Switch(
          activeColor: Color(0xff5e6571),
          inactiveTrackColor: Color(0xff5e6571),
          value: themeController.isLightTheme.value,
          onChanged: (val) {
            themeController.isLightTheme.value = val;
            Get.changeThemeMode(
              themeController.isLightTheme.value
                  ? ThemeMode.light
                  : ThemeMode.dark,
            );
            themeController.saveThemeStatus();
          },
          thumbColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return const Color(0xffEDF2F4); // Color when switch is active
            }
            return const Color(0xff2B2D42); // Color when switch is inactive
          }),
          activeThumbImage: const AssetImage('assets/app_images/Sun.png'),
          inactiveThumbImage: const AssetImage('assets/app_images/Moon.png'),
        ),
        false.obs,
      ),
      shape: Border(
        bottom: BorderSide(
          color: AppColors.primaryBlue.withOpacity(0.3),
        ),
      ),
      contentPadding:
          const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 10),
    );
  }
}

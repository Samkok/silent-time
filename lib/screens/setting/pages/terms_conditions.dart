import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:silenttime/utils/colors.dart';
import 'package:silenttime/widges/custom_appbar.dart';
import 'package:silenttime/widges/custom_text.dart';

// ignore: must_be_immutable
class TermsConditions extends StatelessWidget {
  TermsConditions({Key? key}) : super(key: key);

  var spaceheight = 10.h;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "Terms & Conditions",
        autoleadingIcon: true,
        actionIconVal: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CText(
                    text: "Welcome to Silent Time!",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: spaceheight,
                  ),
                  CText(
                    text:
                        "Before you proceed to use our services, please take a moment to read and understand the following terms and conditions.",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w300,
                    maxLines: 5,
                  ),
                  SizedBox(
                    height: spaceheight,
                  ),
                  CText(
                    text: "1 - Acceptance of Terms",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w300,
                    color: AppColors.primaryBlue,
                  ),
                  SizedBox(
                    height: spaceheight,
                  ),
                  Text.rich(TextSpan(
                      text: 'Using Silent Time means agreeing to our ',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w300,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'Terms & Conditions. ',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w300,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                        TextSpan(
                          text:
                              'If you do not agree with any part of these terms, please refrain from using the App. ',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ])),
                  SizedBox(
                    height: spaceheight,
                  ),
                  CText(
                    text: "2 - User Responsibilities:",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w300,
                    color: AppColors.primaryBlue,
                  ),
                  SizedBox(
                    height: spaceheight,
                  ),
                  CText(
                    text:
                        "Ensure accurate location and time settings for optimal functionality. We are not liable for missed or incorrect activations.",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w300,
                    maxLines: 5,
                  ),
                  SizedBox(
                    height: spaceheight,
                  ),
                  CText(
                    text: "3 - Privacy and Security:",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w300,
                    color: AppColors.primaryBlue,
                  ),
                  SizedBox(
                    height: spaceheight,
                  ),
                  Text.rich(TextSpan(
                      text: 'Review our',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w300,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'Privacy Policy ',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w300,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                        TextSpan(
                          text:
                              'for details on data collection, usage, and security. ',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ])),
                  SizedBox(
                    height: spaceheight,
                  ),
                  CText(
                    text: "4 - Updates:",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w300,
                    color: AppColors.primaryBlue,
                  ),
                  SizedBox(
                    height: spaceheight,
                  ),
                  CText(
                    text: "Keep the app update for the best experience.",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w300,
                    maxLines: 5,
                  ),
                  SizedBox(
                    height: spaceheight,
                  ),
                  CText(
                    text: "For questions, contact us at our email account",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w300,
                    maxLines: 5,
                  ),
                  SizedBox(
                    height: spaceheight,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CText(
                        text: "[contact@email.com]",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w300,
                        color: AppColors.primaryBlue,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: spaceheight,
                  ),
                ],
              ),
            ),
          )),
          Column(
            children: [
              Divider(
                color: AppColors.primaryBlue.withOpacity(0.3),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CText(
                        text: "Disagree",
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryBlue,
                      ),
                      CText(
                        text: "Agree",
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryBlue,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

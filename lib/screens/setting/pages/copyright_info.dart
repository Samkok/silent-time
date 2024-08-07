import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:silenttime/utils/colors.dart';
import 'package:silenttime/widges/custom_appbar.dart';
import 'package:silenttime/widges/custom_text.dart';

// ignore: must_be_immutable
class CopyRightInformation extends StatelessWidget {
  CopyRightInformation({Key? key}) : super(key: key);

  var spaceheight = 20.h;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "Copyright Information",
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
                  Text.rich(TextSpan(
                      text: 'Silent Time and its logo are trademarks of  ',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w300,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'Silent Time',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w300,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      ])),
                  SizedBox(
                    height: spaceheight,
                  ),
                  CText(
                    text:
                        "Unauthorized use, reproduction, or distribution of any content within this app is strictly prohibited. ",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w300,
                    maxLines: 5,
                  ),
                  SizedBox(
                    height: spaceheight,
                  ),
                  Text.rich(TextSpan(
                      text:
                          'For inquiries regarding the use of Silent Time content, please contact us at ',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w300,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          text: '[copyright@email.com].',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w300,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      ])),
                  SizedBox(
                    height: spaceheight,
                  ),
                  SizedBox(
                    height: spaceheight,
                  ),
                  SizedBox(
                    height: spaceheight,
                  ),
                  CText(
                    text:
                        "Thank you for respecting our intellectual property! ",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w300,
                    maxLines: 5,
                    alignText: TextAlign.center,
                  ),
                  SizedBox(
                    height: spaceheight,
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}

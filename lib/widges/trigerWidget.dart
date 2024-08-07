import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:silenttime/utils/colors.dart';
import 'package:silenttime/widges/custom_text.dart';

// ignore: must_be_immutable
class TrigerWidget extends StatelessWidget {
  final String trigerTitle;
  final String trigername;
  final String trigeraction;
  bool isexpand;

  TrigerWidget({
    Key? key,
    required this.trigerTitle,
    required this.trigername,
    required this.trigeraction,
    required this.isexpand,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey.withOpacity(0.3), width: 1),
      ),
      // height: 300,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 13.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: WidgetSpan(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: const Icon(
                              Icons.star_border,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                          CText(
                            text: trigerTitle,
                            fontSize: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.primaryBlue,
                  )
                ],
              ),
            ),
            Divider(color: AppColors.grey.withOpacity(0.4)),
            Padding(
              padding: EdgeInsets.only(bottom: 13.h, top: 13.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CText(
                        text: 'Trigger',
                        fontSize: 14.sp,
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.w300,
                      ),
                      CText(
                        text: trigername,
                        ellipsisText: true,
                        // text: 'ahmad',
                        fontSize: 14.sp,
                        color: AppColors.grey,
                        fontWeight: FontWeight.w300,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CText(
                        text: 'Action',
                        fontSize: 14.sp,
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.w300,
                      ),
                      CText(
                        text: trigeraction.length > 10
                            ? '${trigeraction.substring(0, 25)}...'
                            : trigeraction,
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
            isexpand
                ? Column(
                    children: [
                      Divider(color: AppColors.grey.withOpacity(0.4)),
                      Padding(
                        padding: EdgeInsets.only(bottom: 13.h, top: 14.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color:
                                      AppColors.lueLightColor.withOpacity(0.8),
                                  border: const Border(
                                      bottom: BorderSide(
                                    color: AppColors.primaryBlue,
                                    width: 3,
                                  ))),
                              height: 40.h,
                              width: 100.w,
                              child: Center(
                                child: CText(
                                  text: 'On',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              decoration:
                                  const BoxDecoration(color: AppColors.grey),
                              height: 40.h,
                              width: 1.w,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  border: const Border(
                                      bottom: BorderSide(
                                    color: AppColors.primaryBlue,
                                    width: 3,
                                  ))),
                              height: 40.h,
                              width: 100.w,
                              child: Center(
                                child: CText(
                                  text: 'Edit',
                                  fontSize: 16.sp,
                                  color: AppColors.primaryBlue,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              decoration:
                                  const BoxDecoration(color: AppColors.grey),
                              height: 40.h,
                              width: 1.w,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  border: const Border(
                                      bottom: BorderSide(
                                    color: AppColors.primaryBlue,
                                    width: 3,
                                  ))),
                              height: 40.h,
                              width: 100.w,
                              child: Center(
                                child: CText(
                                  text: 'Delete',
                                  fontSize: 16.sp,
                                  color: AppColors.primaryBlue,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

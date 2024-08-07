import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../my_rules/controller/myrules_controller.dart';

class UpdateLocationPickerScreen extends StatefulWidget {
  const UpdateLocationPickerScreen({super.key});

  @override
  State<UpdateLocationPickerScreen> createState() =>
      _UpdateLocationPickerScreenState();
}

class _UpdateLocationPickerScreenState
    extends State<UpdateLocationPickerScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyRulesController>(
      init: MyRulesController(),
      builder: (controller) => Container(
        width: Get.width * 0.9,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: const SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     CText(
              //       text: "Add Zone",
              //       fontSize: 24.sp,
              //       color: AppColors.primaryBlue,
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 40.h,
              // ),
              // InkWell(
              //   onTap: () {
              //     locationPiker(context);
              //   },
              //   child: Container(
              //     padding: EdgeInsets.only(bottom: 5.h),
              //     decoration: const BoxDecoration(
              //       border: Border(
              //         bottom: BorderSide(
              //           color: AppColors.grayEA,
              //         ),
              //       ),
              //     ),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Expanded(
              //           child: SizedBox(
              //             child: CText(
              //               text: controller.locationName.isEmpty
              //                   ? 'Address'
              //                   : controller.locationName.value.toString(),
              //               maxLines: 3,
              //               fontSize: 20.sp,
              //               fontWeight: FontWeight.w500,
              //             ),
              //           ),
              //         ),
              //         const Icon(
              //           Icons.location_on,
              //           color: AppColors.primaryBlue,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // // TextField(
              // //   onTap: () {
              // //     locationPiker(context);
              // //   },
              // //   enabled: true,
              // //   decoration: InputDecoration(
              // //     hintText: "Address",
              // //     border: UnderlineInputBorder(
              // //       borderSide: BorderSide(
              // //         color: AppColors.primaryBlue.withOpacity(0.3),
              // //       ), // Add a bottom border
              // //     ),
              // //     suffixIcon: Icon(
              // //       Icons.location_on,
              // //       color: AppColors.primaryBlue,
              // //     ), // Add a trailing icon
              // //   ),
              // // ),

              // SizedBox(
              //   height: 20.h,
              // ),
              // TextField(
              //   controller: controller.zoneNameController,
              //   decoration: InputDecoration(
              //     hintText: "Enter zone name here",

              //     border: UnderlineInputBorder(
              //       borderSide: BorderSide(
              //         color: AppColors.primaryBlue.withOpacity(0.3),
              //       ), // Add a bottom border
              //     ),
              //     // Add a trailing icon
              //   ),
              // ),
              // SizedBox(
              //   height: 20.h,
              // ),
              // TextField(
              //   controller: controller.zoneRadiousController,
              //   keyboardType: TextInputType.number,
              //   decoration: InputDecoration(
              //     hintText: "Enter Radius (Meters)",
              //     border: UnderlineInputBorder(
              //       borderSide: BorderSide(
              //         color: AppColors.primaryBlue.withOpacity(0.3),
              //       ), // Add a bottom border
              //     ),
              //     // Add a trailing icon
              //   ),
              // ),
              // SizedBox(
              //   height: 30.h,
              // ),
              // InkWell(
              //   onTap: () {
              //     // controller.setup2Status();
              //     // controller.changetabVal(1);
              //     // Get.to(() => const NewRuleScreen());
              //   },
              //   child: Center(
              //     child: Container(
              //       margin: EdgeInsets.only(bottom: 20.h),
              //       height: 47.h,
              //       width: 387.w,
              //       decoration: BoxDecoration(
              //         color: AppColors.primaryBlue,
              //         borderRadius: BorderRadius.circular(12.r),
              //       ),
              //       alignment: Alignment.center,
              //       child: Align(
              //         alignment: Alignment.center,
              //         child: CText(
              //           text: 'Next',
              //           fontSize: 20.sp,
              //           fontWeight: FontWeight.w500,
              //           color: AppColors.whiteColor,
              //         ),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

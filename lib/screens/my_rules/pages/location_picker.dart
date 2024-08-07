// ignore_for_file: unnecessary_new
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:silenttime/screens/my_rules/controller/myrules_controller.dart';
import 'package:silenttime/screens/my_rules/pages/new_rule_screen.dart';
import 'package:silenttime/utils/colors.dart';
import 'package:silenttime/utils/toast.dart';
import 'package:silenttime/widges/custom_text.dart';
import 'package:location/location.dart';

var mapKey = "AIzaSyDdKJjEi61s6sSfSQv2IceTYzBm-o-o7G8";

locationPiker(context) async {
  MyRulesController myRulesController = Get.put(MyRulesController());
  print('locationPiker:.................. ${locationPiker}');

  // try {
  //   var latlng = await getCurrentLocation();
  // } catch (e) {
  //   print(e);
  // }
  log('latlng:............................ ');
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PlacePicker(
        apiKey: mapKey,
        onPlacePicked: (result) {
          myRulesController.updateLocationDetail(result);
          Navigator.of(context).pop();
        },
        initialPosition: LatLng(11.562108, 104.888535),
        useCurrentLocation: true,
        resizeToAvoidBottomInset:
            false, // only works in page mode, less flickery, remove if wrong offsets
      ),
    ),
  );
}

getCurrentLocation() async {
  Location location = new Location();

  bool serviceEnabled;
  PermissionStatus permissionGranted;
  LocationData locationData;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return;
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  locationData = await location.getLocation();
  return LatLng(
      locationData.latitude ?? 56.462002, locationData.longitude ?? -2.970700);
}

addZoneDialog(context, {isFromUpdate}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: GetBuilder<MyRulesController>(
            init: MyRulesController(),
            builder: (controller) => Container(
              width: Get.width * 0.9,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CText(
                          text: "Add Zone",
                          fontSize: 24.sp,
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    InkWell(
                      onTap: () {
                        controller.locationPickerClickUpdate(true);
                        locationPiker(context);
                      },
                      child: Container(
                        padding: EdgeInsets.only(bottom: 5.h),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.grayEA,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: CText(
                                  text: controller.locationName.isEmpty
                                      ? 'Address'
                                      : controller.locationName.value
                                          .toString(),
                                  maxLines: 3,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.location_on,
                              color: AppColors.primaryBlue,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // TextField(
                    //   onTap: () {
                    //     locationPiker(context);
                    //   },
                    //   enabled: true,
                    //   decoration: InputDecoration(
                    //     hintText: "Address",
                    //     border: UnderlineInputBorder(
                    //       borderSide: BorderSide(
                    //         color: AppColors.primaryBlue.withOpacity(0.3),
                    //       ), // Add a bottom border
                    //     ),
                    //     suffixIcon: Icon(
                    //       Icons.location_on,
                    //       color: AppColors.primaryBlue,
                    //     ), // Add a trailing icon
                    //   ),
                    // ),

                    SizedBox(
                      height: 20.h,
                    ),
                    TextField(
                      controller: controller.zoneNameController,
                      decoration: InputDecoration(
                        hintText: "Enter zone name here",

                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primaryBlue.withOpacity(0.3),
                          ), // Add a bottom border
                        ),
                        // Add a trailing icon
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextField(
                      controller: controller.zoneRadiousController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Enter Radius (Meters)",
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primaryBlue.withOpacity(0.3),
                          ), // Add a bottom border
                        ),
                        // Add a trailing icon
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    InkWell(
                      onTap: () {
                        if (controller.zoneRadiousController.text.isEmpty ||
                            controller.zoneNameController.text.isEmpty ||
                            controller.locationName.isEmpty) {
                          AppToast.failToast('Enter All values ');
                        } else {
                          controller.setup2Status();
                          controller.changetabVal(1);
                          if (isFromUpdate == true) {
                            Get.back();
                          } else {
                            Get.to(() => const NewRuleScreen());
                          }
                        }
                      },
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20.h),
                          height: 47.h,
                          width: 387.w,
                          decoration: BoxDecoration(
                            color: AppColors.primaryBlue,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          alignment: Alignment.center,
                          child: Align(
                            alignment: Alignment.center,
                            child: CText(
                              text: 'Next',
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

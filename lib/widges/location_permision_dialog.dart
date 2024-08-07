// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:silenttime/utils/app_imaes.dart';
// import 'package:silenttime/utils/colors.dart';
// import 'package:silenttime/widges/custom_text.dart';
// import 'package:silenttime/widges/select_are_mode_dialog.dart';

// class LocationPermishionDialog extends StatelessWidget {
//   const LocationPermishionDialog({super.key});

//   dialogContent(BuildContext context) {
//     return Container(
//       // height: 266.h,
//       decoration: const BoxDecoration(
//         // color: Colors.white,
//         shape: BoxShape.rectangle,
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(vertical: 20.h),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Image.asset(
//               AppImaes.locationLogog,
//               height: 32.h,
//               width: 32.h,
//             ),
//             Padding(
//               padding: EdgeInsets.only(top: 15.h),
//               child: SizedBox(
//                 width: 311.w,
//                 child: CText(
//                   text: 'Allow Silent Time to access your location?',
//                   alignText: TextAlign.center,
//                   maxLines: 2,
//                   fontSize: 20.sp,
//                   fontWeight: FontWeight.w300,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(top: 24.h),
//               child: const Divider(
//                 color: AppColors.grayEA,
//                 height: 0.3,
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 Navigator.pop(context);
//                 showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return const SelectAreaModeDialog();
//                     });
//               },
//               child: Padding(
//                 padding: EdgeInsets.only(top: 15.h),
//                 child: SizedBox(
//                   width: 311.w,
//                   child: CText(
//                     text: 'Allow',
//                     color: AppColors.primaryBlue,
//                     alignText: TextAlign.center,
//                     maxLines: 2,
//                     fontSize: 20.sp,
//                     fontWeight: FontWeight.w300,
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(top: 24.h),
//               child: const Divider(
//                 color: AppColors.grayEA,
//                 height: 0.3,
//               ),
//             ),
//             InkWell(
//               onTap: () {},
//               child: Padding(
//                 padding: EdgeInsets.only(top: 15.h),
//                 child: SizedBox(
//                   width: 311.w,
//                   child: CText(
//                     text: 'Don’t Allow',
//                     color: AppColors.primaryBlue,
//                     alignText: TextAlign.center,
//                     maxLines: 2,
//                     fontSize: 20.sp,
//                     fontWeight: FontWeight.w300,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       elevation: 0.0,
//       // backgroundColor: Colors.transparent,
//       child: dialogContent(context),
//     );
//   }
// }

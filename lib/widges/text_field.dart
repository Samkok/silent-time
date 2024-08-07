import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:silenttime/utils/colors.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  String text;
  String label;
  Function() onTap;
  CustomTextField(
      {super.key,
      required this.text,
      required this.label,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(text: "$text"),
      readOnly: true,
      style: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
      ),
      onTap: onTap,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          border: OutlineInputBorder(),
          labelText: '$label',
          labelStyle: TextStyle(
            color: AppColors.primaryBlue,
            fontSize: 17.sp,
            fontWeight: FontWeight.w400,
          )),
    );
  }
}

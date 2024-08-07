import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silenttime/utils/app_imaes.dart';
import 'package:silenttime/screens/bottom_navbar/bottombar_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkIntro();
  }

  void checkIntro() {
    Timer(const Duration(seconds: 2), () {
      Get.offAll(const BottombarScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          height: 226,
          width: 300,
          child: Image(
            image: AssetImage(
              "assets/app_images/logo_trnsp.PNG",
            ),
          ),
        ),
      ),
    );
  }
}

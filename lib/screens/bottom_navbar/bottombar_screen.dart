import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:silenttime/screens/my_rules/pages/my_rules_screen.dart';
import 'package:silenttime/screens/notification/notification.dart';
import 'package:silenttime/screens/setting/settings.dart';
import 'package:silenttime/utils/colors.dart';

import '../../controllers/theme_controller.dart';
import '../home/home_screen.dart';

class BottombarScreen extends StatefulWidget {
  const BottombarScreen({super.key});

  @override
  State<BottombarScreen> createState() => _BottombarScreenState();
}

class _BottombarScreenState extends State<BottombarScreen> {
  var _currentIndex = 0;
  ThemeController themeController = Get.put(ThemeController());

  // int _selectedTab = 0;

  List pages = [
    const HomeScreen(),
    const MyRulesScreen(),
    NotificationScreen(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
          padding: const EdgeInsets.only(top: 23),
          decoration: const BoxDecoration(
            color: Color(0xffDEE5EF),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(27),
              topRight: Radius.circular(27),
            ),
          ),
          child: Obx(
            () => Container(
              height: 75,
              decoration: BoxDecoration(
                color: themeController.isLightTheme.value
                    ? AppColors.whiteColor
                    : AppColors.black,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(27),
                  topRight: Radius.circular(27),
                ),
              ),
              child: SalomonBottomBar(
                selectedItemColor: Colors.deepPurple,
                selectedColorOpacity: 1.0,
                unselectedItemColor: const Color(0xff44475C),
                curve: Curves.linear,
                // duration: Duration(microseconds: 1000),
                currentIndex: _currentIndex,
                onTap: (i) => setState(() => _currentIndex = i),
                items: [
                  /// Home
                  SalomonBottomBarItem(
                      icon: SvgPicture.asset(
                        "assets/svg/Home.svg",
                        color: _currentIndex == 0
                            ? AppColors.whiteColor
                            : themeController.isLightTheme.value
                                ? AppColors.black
                                : AppColors.whiteColor,
                      ),
                      title: Text(
                        "Home",
                        style: TextStyle(
                          color: _currentIndex == 0
                              ? Colors.white
                              : const Color(0xff44475C),
                          fontSize: 14,
                        ),
                      ),
                      selectedColor: const Color(0xff6B67F2)),

                  /// Likes
                  SalomonBottomBarItem(
                    icon: SvgPicture.asset(
                      "assets/svg/rule.svg",
                      color: _currentIndex == 1
                          ? AppColors.whiteColor
                          : themeController.isLightTheme.value
                              ? AppColors.black
                              : AppColors.whiteColor,
                    ),
                    title: Text(
                      "My Rules",
                      style: TextStyle(
                        color: _currentIndex == 1
                            ? Colors.white
                            : const Color(0xff44475C),
                        fontSize: 14,
                      ),
                    ),
                    selectedColor: const Color(0xff6B67F2),
                    unselectedColor: const Color(0xff44475C),
                  ),

                  /// Search
                  SalomonBottomBarItem(
                    icon: SvgPicture.asset(
                      "assets/svg/notification.svg",
                      color: _currentIndex == 2
                          ? AppColors.whiteColor
                          : themeController.isLightTheme.value
                              ? AppColors.black
                              : AppColors.whiteColor,
                    ),
                    title: Text(
                      "Notification",
                      style: TextStyle(
                        color: _currentIndex == 2
                            ? Colors.white
                            : const Color(0xff44475C),
                        fontSize: 14,
                      ),
                    ),
                    selectedColor: const Color(0xff6B67F2),
                  ),

                  /// Profile
                  SalomonBottomBarItem(
                    icon: SvgPicture.asset(
                      "assets/svg/settings.svg",
                      color: _currentIndex == 3
                          ? AppColors.whiteColor
                          : themeController.isLightTheme.value
                              ? AppColors.black
                              : AppColors.whiteColor,
                    ),
                    title: Text(
                      "Settings",
                      style: TextStyle(
                        color: _currentIndex == 3
                            ? Colors.white
                            : const Color(0xff44475C),
                        fontSize: 14,
                      ),
                    ),
                    selectedColor: const Color(0xff6B67F2),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

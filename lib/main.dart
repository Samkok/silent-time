import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silenttime/screens/my_rules/controller/myrules_controller.dart';
import 'package:silenttime/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:silenttime/controllers/theme_controller.dart';
import 'dart:async';
import 'package:silenttime/services/background_services.dart';
import 'package:timezone/data/latest.dart' as tz;

// @pragma('vm:entry-point')
// void backgroundCallback() {
//   BackgroundLocationTrackerManager.handleBackgroundUpdated(
//     (data) async {
//       print("Data..............${data}");
//     },
//   );
// }

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await initializeBgService();
  await getApplicationDocumentsDirectory();
  // await BackgroundLocationTrackerManager.initialize(
  //   backgroundCallback,
  //   config: const BackgroundLocationTrackerConfig(
  //     loggingEnabled: true,
  //     androidConfig: AndroidConfig(
  //       notificationIcon: 'explore',
  //       trackingInterval: Duration(seconds: 4),
  //       distanceFilterMeters: null,
  //     ),
  //     iOSConfig: IOSConfig(
  //       activityType: ActivityType.FITNESS,
  //       distanceFilterMeters: null,
  //       restartAfterKill: true,
  //     ),
  //   ),
  // );
  runApp(const MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeController themeController = Get.put(ThemeController());

  MyRulesController myRulesController = Get.put(MyRulesController());

  checkPermission() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var permissions = pref.getBool('permission');
    if (permissions == true) {
      myRulesController.startLocationTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    myRulesController.getAllTriggers();
    checkPermission();

    themeController.getAndApplyTheme();
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          theme: themeController.lightTheme,
          darkTheme: themeController.darkTheme,
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
          // home: MyTodosScreen(),
          // home: TodosScreen(),
        );
      },
    );
  }
}

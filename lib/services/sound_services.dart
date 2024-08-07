import 'dart:developer';

import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:get/get.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';
import 'package:silenttime/screens/notification/notification_controller.dart';
import 'package:silenttime/widges/app_toast.dart';
import 'package:sound_mode/sound_mode.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';
import 'package:flutter_mute/flutter_mute.dart';

import '../models/notification_model.dart';

class SoundServices {
  NotificationController notificationController =
      Get.put(NotificationController());
  silentDevice() async {
    try {
      checkPermission();
      await SoundMode.setSoundMode(RingerModeStatus.silent);
      log("Acticated RingerModeStatus.silent......................!");
      notificationController.saveNotification(
        notification: NotificationModel(
          title: "Silence Mode Activated",
          description: "Silence activated! Enjoy your peace and quiet.",
          createdAt: DateTime.now(),
        ),
      );
    } catch (e) {
      appToast(masg: "$e", isEror: true);
      print(e);
    }
  }

  normalDevice() async {
    try {
      checkPermission();
      await SoundMode.setSoundMode(RingerModeStatus.normal);
      log("Acticated RingerModeStatus.normal......................!");
      notificationController.saveNotification(
        notification: NotificationModel(
          title: "Normal Mode Activated",
          description: "Normal activated! Enjoy your peace and quiet.",
          createdAt: DateTime.now(),
        ),
      );
    } catch (e) {
      appToast(masg: "$e", isEror: true);

      print(e);
    }
  }

  vibarationDevice() async {
    try {
      checkPermission();
      await SoundMode.setSoundMode(RingerModeStatus.vibrate);
      log("Acticated RingerModeStatus.vibrate......................!");
      notificationController.saveNotification(
        notification: NotificationModel(
          title: "Vibarat Mode Activated",
          description: "Vibarat activated! Enjoy your peace and quiet.",
          createdAt: DateTime.now(),
        ),
      );
    } catch (e) {
      appToast(masg: "$e", isEror: true);
      print(e);
    }
  }

  doNotDistrpDevice() async {
    try {
      checkPermission();
      await FlutterDnd.setInterruptionFilter(
          FlutterDnd.INTERRUPTION_FILTER_NONE);
      log("Acticated RingerModeStatus Do Not Distrap......................!");
      notificationController.saveNotification(
        notification: NotificationModel(
          title: "Do not Distrup Mode Activated",
          description: "Do not Distrup activated! Enjoy your peace and quiet.",
          createdAt: DateTime.now(),
        ),
      );
    } catch (e) {
      appToast(masg: "$e", isEror: true);
      print(e);
    }
  }

  volumeChangeDevice() async {
    try {
      checkPermission();
      //Volumne
      PerfectVolumeControl.setVolume(0.7);
      PerfectVolumeControl.hideUI = false;
      var vol = await PerfectVolumeControl.volume;
      print('vol: ${vol}');

      PerfectVolumeControl.stream.listen((volume) {
        print('volume: ${volume}');
        // Handle volume change
      });
      log("Acticated volumeChangeDevice ......................!");
      notificationController.saveNotification(
        notification: NotificationModel(
          title: "Volume Change Activated",
          description: "Volume Change activated! Enjoy your peace and quiet.",
          createdAt: DateTime.now(),
        ),
      );
    } catch (e) {
      appToast(masg: "$e", isEror: true);
      print(e);
    }
  }

  volumeOnOFFDevice({required bool volumeOn}) async {
    try {
      checkPermission();
      //Volumne
      //  checkPermission();
      PerfectVolumeControl.setVolume(volumeOn ? 0.9 : 0.0);
      PerfectVolumeControl.hideUI = false;
      var vol = await PerfectVolumeControl.volume;
      print('vol: ${vol}');
      log("Acticated volume ${volumeOn ? "ON" : "OFF"} ......................!");
      notificationController.saveNotification(
        notification: NotificationModel(
          title: "Volume ${volumeOn ? "ON" : "OFF"} Activated",
          description:
              "Volume ${volumeOn ? "ON" : "OFF"} activated! Enjoy your peace and quiet.",
          createdAt: DateTime.now(),
        ),
      );
    } catch (e) {
      appToast(masg: "$e", isEror: true);
      print(e);
    }
  }

  checkPermission() async {
    bool isAccessGranted = await FlutterMute.isNotificationPolicyAccessGranted;

    if (!isAccessGranted) {
      // Opens the notification settings to grant the access.
      await FlutterMute.openNotificationPolicySettings();
    }
  }

  //   allUpdate() async {
  //   RingerModeStatus ringerStatus = await SoundMode.ringerModeStatus;
  //   print("ringerStatus: $ringerStatus");

  //   try {
  //     // var status = await Permission.notification.request();
  //     // if (status.isDenied) {
  //     //   // The user denied the permission
  //     //   print('Do Not Disturb permission denied');
  //     // } else if (status.isGranted) {
  //     //   // The user granted the permission
  //     //   print('Do Not Disturb permission granted');
  //     //   // Now you can change the sound mode
  //     //   // Example: await SoundMode.setSoundMode(RingerModeStatus.vibrate);
  //     // }
  //     // await SoundMode.setSoundMode(RingerModeStatus.normal);

  //     bool isAccessGranted =
  //         await FlutterMute.isNotificationPolicyAccessGranted;

  //     if (!isAccessGranted) {
  //       // Opens the notification settings to grant the access.
  //       await FlutterMute.openNotificationPolicySettings();
  //     }

  //     // FlutterDnd.gotoPolicySettings();

  //     // await FlutterMute.setRingerMode(RingerMode.Normal);

  //     await FlutterDnd.setInterruptionFilter(
  //         FlutterDnd.INTERRUPTION_FILTER_NONE);

  //     //Volumne
  //     // PerfectVolumeControl.setVolume(0.0);
  //     // PerfectVolumeControl.hideUI = true;

  //     // var vol = await PerfectVolumeControl.volume;
  //     // print('vol: ${vol}');

  //     // PerfectVolumeControl.stream.listen((volume) {
  //     //   print('volume: ${volume}');
  //     //   // Handle volume change
  //     // });

  //     // Speaker
  //   } catch (e) {
  //     print('setSoundMode ${e}');
  //   }
  // }
}

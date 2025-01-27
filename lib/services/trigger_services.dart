// ignore_for_file: prefer_conditional_assignment, unnecessary_null_comparison

import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silenttime/models/triger_model.dart';
import 'package:silenttime/services/get_distance.dart';
import 'package:silenttime/services/shared_preference_service.dart';
import 'package:silenttime/services/sound_services.dart';

import '../controllers/switchbutton_controller.dart';

class TriggerServices {
  initTriggerMethods() async {
    var currentTime = getCurrentTime();
    log('currentTime: $currentTime');
    SwitchButtonController switcherController =
        Get.put(SwitchButtonController());

    List<TriggerModel> triggerList = await SharedPreferenceService.getTriggers();
    print(
        "switcherController.pressedBool.value: ${switcherController.pressedBool.value}");

    // Check and Call the Methods
    if (switcherController.pressedBool.value) {
      for (var trigger in triggerList) {
        log("${trigger.trigerTitle.toString()} :  ${trigger.trigerAction.toString()} | ${trigger.trigerFromTimeHour}:${trigger.trigerFromTimeMint} | ${trigger.trigerToTimeHour}:${trigger.trigerToTimeMint} | ${trigger.trigerStatus} | ${trigger.isTriggered} ");
        if (trigger.trigerStatus == true) {
          processTriggers(trigger);
        }
      }
    } else {
      log("Triggers Switch OFF.......!");
    }

    // var jsonString = prefs.getString("triggers");
    // if (jsonString != null) {
    //   Iterable iterable = json.decode(jsonString);
    //   List<TriggerModel> trigerList = List<TriggerModel>.from(
    //       iterable.map((model) => TriggerModel.fromJson(model)));
    //   print(
    //       "switcherController.pressedBool.value: ${switcherController.pressedBool.value}");
    //
    //   // Check and Call the Methods
    //   if (switcherController.pressedBool.value) {
    //     for (var triger in trigerList) {
    //       log("${triger.trigerTitle.toString()} :  ${triger.trigerAction.toString()} | ${triger.trigerFromTimeHour}:${triger.trigerFromTimeMint} | ${triger.trigerToTimeHour}:${triger.trigerToTimeMint} | ${triger.trigerStatus} | ${triger.isTriggered} ");
    //       if (triger.trigerStatus == true) {
    //         processTriggers(triger);
    //       }
    //     }
    //   } else {
    //     log("Triggers Swtch OFF.......!");
    //   }
    // }
  }

  void processTriggers(TriggerModel triger) {
    switch (triger.trigerTitle.toString()) {
      case 'Location Trigger':
        locationTrigger(triger);
        break;
      case 'Geofence Trigger':
        geofenceTrigger(triger);
        break;
      case 'Day/Time Trigger':
        dayTimeTrigger(triger);
        break;
      case 'Day of Week/Month':
        dayOFWeekMonthTrigger(triger);
        break;
      case 'Regular Interval':
        regularTimeTrigger(triger);
        break;
      default:
        null;
    }
  }

  locationTrigger(TriggerModel triger) async {
    print('locationTrigger________________________________');
    Map<String, double> location = await SharedPreferenceService.getLocation();
    LatLng currentLatlng = LatLng(location["lat"]!, location["long"]!);
    LatLng destiLatlng = LatLng(double.parse(triger.locationLat.toString()),
                                double.parse(triger.locationLong.toString()));
    var distance = await calculateDistanceInMeters(currentLatlng, destiLatlng);
    print('currentLatlng: $currentLatlng');
    print('distance: $distance');

    double radius = double.parse(triger.zoneRadious.toString());
    print('radius: $radius');

    if (distance < radius && triger.isTriggered == false) {
      processMethods(triger, triger.trigerAction.toString());
    } else if (distance > radius && triger.isTriggered == true) {
      processMethods(triger, "");
    }
  }

  geofenceTrigger(TriggerModel triger) async {
    print('geofenceTrigger ________________________________');

    SharedPreferences pref = await SharedPreferences.getInstance();
    var lat = pref.getDouble("lat") ?? 0.0;
    var long = pref.getDouble("long") ?? 0.0;
    LatLng currentLatlng = LatLng(lat, long);
    LatLng destiLatlng = LatLng(double.parse(triger.locationLat.toString()),
        double.parse(triger.locationLong.toString()));

    var distance = await calculateDistanceInMeters(currentLatlng, destiLatlng);
    print('distance: $distance');

    double radius = double.parse(triger.zoneRadious.toString());
    print('radius: $radius');

    if (triger.areaEntered == true) {
      if (distance < radius && triger.isTriggered == false) {
        processMethods(triger, triger.trigerAction.toString());
      } else if (distance > radius && triger.isTriggered == true) {
        processMethods(triger, "");
      }
    } else {
      if (distance > radius && triger.isTriggered == false) {
        processMethods(triger, triger.trigerAction.toString());
      } else if (distance < radius && triger.isTriggered == true) {
        processMethods(triger, "");
      }
    }
  }

  dayTimeTrigger(TriggerModel triger) {
    print(
        'dayTimeTrigger.: ___________ ${triger.trigerAction}_____________________${triger.trigerDayName}');

    var currentTime = getCurrentTime();
    var triggerStartTime =
        "${triger.trigerFromTimeHour}:${triger.trigerFromTimeMint}:00";
    var triggerEndTime =
        "${triger.trigerToTimeHour}:${triger.trigerToTimeMint}:00";
    String currentDayName = getCurrentDayName();
    log('currentTime: $currentTime');
    log('triggerStartTime: $triggerStartTime');

    if (triger.trigerDayName!.contains(currentDayName)) {
      if (currentTime == triggerStartTime && triger.isTriggered == false) {
        processMethods(triger, triger.trigerAction.toString());
      } else if (currentTime == triggerEndTime) {
        processMethods(triger, "");
      }
    }
  }

  dayOFWeekMonthTrigger(TriggerModel triger) {
    print(
        'dayOFWeekMonthTrigger __________${triger.trigerDayNumber}${triger.trigerMonthName!}______________________');

    DateTime now = DateTime.now();
    int currentDay = now.day;
    String currentMonth = DateFormat('MMMM').format(now);
    print("currentDay: $currentDay");
    print('currentMonth: $currentMonth');

    var currentTime = getCurrentTime();
    var triggerStartTime =
        "${triger.trigerFromTimeHour}:${triger.trigerFromTimeMint}:00";
    var triggerEndTime =
        "${triger.trigerToTimeHour}:${triger.trigerToTimeMint}:00";

    if (currentDay == triger.trigerDayNumber &&
        currentMonth.toLowerCase() == triger.trigerMonthName!.toLowerCase()) {
      if (currentTime == triggerStartTime && triger.isTriggered == false) {
        processMethods(triger, triger.trigerAction.toString());
      } else if (currentTime == triggerEndTime) {
        processMethods(triger, "");
      }
    }
  }

  regularTimeTrigger(TriggerModel triger) {
    print(
        'regularTimeTrigger ___________________${triger.trigerHours}:${triger.trigerMinutes}:${triger.trigerSeconds}');

    var currentTime = getCurrentTime();
    var triggerStartTime =
        "${triger.trigerFromTimeHour}:${triger.trigerFromTimeMint}:00";
    var triggerEndTime =
        "${triger.trigerToTimeHour}:${triger.trigerToTimeMint}:00";

    Timer? timer;

    if (currentTime == triggerStartTime) {
      print("Timer: $timer");
      if (timer == null && triger.isTriggered == false) {
        processMethods(triger, triger.trigerAction.toString());
        timer = Timer.periodic(
            Duration(
              hours: triger.trigerHours ?? 0,
              minutes: triger.trigerMinutes ?? 0,
              seconds: triger.trigerSeconds ?? 0,
            ), (timer) {
          processMethods(triger, triger.trigerAction.toString());
        });
      }
    } else if (currentTime == triggerEndTime) {
      processMethods(triger, "");

      if (timer != null) {
        timer.cancel();
      }
    }
  }

  void processMethods(
    TriggerModel trigger,
    String value,
  ) {
    if (value == "") {
      saveIsTriggerTrue(trigger, false);
    } else {
      saveIsTriggerTrue(trigger, true);
    }
    switch (value) {
      case 'Do-Not-Disturb':
        SoundServices().doNotDistrpDevice();
        break;
      case 'Silent':
        SoundServices().silentDevice();
        break;
      case 'Speaker-ON/OFF':
        SoundServices().volumeOnOFFDevice(volumeOn: false);
        break;
      case 'Vibrate-Enable/Disable':
        SoundServices().vibarationDevice();
        break;
      case 'Volume-Change':
        SoundServices().volumeChangeDevice();
        break;
      case 'Volume-Up-Down':
        SoundServices().volumeChangeDevice();
        break;
      default:
        SoundServices().normalDevice();
    }
  }

  String getCurrentTime() {
    DateTime dateTime = DateTime.now();

    String formattedHour = DateFormat('HH').format(dateTime);
    String formattedMinute = DateFormat('mm').format(dateTime);
    String formattedSec = DateFormat('ss').format(dateTime);
    var hour;
    var mint;
    if (formattedHour.startsWith('0')) {
      hour = formattedHour.substring(1); // Remove leading zero
    } else {
      hour = formattedHour;
    }

    if (formattedMinute.startsWith('0')) {
      mint = formattedMinute.substring(1); // Remove leading zero
    } else {
      mint = formattedMinute;
    }

    // Combine the formatted hour and minute
    return '$hour:$mint:$formattedSec';
  }

  String getCurrentDayName() {
    DateTime now = DateTime.now();
    DateFormat format = DateFormat(
        'E'); // 'E' is for the abbreviated name of the day (e.g., Mon)
    String dayName = format.format(now);
    return dayName;
  }

  saveIsTriggerTrue(TriggerModel triger, isTriggered) async {
    List<TriggerModel> triggerList = await SharedPreferenceService.getTriggers();
    triggerList
        .where((e) =>
            e.trigerTitle == triger.trigerTitle &&
            e.trigerFromTimeHour == triger.trigerFromTimeHour &&
            e.trigerFromTimeMint == triger.trigerFromTimeMint)
        .forEach((element) {
      element.isTriggered = isTriggered;
      log('element.isTriggered: ${element.isTriggered}');
    });
    List jsonList = triggerList.map((trigger) => trigger.toJson()).toList();
    await SharedPreferenceService.setTriggerValue(jsonList);
  }
}

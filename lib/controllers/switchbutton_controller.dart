import 'dart:async';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:silenttime/models/triger_model.dart';
import 'package:silenttime/screens/my_rules/controller/myrules_controller.dart';
import 'package:silenttime/services/background_location_services.dart';
import 'package:silenttime/services/background_services.dart';
import 'package:silenttime/services/shared_preference_service.dart';
import 'package:silenttime/utils/toast.dart';

class SwitchButtonController extends GetxController {
  RxBool pressedBool = true.obs;
  final service = FlutterBackgroundService();

  FutureOr<void> changeStatus(bool value) async {
    MyRulesController myRulesController = Get.put(MyRulesController());

    // pressedBool.value = value;
    // // await initializeBgService();
    // reStartBGServices();

    // if (myRulesController.isPermissionEnabled.value) {
    //   myRulesController.startLocationTmer();
    // }

    if (value == false) {
      stopServices();
    } else {
      var triggers = await checkTriggerIsEmpty();
      print('triggers: $triggers');

      if (triggers == false) {
        pressedBool.value = true;

        if (myRulesController.isPermissionEnabled.value) {
          myRulesController.startLocationTimer();
        }
        await BackgroundLocationService().getCurrentLocation();

        await initializeBgService();

        service.startService();
      } else {
        AppToast.infoToast("Kindly add at least 1 trigger to start");
      }
    }
  }

  checkTriggerIsEmpty() async {
    List<TriggerModel> triggerModelList = await SharedPreferenceService.getTriggers();
    if (triggerModelList.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  FutureOr<void> checkStatus() async {
    var isRunning = await service.isRunning();
    if (isRunning) {
      pressedBool.value = true;
    } else {
      pressedBool.value = false;
    }
    update();
  }

  stopServices() {
    stopBGServices();
    pressedBool.value = false;
    update();
  }
}

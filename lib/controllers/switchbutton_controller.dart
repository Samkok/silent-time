import 'dart:async';
import 'dart:convert';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silenttime/models/triger_model.dart';
import 'package:silenttime/screens/my_rules/controller/myrules_controller.dart';
import 'package:silenttime/screens/my_rules/pages/location_picker.dart';
import 'package:silenttime/services/background_location_services.dart';
import 'package:silenttime/services/background_services.dart';
import 'package:silenttime/utils/toast.dart';

class SwitchButtonController extends GetxController {
  RxBool pressedBool = true.obs;
  final service = FlutterBackgroundService();

  Future<void> changeStatus(bool value) async {
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
      var triggers = await checkTriggerisEmpty();
      print('triggers: ${triggers}');

      if (triggers == false) {
        pressedBool.value = true;

        if (myRulesController.isPermissionEnabled.value) {
          myRulesController.startLocationTmer();
        }
        await BackgroundLocationService().getCurrentLocationm();

        await initializeBgService();

        service.startService();
      } else {
        AppToast.infoToast("Kindly add at least 1 trigger to start");
      }
    }
  }

  checkTriggerisEmpty() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var jsonString = prefs.getString("triggers");
    if (jsonString != null) {
      Iterable iterable = json.decode(jsonString);
      List<TrigerModel> trigerModelList = List<TrigerModel>.from(
          iterable.map((model) => TrigerModel.fromJson(model)));

      if (trigerModelList.isEmpty) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  Future<void> checkStatus() async {
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

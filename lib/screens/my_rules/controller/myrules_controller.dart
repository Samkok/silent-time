import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_mute/flutter_mute.dart';
import 'package:get/get.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silenttime/services/background_location_services.dart';
import 'package:silenttime/services/background_services.dart';
import 'package:silenttime/utils/toast.dart';
import '../../../controllers/switchbutton_controller.dart';
import '../../../models/triger_model.dart';

class MyRulesController extends GetxController {
  // SwitchButtonController switcherController = Get.put(SwitchButtonController());
  RxInt tabVal = 0.obs;
  RxBool areaEntered = true.obs;
  RxBool areaExit = false.obs;
  RxBool previousLocation = true.obs;
  RxBool step1 = true.obs;
  RxBool step2 = false.obs;
  RxBool step3 = false.obs;
  RxBool selectedTrigger = false.obs;

  // Trigger params
  RxBool mon = false.obs;
  RxBool tue = false.obs;
  RxBool wed = false.obs;
  RxBool thru = false.obs;
  RxBool fri = false.obs;
  RxBool sat = false.obs;
  RxBool sun = false.obs;

  clearDaysName() {
    mon.value = false;
    tue.value = false;
    wed.value = false;
    thru.value = false;
    fri.value = false;
    sat.value = false;
    sun.value = false;
    selectedDayName.clear();
    update();
  }

  TimeOfDay fromTime = const TimeOfDay(hour: 7, minute: 15);
  TimeOfDay toTime = const TimeOfDay(hour: 7, minute: 15);

  RxInt selectedDay = 1.obs;
  RxString selectedMonth = "".obs;
  // RxString selectedDayName = "".obs;
  RxList selectedDayName = <String>[''].obs;
  Rx<DateTime> myDateTime = DateTime.now().obs;
  RxInt hours = 0.obs;
  RxInt minutes = 0.obs;
  RxInt seconds = 0.obs;
  RxString selectAMPM = ''.obs;
  RxString showRuledpopUp = 'default'.obs;
  RxString trigerName = ''.obs;
  RxString trigerTitle = ''.obs;
  RxString trigerAction = 'Do-Not-Disturb'.obs;
  RxBool trigerState = false.obs;

  RxInt actionButtonNum = 0.obs;
  RxInt rulePopupWhenLounch = 0.obs;
  RxString locationName = ''.obs;
  RxString locationLat = ''.obs;
  RxString locationLong = ''.obs;

  RxInt updateTabNumber = 1.obs;
  RxBool updateStep1 = true.obs;
  RxBool updateStep2 = false.obs;
  RxBool updateStep3 = false.obs;

  TriggerModel? trigerModelSaveIndex;
  int indexVal = 0;
  RxBool locationPickerClick = false.obs;

  TextEditingController zoneNameController = TextEditingController();
  TextEditingController zoneRadiousController = TextEditingController();
  TextEditingController myTextController = TextEditingController();
  TextEditingController ruleNameController = TextEditingController();

  RxDouble circleRadius = 0.0.obs;

  checkAndStopServices() {
    SwitchButtonController switchButtonController =
        Get.put(SwitchButtonController());
    if (trigerModelList.isEmpty) {
      switchButtonController.stopServices();
    }
  }

  allTrigerOnOFF(bool val) {
    update();
    for (var ele in trigerModelList) {
      ele.trigerStatus = val;
    }

    saveTriggers();
    update();
  }

  locationPickerClickUpdate(bool val) {
    locationPickerClick.value = val;
    update();
  }

  circleRadiusUpdate(val) {
    circleRadius.value = val;
    update();
  }

  disposeThins() {
    step1.value = true;
    step2.value = false;
    step3.value = false;
    changeTabVal(0);
    // selectedDayName.clear();
    clearDaysName();
    ruleNameController.clear();
    locationName.value = "";
    minutes.value = 0;
    hours.value = 0;
    seconds.value = 0;

    update();
  }

  updateMasterFun(
    TriggerModel indexModel,
    indVal,
  ) {
    trigerModelSaveIndex = indexModel;
    log('triggerModelSaveIndex.........: ${trigerModelSaveIndex!.trigerDayName}');
    indexVal = indVal;
    trigerTitle.value = trigerModelSaveIndex!.trigerTitle!;
    if (trigerTitle.value == "Day/Time Trigger") {
      updateDayTimeTriggerFunction(trigerModelSaveIndex!);
    } else if (trigerTitle.value == "Day of Week/Month") {
      updateDayofWeekMonth(trigerModelSaveIndex!);
    } else if (trigerTitle.value == "Regular Interval") {
      updateRegularInterval(trigerModelSaveIndex!);
    } else if (trigerTitle.value == "Location Trigger") {
      updateLocationTrigger(trigerModelSaveIndex!);
    } else {
      log('Its else ');
    }

    //  Update Triger Action
    updateAction(trigerModelSaveIndex!.trigerActionButtonNumber!);

    //  Update Triger Action
    updateRule(trigerModelSaveIndex!.rulePopupWhenLounch!,
        trigerModelSaveIndex!.trigerRuleName!);

    // restart services
    reStartBGServices();
  }

  setDefaultStartAndEndTime() {
    DateTime dateTime = DateTime.now();
    String formattedHour = DateFormat('h').format(dateTime);
    DateFormat('m').format(dateTime);
    fromTime = TimeOfDay(
        hour: int.parse(formattedHour), minute: int.parse(formattedHour));
    toTime = TimeOfDay(
        hour: int.parse(formattedHour) + 1, minute: int.parse(formattedHour));
    update();
  }

//  Update Location Triger
  updateLocationTrigger(TriggerModel trigInd) {
    zoneRadiousController.text = trigInd.zoneRadious.toString();
    zoneNameController.text = trigInd.zoneName!;
    locationName.value = trigInd.locationName!;
    locationLat.value = trigInd.locationLat!;
    locationLong.value = trigInd.locationLong!;
  }

  updateDayTimeTriggerFunction(
    TriggerModel trigInd,
  ) {
    log("updateDayTimeTrigerFunction...................}");
    fromTime = TimeOfDay(
      hour: int.parse(trigInd.trigerFromTimeHour!),
      minute: int.parse(trigInd.trigerFromTimeMint!),
    );
    toTime = TimeOfDay(
      hour: int.parse(trigInd.trigerToTimeHour!),
      minute: int.parse(trigInd.trigerToTimeMint!),
    );

    for (var dayName in trigInd.trigerDayName!) {
      log(dayName.toString());
      if (dayName == 'Mon') {
        mon.value = true;
        print("$dayName  selected");
        update();
      } else if (dayName == 'Tue') {
        tue.value = true;
        update();
      } else if (dayName == 'Wed') {
        wed.value = true;
        update();
      } else if (dayName == 'Thu') {
        thru.value = true;
        update();
      } else if (dayName == 'Fri') {
        fri.value = true;
        update();
      } else if (dayName == 'Sat') {
        sat.value = true;
        update();
      } else if (dayName == 'Sun') {
        sun.value = true;
        update();
      } else {
        sun.value = true;
        update();
      }
      selectedDayName.add(dayName);

      update();
    }

    print("Methid.........${mon.value}");
  }

  selectTheLastDay(trigerDayNameList) {
    selectedDayName.clear();

    for (var dayName in trigerDayNameList) {
      log(dayName.toString());
      if (dayName == 'Mon') {
        mon.value = true;
        print("$dayName  selected");
        update();
      } else if (dayName == 'Tue') {
        tue.value = true;
        update();
      } else if (dayName == 'Wed') {
        wed.value = true;
        update();
      } else if (dayName == 'Thu') {
        thru.value = true;
        update();
      } else if (dayName == 'Fri') {
        fri.value = true;
        update();
      } else if (dayName == 'Sat') {
        sat.value = true;
        update();
      } else if (dayName == 'Sun') {
        sun.value = true;
        update();
      } else {
        sun.value = true;
        update();
      }
      selectedDayName.add(dayName);

      update();
    }
  }

  updateTrigerFun(int tabNum) {
    updateTabNumber.value = tabNum;
    if (tabNum == 1) {
      updateStep1.value = true;
      updateStep2.value = false;
      updateStep3.value = false;
    } else if (tabNum == 2) {
      updateStep1.value = false;
      updateStep2.value = true;
      updateStep3.value = false;
    } else if (tabNum == 3) {
      updateStep1.value = false;
      updateStep2.value = false;
      updateStep3.value = true;
    } else {
      updateStep1.value = true;
      updateStep2.value = false;
      updateStep3.value = false;
    }

    update();
  }

  //Udated  triger Steps
  updateTrigerSteps(int tabValue) {
    if (tabValue == 0) {
      tabVal.value = tabValue;
      step1.value = true;
      step2.value = false;
      step3.value = false;
    } else if (tabValue == 1) {
      tabVal.value = tabValue;
      step1.value = false;
      step2.value = true;
      step3.value = false;
    } else if (tabValue == 2) {
      tabVal.value = tabValue;
      step1.value = false;
      step2.value = false;
      step3.value = true;
    } else {
      tabVal.value = 0;
      step1.value = false;
      step2.value = false;
      step3.value = true;
    }
    update();
  }

  updatecheckActionFun(int tabNum) {
    updateTabNumber.value = tabNum;
    if (tabNum == 1) {
      updateStep1.value = true;
      updateStep2.value = false;
      updateStep3.value = false;
    } else if (tabNum == 2) {
      updateStep1.value = false;
      updateStep2.value = true;
      updateStep3.value = false;
    } else if (tabNum == 3) {
      updateStep1.value = false;
      updateStep2.value = false;
      updateStep3.value = true;
    } else {
      updateStep1.value = true;
      updateStep2.value = false;
      updateStep3.value = false;
    }

    update();
  }

  //Udated  check days in list
  checkDayinList(List dayList) {
    for (var dayName in dayList) {
      if (dayName == 'M') {
        mon.value = true;
      } else if (dayName == 'T') {
        tue.value = true;
      } else if (dayName == 'W') {
        wed.value = true;
      } else if (dayName == 'TH') {
        thru.value = true;
      } else if (dayName == 'F') {
        fri.value = true;
      } else if (dayName == 'SA') {
        sat.value = true;
      } else if (dayName == 'SU') {
        sun.value = true;
      } else {
        sun.value = true;
      }
    }
  }

  //Udated  trigerAction
  updateAction(int actionNumber) {
    log('Action Number ===========$actionNumber');

    if (actionNumber == 1) {
      trigerAction.value = "Silent";
      actionButtonNum.value = actionNumber;
    } else if (actionNumber == 0) {
      trigerAction.value = "Do-Not-Disturb";
      actionButtonNum.value = actionNumber;
    } else if (actionNumber == 2) {
      trigerAction.value = "Speaker-ON/OFF";
      actionButtonNum.value = actionNumber;
    } else if (actionNumber == 3) {
      trigerAction.value = "Vibrate-Enable/Disable";
      actionButtonNum.value = actionNumber;
    } else if (actionNumber == 4) {
      trigerAction.value = "Volume-Change";
      actionButtonNum.value = actionNumber;
    } else if (actionNumber == 5) {
      trigerAction.value = "Volume up/ down";
      actionButtonNum.value = actionNumber;
    } else {
      trigerAction.value = "Do-Not-Disturb";
      actionButtonNum.value = actionNumber;
    }
    update();
  }

// Update  Rule
  updateRule(int popUpVal, String rulevalue) {
    ruleNameController.text = rulevalue;
    if (popUpVal == 0) {
      rulePopupWhenLounch.value = 0;
    } else if (popUpVal == 1) {
      rulePopupWhenLounch.value = 1;
    } else if (popUpVal == 2) {
      rulePopupWhenLounch.value = 2;
    } else {
      rulePopupWhenLounch.value = 0;
    }
  }

//Update Date of Week Month
  updateDayofWeekMonth(TriggerModel trigMod) {
    fromTime = TimeOfDay(
      hour: int.parse(trigMod.trigerFromTimeHour!),
      minute: int.parse(trigMod.trigerFromTimeMint!),
    );
    toTime = TimeOfDay(
      hour: int.parse(trigMod.trigerToTimeHour!),
      minute: int.parse(trigMod.trigerToTimeMint!),
    );
    selectedMonth.value = trigMod.trigerMonthName!;
    selectedDay.value = trigMod.trigerDayNumber!;
  }

  //Update  Regular interval
  updateRegularInterval(TriggerModel trigMod) {
    fromTime = TimeOfDay(
      hour: int.parse(trigMod.trigerFromTimeHour!),
      minute: int.parse(trigMod.trigerFromTimeMint!),
    );
    toTime = TimeOfDay(
      hour: int.parse(trigMod.trigerToTimeHour!),
      minute: int.parse(trigMod.trigerToTimeMint!),
    );
    hours.value = trigMod.trigerHours!;
    minutes.value = trigMod.trigerMinutes!;
    seconds.value = trigMod.trigerSeconds!;
  }

  // Update Location Detail
  void updateLocationDetail(PickResult val) {
    locationName.value = val.formattedAddress.toString();
    locationLat.value = val.geometry!.location.lat.toString();
    locationLong.value = val.geometry!.location.lng.toString();

    log(locationName.value);
    update();
  }

  // Save Triger Action
  void saveTrigerAction(String val) {
    trigerAction.value = val;
    log(trigerAction.value);
    update();
  }

// Save Triger Title
  void saveTrigerTitle(String val) {
    trigerTitle.value = val;
    log('Title ${trigerTitle.value}');
    update();
  }

//  Save Days Name List
  void saveDayName(items) {
    selectedDayName.add(items);
    log("$items : ${selectedDayName.toString()}");
    update();
  }

  void removeDayName(items) {
    selectedDayName.removeWhere((i) => i == items);
    log("$items : ${selectedDayName.toString()}");
    update();
  }

// Action Button Number
  changeActionNumber(value) {
    log(' Action Button Number === $value');
    actionButtonNum.value = value;
    update();
  }

// Rule Popup Number
  rulePopupNumber(value) {
    rulePopupWhenLounch.value = value;
    log(rulePopupWhenLounch.value.toString());
    update();
  }

  updateHMS(RxInt name, value) {
    name.value = value;
    update();
  }

  updateSelectedDay(val) {
    selectedDay.value = val;
    update();
  }

  updateSelectedMonth(val) {
    selectedMonth.value = val;
    update();
  }

  RxInt selectedMonthVal = 1.obs;
  updateselectedMonthVal(val) {
    selectedMonthVal.value = val;
    update();
  }

  updateFromTime(val) {
    fromTime = val;

    update();
  }

  updateToTime(val) {
    toTime = val;
    print('toTime.hour: ${toTime.hour}');
    print('from.hour: ${fromTime.hour}');

    if (toTime.hour <= fromTime.hour) {
      if (toTime.minute < fromTime.minute) {
        AppToast.infoToast("To Time Must be greater then From Time");
      }
    }
    update();
  }

  void changeTabVal(int val) {
    print('val: ${val}');
    tabVal.value = val;

    if (tabVal.value == 1) {
      trigerFiilterList = trigerModelList
          .where((element) => element.trigerStatus == true)
          .toList();
    } else if (tabVal.value == 2) {
      trigerFiilterList = trigerModelList
          .where((element) => element.trigerStatus == false)
          .toList();
    } else {
      trigerFiilterList = trigerModelList;
    }
    update();
  }

  void areaEnteredStatus() {
    areaEntered.toggle();
    update();
  }

  void areaExitStatus() {
    areaExit.toggle();
    update();
  }

  void previousLocationStatus() {
    previousLocation.toggle();
    update();
  }

  void setup1Status() {
    step1.toggle();
    update();
  }

  void setup2Status() {
    step2.toggle();
    update();
  }

  void setup3Status() {
    step3.toggle();
    update();
  }

  RxBool isPermissionEnabled = false.obs;

  // Location Permission
  checkPermission() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    bool isAccessGranted = await FlutterMute.isNotificationPolicyAccessGranted;

    final location = await Permission.location.request();
    if (location.isDenied) {
      await openAppSettings();
    }
    final statusnotification = await Permission.notification.request();
    if (statusnotification.isPermanentlyDenied) {
      await openAppSettings();
    }

    loc.Location locat = new loc.Location();

    bool _serviceEnabled;

    _serviceEnabled = await locat.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await locat.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    print('isAccessGranted: ${isAccessGranted}');
    print('_serviceEnabled: ${_serviceEnabled}');

    print('location.isGranted: ${location.isGranted}');
    print('statusnotification.isGranted: ${statusnotification.isGranted}');

    if (isAccessGranted == true &&
        _serviceEnabled &&
        location.isGranted &&
        statusnotification.isGranted) {
      isPermissionEnabled.value = true;
    } else {
      isPermissionEnabled.value = false;
    }
    pref.setBool('permission', isPermissionEnabled.value);
    update();
  }

  updateIsPermissionEnabled(v) {
    isPermissionEnabled.value = v;
    update();
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  FocusNode titleFocus = FocusNode();
  FocusNode descriptionFocus = FocusNode();
  List<TriggerModel> trigerModelList = [];
  List<TriggerModel> trigerFiilterList = [];

  final triggerKey = "triggers";

  FutureOr<void> saveTriggers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List jsonList = trigerModelList.map((trigger) => trigger.toJson()).toList();
    await prefs.setString(triggerKey, json.encode(jsonList));
    reStartBGServices();

    if (isPermissionEnabled.value && timer == null) {
      startLocationTimer();
    }
    update();
  }

  FutureOr<void> updateTriggers(TriggerModel triger) async {
    log("indexVal----$indexVal");
    // log('trigerModelList   length  Before= ${trigerModelList.length} ');
    trigerModelList.removeAt(indexVal);
    update();
    // log('trigerModelList   length After = ${trigerModelList.length} ');
    log("Update   2..................${triger.trigerDayName}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    trigerModelList.add(triger);
    log('trigerModelList   length  After Add= ${trigerModelList.length} ');

    await prefs.setString(triggerKey, json.encode(trigerModelList));
    getAllTriggers();
    reStartBGServices();

    update();
  }

  FutureOr<void> getAllTriggers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var jsonString = prefs.getString(triggerKey);
    if (jsonString != null) {
      Iterable iterable = json.decode(jsonString);
      trigerModelList = List<TriggerModel>.from(
          iterable.map((model) => TriggerModel.fromJson(model)));
    }
    update();
  }

  FutureOr<void> deleteTrigger(index) async {
    trigerModelList.removeAt(index);
    await saveTriggers();
    // Future.delayed(Duration(milliseconds: 500), () async {
    //   checkAndStopServices();
    // });
    update();
  }

  Timer? timer;

  startLocationTimer() {
    // Timer for location
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      BackgroundLocationService().getCurrentLocation();
    });
  }

  stopLocationTimer() {
    if (timer != null) {
      timer!.cancel();
    }
  }

  trigerStatusUpdate(i) async {
    print(
        "${trigerModelList[i].trigerTitle} : ${trigerModelList[i].trigerStatus}");
    print('i: ${i}');
    if (trigerModelList[i].trigerStatus == true) {
      trigerModelList[i].trigerStatus = false;
    } else {
      trigerModelList[i].trigerStatus = true;
    }
    update();
    print(
        "${trigerModelList[i].trigerTitle} : ${trigerModelList[i].trigerStatus}");

    // if (trigerModelList.length == 1) {
    //   SwitchButtonController switchButtonController =
    //       Get.put(SwitchButtonController());
    //   switchButtonController.pressedBool.value =
    //       trigerModelList[i].trigerStatus!;
    // }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(triggerKey, json.encode(trigerModelList));
    update();
    reStartBGServices();
  }
}

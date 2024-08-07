import 'package:get/get.dart';

class SettinsController extends GetxController {
  RxBool cameraBool = true.obs;
  RxBool storageBool = true.obs;
  RxBool locationBool = true.obs;
  RxBool microphoneBool = true.obs;
  RxBool contactsBool = true.obs;
  RxBool phoneBool = true.obs;
  RxBool messageBool = true.obs;

  void changeCameraStatus() {
    cameraBool.toggle();
    update();
  }

  void changeStorageStatus() {
    storageBool.toggle();
    update();
  }

  void changeLocationBoolStatus() {
    locationBool.toggle();
    update();
  }

  void changeMicrophoneStatus() {
    microphoneBool.toggle();
    update();
  }

  void changeContactsBoolStatus() {
    contactsBool.toggle();
    update();
  }

  void changePhoneBoolStatus() {
    phoneBool.toggle();
    update();
  }

  void changeMessageBoolStatus() {
    messageBool.toggle();
    update();
  }
}

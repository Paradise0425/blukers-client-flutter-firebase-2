import 'package:get/get.dart';

class NotificationControllerU extends GetxController implements GetxService {
  RxBool isSwitchedSound = true.obs;
  RxBool isSwitchedVibrate = true.obs;
  RxBool isSwitchedTips = false.obs;
  RxBool isSwitchedService = false.obs;

  onchangeSound(value) {
    isSwitchedSound.value = value;
    update();
  }

  onchangeVibrate(value) {
    isSwitchedVibrate.value = value;
    update();
  }

  onchangeTips(value) {
    isSwitchedTips.value = value;
    update();
  }

  onchangeService(value) {
    isSwitchedService.value = value;
    update();
  }
}

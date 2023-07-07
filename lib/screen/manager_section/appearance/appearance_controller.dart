import 'package:get/get.dart';

class AppearanceControllerM extends GetxController implements GetxService {
  RxBool isSwitchedDarkMode = false.obs;
  RxBool isSwitchedBlurBackground = true.obs;
  RxBool isSwitchedFullScreenMode = true.obs;

  onchangeDarkMode(value) {
    isSwitchedDarkMode.value = value;
    update();
  }

  onchangeBackground(value) {
    isSwitchedBlurBackground.value = value;
    update();
  }

  onchangeFullScreenMode(value) {
    isSwitchedFullScreenMode.value = value;
    update();
  }
}

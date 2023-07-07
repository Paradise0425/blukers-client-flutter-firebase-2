import 'package:get/get.dart';

class SecurityController extends GetxController implements GetxService {
  RxBool isSwitchedFace = true.obs;
  RxBool isSwitchedRemember = true.obs;
  RxBool isSwitchedTouch = false.obs;

  onchangeFace(value) {
    isSwitchedFace.value = value;
    update();
  }

  onchangeRemember(value) {
    isSwitchedRemember.value = value;
    update();
  }

  onchangeTouch(value) {
    isSwitchedTouch.value = value;
    update();
  }
}

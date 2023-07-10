import 'package:get/get.dart';
import 'package:blukers_client_app/utils/app_res.dart';

import 'package:blukers_client_app/screen/intro/introducation_screen.dart';
import 'package:blukers_client_app/screen/manager_section/intro/introducation_screen.dart';

class LookingForYouIntroScreenController extends GetxController
    implements GetxService {
  RxBool isJob = false.obs;
  RxBool isEmployee = true.obs;
  onChangeWantJobChoice() {
    isJob.value = true;
    isEmployee.value = false;
    // Get.toNamed(AppRes.firstScreen);
    // Get.toNamed(AppRes.firstPageScreenM);
    Get.toNamed(AppRes.introScreen);
  }

  onChangeEmployeeChoice() {
    isJob.value = false;
    isEmployee.value = true;
    // Get.toNamed(AppRes.firstScreen);
    // Get.toNamed(AppRes.firstPageScreenM);
    Get.toNamed(AppRes.introScreenM);
  }
}

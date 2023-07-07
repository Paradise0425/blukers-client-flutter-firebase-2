import 'package:get/get.dart';
import 'package:blukers_client_app/utils/app_res.dart';

class LookingForYouScreenController extends GetxController
    implements GetxService {
  RxBool isJob = false.obs;
  RxBool isEmployee = true.obs;
  onChangeWantJobChoice() {
    isJob.value = true;
    isEmployee.value = false;
    Get.toNamed(AppRes.firstScreen);
  }

  onChangeEmployeeChoice() {
    isJob.value = false;
    isEmployee.value = true;
    Get.toNamed(AppRes.firstPageScreenM);
  }
}

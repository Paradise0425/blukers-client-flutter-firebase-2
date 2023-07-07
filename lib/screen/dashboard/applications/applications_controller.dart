import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ApplicationsController extends GetxController {
  TextEditingController searchController = TextEditingController();

  RxInt selectedJobs = 0.obs;
  RxList jobs = ["all".tr, "accepted".tr, "interview".tr, "sent".tr].obs;

  onTapJobs2(int index) {
    selectedJobs.value = index;
    //update(["List"]);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/utils/asset_res.dart';

class JobRecommendationController extends GetxController
    implements GetxService {
  TextEditingController searchController = TextEditingController();
  RxList jobTypes = [
    "UI/UX Designer",
    "Financial planner",
    "UI/UX Designer",
    "Financial planner",
    "UI/UX Designer"
  ].obs;
  RxList jobTypesSaved = [true, false, false, true, false].obs;
  RxList jobTypesLogo = [
    AssetRes.airBnbLogo,
    AssetRes.twitterLogo,
    AssetRes.airBnbLogo,
    AssetRes.twitterLogo,
    AssetRes.airBnbLogo
  ].obs;

  onTapSave(index) {
    if (jobTypesSaved[index] == true) {
      jobTypesSaved.removeAt(index);
      jobTypesSaved.insert(index, false);
    } else {
      jobTypesSaved.removeAt(index);
      jobTypesSaved.insert(index, true);
    }
  }

  //CollectionReference allNoteCollection = FirebaseFirestore.instance.collection('allPost');
  List<DocumentSnapshot> documents = [];

  RxString searchText = ''.obs;

  // RxInt selectedJobs = 0.obs;
  // RxList jobs = ["All Job", "Writer", "Design", "Finance"].obs;
  // onTapJobs(int index){
  //   debugPrint("OnTAP $index");
  //   selectedJobs.value = index;
  // }

  RxInt selectedJobs2 = 0.obs;
  RxList jobs2 = [
    "allJob".tr,
    "writer".tr,
    "design".tr,
    "finance".tr,
    "software".tr,
    "databaseManager".tr,
    "productManager".tr,
    "fullStackDeveloper".tr,
    "dataScientist".tr,
    "webDevelopers".tr,
    "networking".tr,
    "cyberSecurity".tr,
  ].obs;

  onTapJobs2(int index) {
    selectedJobs2.value = index;
    //update(["hList"]);
  }
}

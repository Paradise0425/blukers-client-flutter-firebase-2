import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/screen/manager_section/Notification/notification_services.dart';
import 'package:blukers_client_app/service/pref_services.dart';
import 'package:blukers_client_app/utils/pref_keys.dart';

class ManagerHomeScreenController extends GetxController
    implements GetxService {
  String? companyName;
  List userData = [];
  bool loader = false;
  String? token;

  @override
  Future<void> onInit() async {
    token = await NotificationService.getFcmToken();
    getCompanyName();
    getUserData();
    if (kDebugMode) {
      print(token);
    }
    super.onInit();
  }

  getCompanyName() async {
    companyName = PrefService.getString(PrefKeys.companyName);
  }

  getUserData() async {
    loader = true;
    update(['userdata']);

    var data = await FirebaseFirestore.instance.collection("Apply").get();
    userData = data.docs;

    loader = false;
    update(['userdata']);
    update(['userDataSeeAll']);
  }
}

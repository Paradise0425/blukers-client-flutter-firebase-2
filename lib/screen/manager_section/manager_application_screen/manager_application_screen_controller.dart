import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/utils/string.dart';

class ManagerApplicationScreenController extends GetxController
    implements GetxService {
  TextEditingController searchController = TextEditingController();
  RxString searchText = ''.obs;
  bool isData = false;
  List<DocumentSnapshot> documentData = [];

  RxInt selectedJobs2 = 0.obs;
  RxList jobs2 = [
    Strings.allVacancies,
    Strings.active,
    Strings.inactive,
  ].obs;

  /*search(String value)async{
   var d=  await FirebaseFirestore.instance.collection('allPost').get();

   d.docs.forEach((element) {
     element.get("CompanyName").toString()
         .toLowerCase()
         .contains(value.toLowerCase());
   });
  }*/

  onTapJobs2(int index) {
    selectedJobs2.value = index;
    update(["status"]);
  }
}

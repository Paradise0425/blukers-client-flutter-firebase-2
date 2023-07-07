import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/screen/chat_box/chat_box_controller.dart';
import 'package:blukers_client_app/screen/chat_box_user/chat_box_usercontroller.dart';
import 'package:blukers_client_app/screen/dashboard/home/home_controller.dart';
import 'package:blukers_client_app/screen/job_recommendation_screen/job_recommendation_controller.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/color_res.dart';

Widget searchArea() {
  final HomeController controller = HomeController();
  final jrController = Get.put(JobRecommendationController());
  final chatBoxUserController = Get.put(ChatBoxUserController());

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18),
    child: Row(
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: ColorRes.white2,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: TextField(
              controller: controller.searchNewController,
              onChanged: (value) {
                jrController.searchText.value = value;
                jrController.update(["search"]);

                chatBoxUserController.searchText.value = value;
                chatBoxUserController.update(["searchChat"]);
              },
              /*onChanged: (val){
                jrController.allJob = FirebaseFirestore.instance.collection("allPost").where(val , isGreaterThanOrEqualTo: "Position"
                  // e.toString().toLowerCase().contains(val.toString().toLowerCase());
                ).where(val , isLessThanOrEqualTo: "Position" + "z",

                ) as Stream? ;
              },*/
              decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: const Icon(Icons.search, color: ColorRes.grey),
                hintText: "Search",
                hintStyle: appTextStyle(
                    fontSize: 14,
                    color: ColorRes.grey,
                    fontWeight: FontWeight.w500),
                contentPadding: const EdgeInsets.only(left: 20, top: 13),
              ),
            ),
          ),
        ),
        // const SizedBox(width: 20),
        // Container(
        //   height: 40,
        //   width: 40,
        //   alignment: Alignment.center,
        //   decoration: const BoxDecoration(
        //     borderRadius: BorderRadius.all(Radius.circular(10)),
        //     color: ColorRes.logoColor,
        //   ),
        //   child: Image.asset(
        //     AssetRes.menuIcon,
        //     color: ColorRes.containerColor,
        //     height: 15,
        //   ),
        // ),
      ],
    ),
  );
}

Widget searchAreaChatU() {
  final chatBoxUserController = Get.put(ChatBoxUserController());

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18),
    child: Row(
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                color: ColorRes.white2,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: TextField(
              controller: chatBoxUserController.searchController,
              onChanged: (value) {
                chatBoxUserController.searchText.value = value;
                chatBoxUserController.update(["searchChat"]);
              },
              /*onChanged: (val){
                jrController.allJob = FirebaseFirestore.instance.collection("allPost").where(val , isGreaterThanOrEqualTo: "Position"
                  // e.toString().toLowerCase().contains(val.toString().toLowerCase());
                ).where(val , isLessThanOrEqualTo: "Position" + "z",

                ) as Stream? ;
              },*/
              decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: const Icon(Icons.search, color: ColorRes.grey),
                  hintText: "Search",
                  hintStyle: appTextStyle(
                      fontSize: 14,
                      color: ColorRes.grey,
                      fontWeight: FontWeight.w500),
                  contentPadding: const EdgeInsets.only(left: 20, top: 13)),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget searchAreaChatM() {
  final chatBoxController = Get.put(ChatBoxController());

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18),
    child: Row(
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: ColorRes.white2,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: TextField(
              controller: chatBoxController.searchController,
              onChanged: (value) {
                chatBoxController.searchText.value = value;
                chatBoxController.update(["searchChat"]);
              },
              /*    if (jrController.searchText.value.isNotEmpty) {
  jrController.documents =
  jrController.documents.where((element) {
  element
      .get('CompanyName')
      .toString()
      .toLowerCase()
      .contains(
  jrController.searchText.value.toLowerCase());
}).toList();
}         */

              /*onChanged: (val){
                jrController.allJob = FirebaseFirestore.instance.collection("allPost").where(val , isGreaterThanOrEqualTo: "Position"
                  // e.toString().toLowerCase().contains(val.toString().toLowerCase());
                ).where(val , isLessThanOrEqualTo: "Position" + "z",

                ) as Stream? ;
              },*/
              decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: const Icon(Icons.search, color: ColorRes.grey),
                hintText: "Search",
                hintStyle: appTextStyle(
                    fontSize: 14,
                    color: ColorRes.grey,
                    fontWeight: FontWeight.w500),
                contentPadding: const EdgeInsets.only(left: 20, top: 13),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

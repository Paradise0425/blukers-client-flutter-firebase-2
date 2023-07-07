import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/screen/dashboard/home/widgets/all_jobs.dart';
import 'package:blukers_client_app/screen/dashboard/home/widgets/search_field.dart';
import 'package:blukers_client_app/screen/job_recommendation_screen/job_recommendation_controller.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';

class JobRecommendation extends StatelessWidget {
  const JobRecommendation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(JobRecommendationController());
    FirebaseFirestore fireStore = FirebaseFirestore.instance;

    return Scaffold(
      backgroundColor: ColorRes.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: backButton(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      Strings.jobRecommendation,
                      style: appTextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          height: 1,
                          color: ColorRes.black),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            searchArea(),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              height: 32,
              child: ListView.builder(
                  itemCount: controller.jobs2.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => controller.onTapJobs2(index),
                      child: Obx(
                        () => Container(
                          margin: const EdgeInsets.only(right: 10),
                          height: 32,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: ColorRes.containerColor, width: 2),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color: controller.selectedJobs2.value == index
                                  ? ColorRes.containerColor
                                  : ColorRes.white),
                          child: Text(
                            controller.jobs2[index],
                            style: appTextStyle(
                                color: controller.selectedJobs2.value == index
                                    ? ColorRes.white
                                    : ColorRes.containerColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(height: 10),
            Obx(
              () => controller.selectedJobs2.value == 0
                  ? allJobs(fireStore.collection("allPost").snapshots(),
                      seeAll: true)
                  : controller.selectedJobs2.value == 1
                      ? allJobs(fireStore.collection("category").doc("Writer").collection("Writer").snapshots(),
                          seeAll: true)
                      : controller.selectedJobs2.value == 2
                          ? allJobs(fireStore.collection("category").doc("Design").collection("Design").snapshots(),
                              seeAll: true)
                          : controller.selectedJobs2.value == 3
                              ? allJobs(
                                  fireStore
                                      .collection("category")
                                      .doc("Finance")
                                      .collection("Finance")
                                      .snapshots(),
                                  seeAll: true)
                              : controller.selectedJobs2.value == 4
                                  ? allJobs(
                                      fireStore
                                          .collection("category")
                                          .doc("Software")
                                          .collection("Software")
                                          .snapshots(),
                                      seeAll: true)
                                  : controller.selectedJobs2.value == 5
                                      ? allJobs(
                                          fireStore
                                              .collection("category")
                                              .doc("Database Manager")
                                              .collection("Database Manager")
                                              .snapshots(),
                                          seeAll: true)
                                      : controller.selectedJobs2.value == 6
                                          ? allJobs(
                                              fireStore
                                                  .collection("category")
                                                  .doc("Product Manager")
                                                  .collection("Product Manager")
                                                  .snapshots(),
                                              seeAll: true)
                                          : controller.selectedJobs2.value == 7
                                              ? allJobs(
                                                  fireStore
                                                      .collection("category")
                                                      .doc("Full-Stack Developer")
                                                      .collection("Full-Stack Developer")
                                                      .snapshots(),
                                                  seeAll: true)
                                              : controller.selectedJobs2.value == 8
                                                  ? allJobs(fireStore.collection("category").doc("Data Scientist").collection("Data Scientist").snapshots(), seeAll: true)
                                                  : controller.selectedJobs2.value == 9
                                                      ? allJobs(fireStore.collection("category").doc("Web Developers").collection("Web Developers").snapshots(), seeAll: true)
                                                      : controller.selectedJobs2.value == 10
                                                          ? allJobs(fireStore.collection("category").doc("Networking").collection("Networking").snapshots(), seeAll: true)
                                                          : controller.selectedJobs2.value == 11
                                                              ? allJobs(fireStore.collection("category").doc("Cyber Security").collection("Cyber Security").snapshots(), seeAll: true)
                                                              : Center(
                                                                  child: Text(controller
                                                                          .jobs2[
                                                                      controller
                                                                          .selectedJobs2
                                                                          .value]),
                                                                ),
            ),
          ],
        ),
      ),
    );
  }
}

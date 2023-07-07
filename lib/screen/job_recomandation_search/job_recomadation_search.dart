import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/screen/dashboard/home/widgets/all_jobs.dart';
import 'package:blukers_client_app/screen/dashboard/home/widgets/search_field.dart';
import 'package:blukers_client_app/screen/job_recomandation_search/job_recomandation_search_controller.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';

class JobRecomandationSearch extends StatelessWidget {
  JobRecomandationSearch({Key? key}) : super(key: key);
  final controller = Get.put(JobRecomandationSearchController());

  @override
  Widget build(BuildContext context) {
    controller.totalJobs();
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
              height: 10,
            ),
            GetBuilder<JobRecomandationSearchController>(
                id: "length",
                builder: (con) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text("${con.totalLength} jobs"),
                  );
                }),
            const SizedBox(
              height: 10,
            ),
            GetBuilder<JobRecomandationSearchController>(
                builder: (con) => allJobs(
                    FirebaseFirestore.instance
                        .collection("allPost")
                        .snapshots(),
                    seeAll: true)
                /*: controller.selectedJobs2.value == 1
                ? allJobs(fireStore
                .collection("category")
                .doc("Writer")
                .collection("Writer")
                .snapshots())
                : controller.selectedJobs2.value == 2
                ? allJobs(fireStore
                .collection("category")
                .doc("Design")
                .collection("Design")
                .snapshots())
                : controller.selectedJobs2.value == 3
                ? allJobs(fireStore
                .collection("category")
                .doc("Finance")
                .collection("Finance")
                .snapshots())
                : Center(
              child: Text(controller
                  .jobs2[controller.selectedJobs2.value]),*/
                //      )
                ),
          ],
        ),
      ),
    );
  }
}

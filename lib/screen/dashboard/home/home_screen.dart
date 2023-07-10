import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blukers_client_app/screen/dashboard/home/home_controller.dart';
import 'package:blukers_client_app/screen/dashboard/home/tipsforyou_screen.dart';
import 'package:blukers_client_app/screen/dashboard/home/widgets/all_jobs.dart';
import 'package:blukers_client_app/screen/dashboard/home/widgets/appbar.dart';
import 'package:blukers_client_app/screen/dashboard/home/widgets/tips_for_you_section.dart';
import 'package:blukers_client_app/screen/job_detail_screen/job_detail_upload_cv_screen/upload_cv_controller.dart';
import 'package:blukers_client_app/screen/job_recommendation_screen/job_recommendation_controller.dart';
import 'package:blukers_client_app/utils/app_res.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final HomeController controller = HomeController();
  JobRecommendationController jrcontroller =
      Get.put(JobRecommendationController());
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  var args = Get.arguments;
  JobDetailsUploadCvController jobDetailsUploadCvController =
      Get.put(JobDetailsUploadCvController());

  @override
  Widget build(BuildContext context) {
    jobDetailsUploadCvController.init();
    //final controller = Get.put(HomeController());

    return Container(
      height: Get.height,
      width: Get.width,
      color: ColorRes.backgroundColor,
      child: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          homeAppBar(),
          SizedBox(
            height: Get.height - 200,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (con) => const TipsForYouScreen(),
                        ),
                      );
                    },
                    child: tipsForYouSection(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      children: [
                        Text(
                          Strings.jobRecommendation,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: ColorRes.black,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () =>
                              Get.toNamed(AppRes.jobRecommendationScreen),
                          child: Text(
                            Strings.seeAll,
                            style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: ColorRes.containerColor),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///listview using obx
                  /*  SizedBox(
                    height: 32,
                    child: Obx(() {
                      return ListView.builder(

                          itemCount: controller.jobs.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: ()=>controller.onTapJobs(index),
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                height: 32,
                                width: 80,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: ColorRes.containerColor, width: 2),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    color: index == controller.selectedJobs.value
                                        ? ColorRes.containerColor
                                        : ColorRes.white),
                                child: Text(
                                  controller.jobs[index],
                                  style: appTextStyle(
                                      color: index == controller.selectedJobs.value
                                          ? ColorRes.white
                                          : ColorRes.containerColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            );
                          });
                    }),
                  ),*/

                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    height: 32,
                    child: ListView.builder(
                        itemCount: jrcontroller.jobs2.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => jrcontroller.onTapJobs2(index),
                            child: Obx(
                              () => Container(
                                margin: const EdgeInsets.only(right: 10),
                                height: 32,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: ColorRes.containerColor,
                                        width: 2),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    color: jrcontroller.selectedJobs2.value ==
                                            index
                                        ? ColorRes.containerColor
                                        : ColorRes.white),
                                child: Text(
                                  jrcontroller.jobs2[index],
                                  style: appTextStyle(
                                      color: jrcontroller.selectedJobs2.value ==
                                              index
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
                  const SizedBox(height: 18),
                  Obx(
                    () => jrcontroller.selectedJobs2.value == 0
                        ? allJobs(fireStore.collection("allPost").snapshots())
                        : jrcontroller.selectedJobs2.value == 1
                            ? allJobs(
                                fireStore
                                    .collection("category")
                                    .doc("Writer")
                                    .collection("Writer")
                                    .snapshots(),
                              )
                            : jrcontroller.selectedJobs2.value == 2
                                ? allJobs(
                                    fireStore
                                        .collection("category")
                                        .doc("Design")
                                        .collection("Design")
                                        .snapshots(),
                                  )
                                : jrcontroller.selectedJobs2.value == 3
                                    ? allJobs(
                                        fireStore
                                            .collection("category")
                                            .doc("Finance")
                                            .collection("Finance")
                                            .snapshots(),
                                      )
                                    : jrcontroller.selectedJobs2.value == 4
                                        ? allJobs(fireStore
                                            .collection("category")
                                            .doc("Software")
                                            .collection("Software")
                                            .snapshots())
                                        : jrcontroller.selectedJobs2.value == 5
                                            ? allJobs(fireStore
                                                .collection("category")
                                                .doc("Database Manager")
                                                .collection("Database Manager")
                                                .snapshots())
                                            : jrcontroller.selectedJobs2.value ==
                                                    6
                                                ? allJobs(fireStore
                                                    .collection("category")
                                                    .doc("Product Manager")
                                                    .collection(
                                                        "Product Manager")
                                                    .snapshots())
                                                : jrcontroller.selectedJobs2.value ==
                                                        7
                                                    ? allJobs(fireStore
                                                        .collection("category")
                                                        .doc(
                                                            "Full-Stack Developer")
                                                        .collection(
                                                            "Full-Stack Developer")
                                                        .snapshots())
                                                    : jrcontroller.selectedJobs2.value ==
                                                            8
                                                        ? allJobs(fireStore
                                                            .collection(
                                                                "category")
                                                            .doc(
                                                                "Data Scientist")
                                                            .collection(
                                                                "Data Scientist")
                                                            .snapshots())
                                                        : jrcontroller
                                                                    .selectedJobs2
                                                                    .value ==
                                                                9
                                                            ? allJobs(
                                                                fireStore
                                                                    .collection(
                                                                        "category")
                                                                    .doc(
                                                                        "Web Developers")
                                                                    .collection(
                                                                        "Web Developers")
                                                                    .snapshots(),
                                                                seeAll: true)
                                                            : jrcontroller
                                                                        .selectedJobs2
                                                                        .value ==
                                                                    10
                                                                ? allJobs(fireStore
                                                                    .collection("category")
                                                                    .doc("Networking")
                                                                    .collection("Networking")
                                                                    .snapshots())
                                                                : jrcontroller.selectedJobs2.value == 11
                                                                    ? allJobs(fireStore.collection("category").doc("Cyber Security").collection("Cyber Security").snapshots())
                                                                    : Center(
                                                                        child: Text(jrcontroller.jobs2[jrcontroller
                                                                            .selectedJobs2
                                                                            .value]),
                                                                      ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

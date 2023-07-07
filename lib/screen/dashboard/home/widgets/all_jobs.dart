import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/common_loader.dart';
import 'package:blukers_client_app/screen/create_vacancies/create_vacancies_controller.dart';
import 'package:blukers_client_app/screen/dashboard/home/home_controller.dart';
import 'package:blukers_client_app/screen/job_recommendation_screen/job_recommendation_controller.dart';
import 'package:blukers_client_app/service/pref_services.dart';
import 'package:blukers_client_app/utils/app_res.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/pref_keys.dart';

Widget allJobs(Stream stream, {bool? seeAll = false}) {
  final HomeController controller = HomeController();
  CreateVacanciesController create = Get.put(CreateVacanciesController());

  //final jrController = Get.put(JobRecommendationController());
  return GetBuilder<JobRecommendationController>(
      id: "search",
      builder: (jrController) {
        return StreamBuilder(
            stream: stream,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                jrController.documents = snapshot.data.docs;
              }
              controller.jobTypesSaved =
                  List.generate(jrController.documents.length, (index) => false)
                      .obs;

              if (jrController.searchText.value.isNotEmpty) {
                jrController.documents =
                    jrController.documents.where((element) {
                  return element
                          .get('Position')
                          .toString()
                          .toLowerCase()
                          .contains(
                              jrController.searchText.value.toLowerCase()) ||
                      element
                          .get('CompanyName')
                          .toString()
                          .toLowerCase()
                          .contains(
                              jrController.searchText.value.toLowerCase());
                }).toList();
              }

              return snapshot.hasData
                  ? ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: seeAll!
                          ? jrController.documents.length
                          : (jrController.documents.length <= 15
                              ? jrController.documents.length
                              : 15),
                      //jrController.documents.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (kDebugMode) {
                          print([jrController.documents.length - 1 - index]);
                        }
                        if (kDebugMode) {
                          print(jrController
                              .documents[
                                  jrController.documents.length - 1 - index]
                              .id);
                        }
                        return (jrController.documents[
                                    jrController.documents.length -
                                        1 -
                                        index]["Status"] !=
                                'Inactive')
                            ? InkWell(
                                onTap: () => Get.toNamed(AppRes.jobDetailScreen,
                                    arguments: {
                                      "saved": jrController.documents[
                                          jrController.documents.length -
                                              1 -
                                              index],
                                      "docId": jrController.documents.length -
                                          1 -
                                          index
                                    }),
                                child: Container(
                                  height: 92,
                                  width: Get.width,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 18, vertical: 4),
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                      border: Border.all(
                                        color: const Color(0xffF3ECFF),
                                      ),
                                      color: ColorRes.white),
                                  child: Row(
                                    children: [
                                      (create.url == "")
                                          ? const Image(
                                              image: AssetImage(
                                                  AssetRes.airBnbLogo),
                                              height: 100,
                                            )
                                          : Image(
                                              image: NetworkImage(create.url),
                                              height: 100,
                                            ),
                                      /*  Image.asset(
                                          controller.jobTypesLogo[index % 5]),*/
                                      const SizedBox(width: 20),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            jrController.documents[
                                                jrController.documents.length -
                                                    1 -
                                                    index]["Position"],
                                            style: appTextStyle(
                                                color: ColorRes.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            jrController.documents[
                                                jrController.documents.length -
                                                    1 -
                                                    index]["CompanyName"],
                                            style: appTextStyle(
                                                color: ColorRes.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            "${jrController.documents[jrController.documents.length - 1 - index]["location"]} "
                                            " ${jrController.documents[jrController.documents.length - 1 - index]["type"]}",
                                            style: appTextStyle(
                                                color: ColorRes.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              String docId = snapshot
                                                  .data
                                                  .docs[jrController
                                                          .documents.length -
                                                      1 -
                                                      index]
                                                  .id;
                                              controller.onTapSave(
                                                  jrController
                                                          .documents.length -
                                                      1 -
                                                      index,
                                                  jrController.documents[
                                                      jrController.documents
                                                              .length -
                                                          1 -
                                                          index],
                                                  docId);
                                            },
                                            child: GetBuilder<
                                                    JobRecommendationController>(
                                                builder: (con) {
                                              return Image.asset(
                                                (jrController.documents[jrController
                                                                        .documents
                                                                        .length -
                                                                    1 -
                                                                    index][
                                                                'BookMarkUserList'] ==
                                                            null ||
                                                        jrController
                                                                .documents[jrController.documents.length - 1 - index][
                                                                    'BookMarkUserList']
                                                                .length ==
                                                            0)
                                                    ? AssetRes
                                                        .bookMarkBorderIcon
                                                    : (jrController.documents[
                                                                jrController
                                                                        .documents
                                                                        .length -
                                                                    1 -
                                                                    index]
                                                                ['BookMarkUserList']
                                                            .contains(PrefService.getString(PrefKeys.userId)))
                                                        ? AssetRes.bookMarkFillIcon
                                                        : AssetRes.bookMarkBorderIcon,
                                                height: 20,
                                              );
                                            }),
                                          ),
                                          const Spacer(),
                                          Text(
                                            "\$${jrController.documents[jrController.documents.length - 1 - index]["salary"]}",
                                            style: appTextStyle(
                                                fontSize: 16,
                                                color: ColorRes.containerColor,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      const SizedBox(width: 10)
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox();
                      })
                  : const CommonLoader();
            });
      });
}

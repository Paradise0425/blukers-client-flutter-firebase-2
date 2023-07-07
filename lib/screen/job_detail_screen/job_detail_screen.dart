import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/screen/job_detail_screen/job_detail_controller.dart';
import 'package:blukers_client_app/screen/job_detail_screen/job_detail_widget/job_detail_widget.dart';
import 'package:blukers_client_app/screen/savejobs/save_job_screen.dart';
import 'package:blukers_client_app/service/pref_services.dart';
import 'package:blukers_client_app/utils/app_res.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/pref_keys.dart';
import 'package:blukers_client_app/utils/string.dart';

// ignore: must_be_immutable
class JobDetailScreen extends StatelessWidget {
  JobDetailScreen({Key? key}) : super(key: key);
  final JobDetailsController controller = Get.put(JobDetailsController());
  var args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(args['saved']['location']);
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    SizedBox(
                      height: 45,
                      width: Get.width,
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  padding: const EdgeInsets.only(left: 10),
                                  // margin: const EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    color: ColorRes.logoColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Align(
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: ColorRes.containerColor,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: ColorRes.logoColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: GetBuilder<JobDetailsController>(
                                    id: "bookmark",
                                    builder: (con) {
                                      return Align(
                                        alignment: Alignment.center,
                                        child: (args['saved']
                                                    ['BookMarkUserList']
                                                .contains(PrefService.getString(
                                                    PrefKeys.userId)))
                                            ? InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (con) =>
                                                              SaveJobScreen()));
                                                },
                                                child: Image.asset(
                                                  AssetRes.bookMarkFillIcon,
                                                  height: 20,
                                                  width: 20,
                                                ),
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  Map<String, dynamic> map = {
                                                    "Position": args['saved']
                                                        ['Position'],
                                                    "CompanyName": args['saved']
                                                        ['CompanyName'],
                                                    "salary": args['saved']
                                                        ['salary'],
                                                    "location": args['saved']
                                                        ['location'],
                                                    "type": args['saved']
                                                        ['type'],
                                                  };

                                                  List bookmark = [];
                                                  bookmark = args['saved']
                                                      ['BookMarkUserList'];
                                                  if (bookmark.isEmpty) {
                                                    bookmark.add(
                                                        PrefService.getString(
                                                            PrefKeys.userId));
                                                  }
                                                  for (int i = 0;
                                                      i < bookmark.length;
                                                      i++) {
                                                    if (bookmark[i] !=
                                                        PrefService.getString(
                                                            PrefKeys.userId)) {
                                                      bookmark.add(
                                                          PrefService.getString(
                                                              PrefKeys.userId));
                                                    }
                                                  }
                                                  List<String> bookmarkList =
                                                      List.generate(
                                                          bookmark.length,
                                                          (index) {
                                                    return bookmark[index]
                                                        .toString();
                                                  });
                                                  Map<String, dynamic> map2 = {
                                                    "BookMarkUserList":
                                                        bookmarkList,
                                                  };

                                                  FirebaseFirestore.instance
                                                      .collection('allPost')
                                                      .doc(args['saved'].id)
                                                      .update(map2);

                                                  // ignore: avoid_single_cascade_in_expression_statements
                                                  FirebaseFirestore.instance
                                                      .collection('BookMark')
                                                      .doc(
                                                          PrefService.getString(
                                                              PrefKeys.userId))
                                                      .collection("BookMark1")
                                                    ..doc().set(map);

                                                  controller
                                                      .update(['bookmark']);
                                                },
                                                child: Image.asset(
                                                  AssetRes.bookMarkBorderIcon,
                                                  height: 20,
                                                  width: 20,
                                                ),
                                              ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Center(
                              child: Text(
                                Strings.jobDetails,
                                style: appTextStyle(
                                  color: ColorRes.black,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 92,
                    width: Get.width,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        border: Border.all(color: ColorRes.borderColor),
                        color: ColorRes.white),
                    child: Row(
                      children: [
                        Image.asset(AssetRes.airBnbLogo),
                        const SizedBox(width: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(args["saved"]["Position"],
                                style: appTextStyle(
                                    color: ColorRes.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500)),
                            Text(args["saved"]["CompanyName"],
                                style: appTextStyle(
                                    color: ColorRes.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: Get.width,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                    padding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 18),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        border: Border.all(color: ColorRes.borderColor),
                        color: ColorRes.white),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Salary",
                                style: appTextStyle(
                                    color: ColorRes.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500)),
                            Text("\$${args["saved"]["salary"]}",
                                style: appTextStyle(
                                    color: ColorRes.containerColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(Strings.type,
                                style: appTextStyle(
                                    color: ColorRes.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500)),
                            Text(args["saved"]["type"],
                                style: appTextStyle(
                                    color: ColorRes.containerColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(Strings.location,
                                style: appTextStyle(
                                    color: ColorRes.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500)),
                            Text(args["saved"]["location"],
                                style: appTextStyle(
                                    color: ColorRes.containerColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      Strings.requirements,
                      style: appTextStyle(color: ColorRes.black),
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: args["saved"]["RequirementsList"].length,
                      itemBuilder: (context, index) {
                        return detailBox(
                            args["saved"]["RequirementsList"][index], false);
                      }),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRes.jobDetailUploadCvScreen, arguments: {
                        "doc": args["saved"],
                      });
                    },
                    child: Container(
                      height: 50,
                      width: Get.width,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      margin: const EdgeInsets.only(
                          right: 18, left: 18, top: 10, bottom: 30),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        gradient: LinearGradient(colors: [
                          ColorRes.gradientColor,
                          ColorRes.containerColor,
                        ]),
                      ),
                      child: Text(Strings.applyNow,
                          style: appTextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

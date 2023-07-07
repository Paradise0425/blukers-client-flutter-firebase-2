import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/common/widgets/common_loader.dart';
import 'package:blukers_client_app/screen/dashboard/applications/financialplanner_screen.dart';
import 'package:blukers_client_app/screen/dashboard/applications/applications_controller.dart';
import 'package:blukers_client_app/screen/dashboard/applications/rejected_screen.dart';
import 'package:blukers_client_app/screen/dashboard/home/widgets/search_field.dart';
import 'package:blukers_client_app/screen/savejobs/save_job_screen.dart';
import 'package:blukers_client_app/service/pref_services.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/pref_keys.dart';
import 'package:blukers_client_app/utils/string.dart';
import 'uiux_designer_screen.dart';
import 'accepted_screen.dart';

class ApplicationsScreen extends StatelessWidget {
  ApplicationsScreen({Key? key}) : super(key: key);

  final applicationController = Get.put(ApplicationsController());

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("fastbacks");
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: Get.height,
        width: Get.width,
        color: ColorRes.backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  logo(),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        Strings.applications,
                        style: appTextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: ColorRes.black),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      debugPrint("ON TAP SAVE BTN");
                    },
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (con) => SaveJobScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: ColorRes.logoColor),
                        child: Image.asset(
                          AssetRes.bookMarkFillIcon,
                          height: 21,
                          width: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            searchArea(),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              height: 32,
              child: ListView.builder(
                  itemCount: applicationController.jobs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => applicationController.onTapJobs2(index),
                      child: Obx(
                        () => Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          height: 32,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: ColorRes.containerColor, width: 2),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color: applicationController.selectedJobs.value ==
                                      index
                                  ? ColorRes.containerColor
                                  : ColorRes.white),
                          child: Text(
                            applicationController.jobs[index],
                            style: appTextStyle(
                                color:
                                    applicationController.selectedJobs.value ==
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
            const SizedBox(height: 15),
            SizedBox(
              height: Get.height - 309,
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection("Applicants")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null || snapshot.hasData == false) {
                      return const CommonLoader();
                    }

                    return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return StreamBuilder<
                              QuerySnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection('Applicants')
                                .doc(snapshot.data!.docs[index].id)
                                .collection('userDetails')
                                .snapshots(),
                            builder: (context, snapshot2) {
                              if (snapshot2.data == null ||
                                  snapshot2.hasData == false) {
                                return const SizedBox();
                              }
                              return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot2.data!.docs.length,
                                itemBuilder: (context, index2) {
                                  return (snapshot2
                                              .data!.docs[index2]['userName']
                                              .toString()
                                              .toLowerCase()
                                              .removeAllWhitespace ==
                                          PrefService.getString(
                                                  PrefKeys.fullName)
                                              .toString()
                                              .toLowerCase()
                                              .removeAllWhitespace)
                                      ? Obx(
                                          () => Column(
                                            children: [
                                              (applicationController
                                                          .selectedJobs.value ==
                                                      0)
                                                  ? Container(
                                                      height: 135,
                                                      width: Get.width,
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 18,
                                                          vertical: 4),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(15),
                                                          ),
                                                          border: Border.all(
                                                            color: const Color(
                                                                0xffF3ECFF),
                                                          ),
                                                          color:
                                                              ColorRes.white),
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 8),
                                                            child: Row(
                                                              children: [
                                                                Image.asset(
                                                                    AssetRes
                                                                        .airBnbLogo,
                                                                    height: 40),
                                                                const SizedBox(
                                                                    width: 20),
                                                                Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        snapshot2.data!.docs[index2]
                                                                            [
                                                                            'position'],
                                                                        style: appTextStyle(
                                                                            color: ColorRes
                                                                                .black,
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.w500)),
                                                                    Text(
                                                                        snapshot.data!.docs[index]
                                                                            [
                                                                            'companyName'],
                                                                        style: appTextStyle(
                                                                            color: ColorRes
                                                                                .black,
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w400)),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const Divider(
                                                            color:
                                                                ColorRes.grey,
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          InkWell(
                                                            onTap: () {
                                                              (snapshot2.data!.docs[
                                                                              index2]
                                                                          [
                                                                          'status'] ==
                                                                      'Sent')
                                                                  ? Navigator
                                                                      .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (con) =>
                                                                                SentScreen(
                                                                          position: snapshot2
                                                                              .data!
                                                                              .docs[index2]['position'],
                                                                          companyName: snapshot
                                                                              .data!
                                                                              .docs[index]['companyName'],
                                                                          message: snapshot2
                                                                              .data!
                                                                              .docs[index2]['message'],
                                                                          salary: snapshot2
                                                                              .data!
                                                                              .docs[index2]['salary'],
                                                                          location: snapshot2
                                                                              .data!
                                                                              .docs[index2]['location'],
                                                                          type: snapshot2
                                                                              .data!
                                                                              .docs[index2]['type'],
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : (snapshot2.data!.docs[index2]
                                                                              [
                                                                              'status'] ==
                                                                          'Rejected')
                                                                      ? Navigator
                                                                          .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder: (con) =>
                                                                                RejectedScreen(
                                                                              position: snapshot2.data!.docs[index2]['position'],
                                                                              companyName: snapshot.data!.docs[index]['companyName'],
                                                                              message: snapshot2.data!.docs[index2]['message'],
                                                                              salary: snapshot2.data!.docs[index2]['salary'],
                                                                              location: snapshot2.data!.docs[index2]['location'],
                                                                              type: snapshot2.data!.docs[index2]['type'],
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : (snapshot2.data!.docs[index2]['status'] ==
                                                                              'Accepted')
                                                                          ? Navigator
                                                                              .push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (con) => AcceptedScreen(
                                                                                  position: snapshot2.data!.docs[index2]['position'],
                                                                                  companyName: snapshot.data!.docs[index]['companyName'],
                                                                                  message: snapshot2.data!.docs[index2]['message'],
                                                                                  salary: snapshot2.data!.docs[index2]['salary'],
                                                                                  location: snapshot2.data!.docs[index2]['location'],
                                                                                  type: snapshot2.data!.docs[index2]['type'],
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : const SizedBox();
                                                            },
                                                            child: Container(
                                                              height: 28,
                                                              width: Get.width,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: snapshot2.data!.docs[index2]
                                                                            [
                                                                            'status'] ==
                                                                        'Schedule Interview'
                                                                    ? const Color(
                                                                        0xffFFFBED)
                                                                    : snapshot2.data!.docs[index2]['status'] ==
                                                                            'Sent'
                                                                        ? const Color(
                                                                            0xffEEF2FA)
                                                                        : snapshot2.data!.docs[index2]['status'] ==
                                                                                'Rejected'
                                                                            ? const Color(0xffFEEFEF)
                                                                            : snapshot2.data!.docs[index2]['status'] == 'Accepted'
                                                                                ? const Color(0xffEDF9F0)
                                                                                : const Color(0xffFFFBED),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            99),
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  snapshot2.data!.docs[index2]
                                                                              [
                                                                              'status'] ==
                                                                          'Schedule Interview'
                                                                      ? "Schedule Interview"
                                                                      : snapshot2.data!.docs[index2]['status'] ==
                                                                              'Sent'
                                                                          ? "Application Sent"
                                                                          : snapshot2.data!.docs[index2]['status'] == 'Rejected'
                                                                              ? "Application Rejected"
                                                                              : snapshot2.data!.docs[index2]['status'] == 'Accepted'
                                                                                  ? "Application Accepted"
                                                                                  : "Application Pending",
                                                                  style:
                                                                      appTextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: snapshot2.data!.docs[index2]['status'] ==
                                                                            'Schedule Interview'
                                                                        ? const Color(
                                                                            0xffF1C100)
                                                                        : snapshot2.data!.docs[index2]['status'] ==
                                                                                'Sent'
                                                                            ? const Color(0xff2E5AAC)
                                                                            : snapshot2.data!.docs[index2]['status'] == 'Rejected'
                                                                                ? const Color(0xffDA1414)
                                                                                : snapshot2.data!.docs[index2]['status'] == 'Accepted'
                                                                                    ? const Color(0xff23A757)
                                                                                    : const Color(0xffF1C100),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                              (applicationController
                                                          .selectedJobs.value ==
                                                      2)
                                                  ? (snapshot2.data!
                                                                  .docs[index2]
                                                              ['status'] ==
                                                          'Schedule Interview')
                                                      ? Container(
                                                          height: 135,
                                                          width: Get.width,
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      18,
                                                                  vertical: 4),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                          .all(
                                                                      Radius.circular(
                                                                          15)),
                                                              border: Border.all(
                                                                  color: const Color(
                                                                      0xffF3ECFF)),
                                                              color: ColorRes
                                                                  .white),
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            8),
                                                                child: Row(
                                                                  children: [
                                                                    Image.asset(
                                                                        AssetRes
                                                                            .airBnbLogo,
                                                                        height:
                                                                            40),
                                                                    const SizedBox(
                                                                        width:
                                                                            20),
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                            snapshot2.data!.docs[index2][
                                                                                'position'],
                                                                            style: appTextStyle(
                                                                                color: ColorRes.black,
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.w500)),
                                                                        Text(
                                                                            snapshot.data!.docs[index][
                                                                                'companyName'],
                                                                            style: appTextStyle(
                                                                                color: ColorRes.black,
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w400)),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              const Divider(
                                                                color: ColorRes
                                                                    .grey,
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (con) =>
                                                                              ScheduleInterviewScreen(
                                                                        position: snapshot2
                                                                            .data!
                                                                            .docs[index2]['position'],
                                                                        companyName: snapshot
                                                                            .data!
                                                                            .docs[index]['companyName'],
                                                                        message: snapshot2
                                                                            .data!
                                                                            .docs[index2]['message'],
                                                                        salary: snapshot2
                                                                            .data!
                                                                            .docs[index2]['salary'],
                                                                        location: snapshot2
                                                                            .data!
                                                                            .docs[index2]['location'],
                                                                        type: snapshot2
                                                                            .data!
                                                                            .docs[index2]['type'],
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 28,
                                                                  width:
                                                                      Get.width,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: const Color(
                                                                        0xffFFFBED),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            99),
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      "Schedule Interview",
                                                                      style:
                                                                          appTextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: const Color(
                                                                            0xffF1C100),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : const SizedBox()
                                                  : const SizedBox(),
                                              (applicationController
                                                          .selectedJobs.value ==
                                                      1)
                                                  ? (snapshot2.data!
                                                                  .docs[index2]
                                                              ['status'] ==
                                                          'Accepted')
                                                      ? Container(
                                                          height: 135,
                                                          width: Get.width,
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      18,
                                                                  vertical: 4),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15),
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            15),
                                                                  ),
                                                                  border: Border.all(
                                                                      color: const Color(
                                                                          0xffF3ECFF)),
                                                                  color: ColorRes
                                                                      .white),
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            8),
                                                                child: Row(
                                                                  children: [
                                                                    Image.asset(
                                                                        AssetRes
                                                                            .airBnbLogo,
                                                                        height:
                                                                            40),
                                                                    const SizedBox(
                                                                        width:
                                                                            20),
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                            snapshot2.data!.docs[index2][
                                                                                'position'],
                                                                            style: appTextStyle(
                                                                                color: ColorRes.black,
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.w500)),
                                                                        Text(
                                                                            snapshot.data!.docs[index][
                                                                                'companyName'],
                                                                            style: appTextStyle(
                                                                                color: ColorRes.black,
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w400)),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              const Divider(
                                                                color: ColorRes
                                                                    .grey,
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (con) =>
                                                                              AcceptedScreen(
                                                                        position: snapshot2
                                                                            .data!
                                                                            .docs[index2]['position'],
                                                                        companyName: snapshot
                                                                            .data!
                                                                            .docs[index]['companyName'],
                                                                        message: snapshot2
                                                                            .data!
                                                                            .docs[index2]['message'],
                                                                        salary: snapshot2
                                                                            .data!
                                                                            .docs[index2]['salary'],
                                                                        location: snapshot2
                                                                            .data!
                                                                            .docs[index2]['location'],
                                                                        type: snapshot2
                                                                            .data!
                                                                            .docs[index2]['type'],
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 28,
                                                                  width:
                                                                      Get.width,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: const Color(
                                                                        0xffEDF9F0),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            99),
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      Strings
                                                                          .applicationAccepted,
                                                                      style:
                                                                          appTextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: const Color(
                                                                            0xff23A757),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : const SizedBox()
                                                  : const SizedBox(),
                                              (applicationController
                                                          .selectedJobs.value ==
                                                      3)
                                                  ? (snapshot2.data!
                                                                  .docs[index2]
                                                              ['status'] ==
                                                          'Rejected')
                                                      ? Container(
                                                          height: 135,
                                                          width: Get.width,
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      18,
                                                                  vertical: 4),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                          .all(
                                                                      Radius.circular(
                                                                          15)),
                                                              border: Border.all(
                                                                  color: const Color(
                                                                      0xffF3ECFF)),
                                                              color: ColorRes
                                                                  .white),
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            8),
                                                                child: Row(
                                                                  children: [
                                                                    Image.asset(
                                                                        AssetRes
                                                                            .airBnbLogo,
                                                                        height:
                                                                            40),
                                                                    const SizedBox(
                                                                        width:
                                                                            20),
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          snapshot2
                                                                              .data!
                                                                              .docs[index2]['position'],
                                                                          style: appTextStyle(
                                                                              color: ColorRes.black,
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.w500),
                                                                        ),
                                                                        Text(
                                                                          snapshot
                                                                              .data!
                                                                              .docs[index]['companyName'],
                                                                          style: appTextStyle(
                                                                              color: ColorRes.black,
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w400),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              const Divider(
                                                                color: ColorRes
                                                                    .grey,
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (con) =>
                                                                              RejectedScreen(
                                                                        position: snapshot2
                                                                            .data!
                                                                            .docs[index2]['position'],
                                                                        companyName: snapshot
                                                                            .data!
                                                                            .docs[index]['companyName'],
                                                                        message: snapshot2
                                                                            .data!
                                                                            .docs[index2]['message'],
                                                                        salary: snapshot2
                                                                            .data!
                                                                            .docs[index2]['salary'],
                                                                        location: snapshot2
                                                                            .data!
                                                                            .docs[index2]['location'],
                                                                        type: snapshot2
                                                                            .data!
                                                                            .docs[index2]['type'],
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 28,
                                                                  width:
                                                                      Get.width,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: const Color(
                                                                        0xffFEEFEF),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            99),
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      Strings
                                                                          .applicationRejected,
                                                                      style:
                                                                          appTextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: const Color(
                                                                            0xffDA1414),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : const SizedBox()
                                                  : const SizedBox(),
                                              (applicationController
                                                          .selectedJobs.value ==
                                                      4)
                                                  ? (snapshot2.data!
                                                                  .docs[index2]
                                                              ['status'] ==
                                                          'Sent')
                                                      ? Container(
                                                          height: 135,
                                                          width: Get.width,
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      18,
                                                                  vertical: 4),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15),
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            15),
                                                                  ),
                                                                  border: Border
                                                                      .all(
                                                                    color: const Color(
                                                                        0xffF3ECFF),
                                                                  ),
                                                                  color: ColorRes
                                                                      .white),
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            8),
                                                                child: Row(
                                                                  children: [
                                                                    Image.asset(
                                                                        AssetRes
                                                                            .airBnbLogo,
                                                                        height:
                                                                            40),
                                                                    const SizedBox(
                                                                        width:
                                                                            20),
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                            snapshot2.data!.docs[index2][
                                                                                'position'],
                                                                            style: appTextStyle(
                                                                                color: ColorRes.black,
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.w500)),
                                                                        Text(
                                                                            snapshot.data!.docs[index][
                                                                                'companyName'],
                                                                            style: appTextStyle(
                                                                                color: ColorRes.black,
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w400)),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              const Divider(
                                                                color: ColorRes
                                                                    .grey,
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (con) =>
                                                                              SentScreen(
                                                                        position: snapshot2
                                                                            .data!
                                                                            .docs[index2]['position'],
                                                                        companyName: snapshot
                                                                            .data!
                                                                            .docs[index]['companyName'],
                                                                        message: snapshot2
                                                                            .data!
                                                                            .docs[index2]['message'],
                                                                        salary: snapshot2
                                                                            .data!
                                                                            .docs[index2]['salary'],
                                                                        location: snapshot2
                                                                            .data!
                                                                            .docs[index2]['location'],
                                                                        type: snapshot2
                                                                            .data!
                                                                            .docs[index2]['type'],
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 28,
                                                                  width:
                                                                      Get.width,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: const Color(
                                                                        0xffEEF2FA),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            99),
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      "Application Sent",
                                                                      style:
                                                                          appTextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: const Color(
                                                                            0xff2E5AAC),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : const SizedBox()
                                                  : const SizedBox(),
                                            ],
                                          ),
                                        )
                                      : const SizedBox();
                                },
                              );
                            },
                          );
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

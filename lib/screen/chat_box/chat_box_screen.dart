import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/common/widgets/common_loader.dart';
import 'package:blukers_client_app/common/widgets/helper.dart';
import 'package:blukers_client_app/screen/chat_box_user/chat_box_usercontroller.dart';
import 'package:blukers_client_app/screen/create_vacancies/create_vacancies_controller.dart';
import 'package:blukers_client_app/screen/dashboard/home/widgets/search_field.dart';
import 'package:blukers_client_app/screen/job_detail_screen/job_detail_upload_cv_screen/upload_cv_controller.dart';
import 'package:blukers_client_app/service/pref_services.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/pref_keys.dart';
import 'package:blukers_client_app/utils/string.dart';
import 'chat_box_controller.dart';

// ignore: must_be_immutable
class ChatBoxScreen extends StatelessWidget {
  ChatBoxScreen({Key? key}) : super(key: key);
  final controller = Get.put(ChatBoxController());
  JobDetailsUploadCvController jobDetailsUploadCvController =
      Get.put(JobDetailsUploadCvController());

  ChatBoxUserController chatBoxUserController =
      Get.put(ChatBoxUserController());

  CreateVacanciesController create = Get.put(CreateVacanciesController());

  @override
  Widget build(BuildContext context) {
    jobDetailsUploadCvController.init();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorRes.backgroundColor,
      body: Column(
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: logo(),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Center(
                    child: Text(
                      Strings.chatBox,
                      style: appTextStyle(
                          color: ColorRes.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          searchAreaChatM(),
          const SizedBox(height: 20),
          GetBuilder<ChatBoxController>(
            id: "searchChat",
            builder: (controller) {
              return Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.only(right: 20),
                height: 32,
                child: ListView.builder(
                  itemCount: controller.jobs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => controller.onTapJobs(index),
                      child: Obx(
                        () => Container(
                          margin: const EdgeInsets.only(right: 10),
                          height: 32,
                          width: 70,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: ColorRes.containerColor, width: 2),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color: controller.selectedJobs.value == index
                                  ? ColorRes.containerColor
                                  : ColorRes.white),
                          child: Text(
                            controller.jobs[index],
                            style: appTextStyle(
                                color: controller.selectedJobs.value == index
                                    ? ColorRes.white
                                    : ColorRes.containerColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          GetBuilder<ChatBoxController>(
              id: "searchChat",
              builder: (con) {
                return controller.selectedJobs.value == 0
                    ? allChat()
                    : unread();
              }),
        ],
      ),
    );
  }
}

Widget allChat() {
  CreateVacanciesController create = Get.put(CreateVacanciesController());
  return GetBuilder<ChatBoxController>(
      id: "searchChat",
      builder: (controller) {
        return controller.searchController.text.isEmpty
            ? Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection("Apply")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null || snapshot.hasData == false) {
                        return const CommonLoader();
                      }

                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            String? o;

                            snapshot.data!.docs[index]['companyName']
                                .forEach((element) {
                              if (element['companyname']
                                      .toString()
                                      .toLowerCase() ==
                                  PrefService.getString(PrefKeys.companyName)
                                      .toString()
                                      .toLowerCase()) {
                                if (kDebugMode) {
                                  print(element);
                                }

                                o = element['companyname'];
                              }
                            });

                            return StreamBuilder<
                                DocumentSnapshot<Map<String, dynamic>>>(
                              stream: FirebaseFirestore.instance
                                  .collection('chats')
                                  .doc(controller.getChatId(controller.userUid,
                                      snapshot.data!.docs[index].id))
                                  .snapshots(),
                              builder: (context, snapshotM) {
                                if (snapshotM.data == null ||
                                    snapshotM.hasData == false) {
                                  return const SizedBox();
                                }

                                Map<String, dynamic>? dataM =
                                    snapshotM.data?.data();
                                //controller.dataChat = [];
                                if (dataM!["countU"] != null) {
                                  controller.dataChat.add({
                                    "name": snapshot.data!.docs[index]
                                        ['userName'],
                                    "count": dataM['countU'],
                                    "image": create.url,
                                    "time": dataM['lastMessageTime'],
                                    "lastMessage": dataM['lastMessage'],
                                    "id": snapshot.data!.docs[index].id,
                                    "deviceToken": snapshot.data!.docs[index]
                                        ['deviceToken'],
                                    "userName": snapshot.data!.docs[index]
                                        ['userName']
                                  });
                                }
                                return (o.toString().toLowerCase() ==
                                        PrefService.getString(
                                                PrefKeys.companyName)
                                            .toString()
                                            .toLowerCase())
                                    ? InkWell(
                                        onTap: () async {
                                          controller.lastMessageTrue(
                                              snapshot.data!.docs[index].id);

                                          controller.gotoChatScreen(
                                              context,
                                              snapshot.data!.docs[index].id,
                                              snapshot.data!.docs[index]
                                                  ['userName'],
                                              snapshot.data!.docs[index]
                                                  ['deviceToken']);
                                        },
                                        child: Container(
                                          height: 92,
                                          width: Get.width,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 18, vertical: 4),
                                          padding: const EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
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
                                                      image: NetworkImage(
                                                          create.url),
                                                      height: 100,
                                                    ),
                                              const SizedBox(width: 20),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snapshot.data!.docs[index]
                                                        ['userName'],
                                                    style: appTextStyle(
                                                        color: ColorRes.black,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  const SizedBox(height: 6),
                                                  Text(
                                                    dataM['lastMessage'] ?? "",
                                                    style: appTextStyle(
                                                        color: ColorRes.black
                                                            .withOpacity(0.8),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
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
                                                  (dataM['countU'] == 0 ||
                                                          dataM['countU'] ==
                                                              null)
                                                      ? const SizedBox()
                                                      : Container(
                                                          height: 22,
                                                          width: 22,
                                                          decoration:
                                                              BoxDecoration(
                                                            gradient:
                                                                const LinearGradient(
                                                              colors: [
                                                                ColorRes
                                                                    .gradientColor,
                                                                ColorRes
                                                                    .containerColor
                                                              ],
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        22),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 5),
                                                            child: Text(
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              "${dataM['countU'] ?? ""}",
                                                              style: appTextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: ColorRes
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                  const Spacer(),
                                                  Text(
                                                    dataM['lastMessageTime'] ==
                                                            null
                                                        ? ""
                                                        : " ${getFormattedTime(dataM['lastMessageTime'].toDate() ?? "")}",
                                                    style: appTextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(width: 10),
                                            ],
                                          ),
                                        ),
                                      )
                                    : const SizedBox();
                              },
                            );
                          });
                    }),
              )
            : Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection("Apply")
                        .snapshots(),
                    /*FirebaseFirestore.instance
                .collection("Auth")
                .doc("User")
                .collection("register")
                .snapshots(),*/
                    builder: (context, snapshot) {
                      if (snapshot.data == null || snapshot.hasData == false) {
                        return const CommonLoader();
                      }

                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            String? o;

                            snapshot.data!.docs[index]['companyName']
                                .forEach((element) {
                              if (element.toString().toLowerCase() ==
                                  PrefService.getString(PrefKeys.companyName)
                                      .toString()
                                      .toLowerCase()) {
                                //userName.add(snapshot.data!.docs[index]['userName']);

                                o = element;
                              }
                            });

                            /* userName.forEach((element) {
                            u = element;
                          });*/

                            return StreamBuilder<
                                DocumentSnapshot<Map<String, dynamic>>>(
                              stream: FirebaseFirestore.instance
                                  .collection('chats')
                                  .doc(controller.getChatId(controller.userUid,
                                      snapshot.data!.docs[index].id))
                                  .snapshots(),
                              builder: (context, snapshotM) {
                                if (snapshotM.data == null ||
                                    snapshotM.hasData == false) {
                                  return const SizedBox();
                                }

                                Map<String, dynamic>? dataM =
                                    snapshotM.data?.data();

                                return (o.toString().toLowerCase() ==
                                        PrefService.getString(
                                                PrefKeys.companyName)
                                            .toString()
                                            .toLowerCase())
                                    ? (snapshot.data!.docs[index]['userName']
                                                .toString()
                                                .contains(controller
                                                    .searchText.value.capitalize
                                                    .toString()) ||
                                            snapshot
                                                .data!.docs[index]['userName']
                                                .toString()
                                                .contains(controller
                                                    .searchText.value
                                                    .toLowerCase()
                                                    .toString()))
                                        ? InkWell(
                                            onTap: () async {
                                              controller.lastMessageTrue(
                                                  snapshot
                                                      .data!.docs[index].id);

                                              controller.gotoChatScreen(
                                                  context,
                                                  snapshot.data!.docs[index].id,
                                                  snapshot.data!.docs[index]
                                                      ['userName'],
                                                  snapshot.data!.docs[index]
                                                      ['deviceToken']);
                                            },
                                            child: Container(
                                              height: 92,
                                              width: Get.width,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 18,
                                                      vertical: 4),
                                              padding: const EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(15)),
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xffF3ECFF),
                                                  ),
                                                  color: ColorRes.white),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    AssetRes.airBnbLogo,
                                                  ),
                                                  const SizedBox(width: 20),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        snapshot.data!
                                                                .docs[index]
                                                            ['userName'],
                                                        style: appTextStyle(
                                                            color:
                                                                ColorRes.black,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      const SizedBox(height: 6),
                                                      Text(
                                                        dataM?['lastMessage'] ??
                                                            "",
                                                        style: appTextStyle(
                                                            color: ColorRes
                                                                .black
                                                                .withOpacity(
                                                                    0.8),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
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
                                                      (dataM?['countU'] == 0 ||
                                                              dataM?['countU'] ==
                                                                  null)
                                                          ? const SizedBox()
                                                          : Container(
                                                              height: 22,
                                                              width: 22,
                                                              decoration:
                                                                  BoxDecoration(
                                                                gradient:
                                                                    const LinearGradient(
                                                                  colors: [
                                                                    ColorRes
                                                                        .gradientColor,
                                                                    ColorRes
                                                                        .containerColor
                                                                  ],
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            22),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 5),
                                                                child: Text(
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  "${dataM?['countU'] ?? ""}",
                                                                  style: appTextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: ColorRes
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                      const Spacer(),
                                                      Text(
                                                        dataM?['lastMessageTime'] ==
                                                                null
                                                            ? ""
                                                            : " ${getFormattedTime(dataM?['lastMessageTime'].toDate() ?? "")}",
                                                        style: appTextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(width: 10),
                                                ],
                                              ),
                                            ),
                                          )
                                        : const SizedBox()
                                    : const SizedBox();
                              },
                            );
                          });
                    }),
              );
      });
}

Widget unread() {
  return GetBuilder<ChatBoxController>(
      id: "searchChat",
      builder: (controller) {
        return controller.searchController.text.isEmpty
            ? Expanded(
                child: ListView.builder(
                    itemCount: controller.dataChat.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          controller.lastMessageTrue(
                              controller.dataChat[index]["id"]);

                          controller.gotoChatScreen(
                              context,
                              controller.dataChat[index]["id"],
                              controller.dataChat[index]['userName'],
                              controller.dataChat[index]['deviceToken']);
                        },
                        child: Container(
                          height: 92,
                          width: Get.width,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 4),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              border: Border.all(
                                color: const Color(0xffF3ECFF),
                              ),
                              color: ColorRes.white),
                          child: Row(
                            children: [
                              Image.asset(
                                AssetRes.airBnbLogo,
                              ),
                              const SizedBox(width: 20),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.dataChat[index]["name"],
                                    style: appTextStyle(
                                        color: ColorRes.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    controller.dataChat[index]["lastMessage"],
                                    style: appTextStyle(
                                        color: ColorRes.black.withOpacity(0.8),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 22,
                                    width: 22,
                                    // decoration: BoxDecoration(
                                    //   gradient: const LinearGradient(
                                    //     colors: [
                                    //       ColorRes.gradientColor,
                                    //       ColorRes.containerColor
                                    //     ],
                                    //   ),
                                    //   borderRadius: BorderRadius.circular(22),
                                    // ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: ColorRes.blukersOrangeColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        controller.dataChat[index]["count"]
                                            .toString(),
                                        style: appTextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: ColorRes.white),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    getFormattedTime(controller.dataChat[index]
                                                ["time"]
                                            .toDate())
                                        .toString(),
                                    style: appTextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ),
                      );
                    }))
            : Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection("Apply")
                        .snapshots(),
                    /*FirebaseFirestore.instance
                .collection("Auth")
                .doc("User")
                .collection("register")
                .snapshots(),*/
                    builder: (context, snapshot) {
                      if (snapshot.data == null || snapshot.hasData == false) {
                        return const CommonLoader();
                      }

                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            String? o;

                            snapshot.data!.docs[index]['companyName']
                                .forEach((element) {
                              if (element.toString().toLowerCase() ==
                                  PrefService.getString(PrefKeys.companyName)
                                      .toString()
                                      .toLowerCase()) {
                                //userName.add(snapshot.data!.docs[index]['userName']);

                                o = element;
                              }
                            });

                            /* userName.forEach((element) {
                            u = element;
                          });*/

                            return StreamBuilder<
                                DocumentSnapshot<Map<String, dynamic>>>(
                              stream: FirebaseFirestore.instance
                                  .collection('chats')
                                  .doc(controller.getChatId(controller.userUid,
                                      snapshot.data!.docs[index].id))
                                  .snapshots(),
                              builder: (context, snapshotM) {
                                if (snapshotM.data == null ||
                                    snapshotM.hasData == false) {
                                  return const SizedBox();
                                }

                                Map<String, dynamic>? dataM =
                                    snapshotM.data?.data();

                                return (o.toString().toLowerCase() ==
                                        PrefService.getString(
                                                PrefKeys.companyName)
                                            .toString()
                                            .toLowerCase())
                                    ? (snapshot.data!.docs[index]['userName']
                                                .toString()
                                                .contains(controller
                                                    .searchText.value.capitalize
                                                    .toString()) ||
                                            snapshot
                                                .data!.docs[index]['userName']
                                                .toString()
                                                .contains(controller
                                                    .searchText.value
                                                    .toLowerCase()
                                                    .toString()))
                                        ? InkWell(
                                            onTap: () async {
                                              controller.lastMessageTrue(
                                                  snapshot
                                                      .data!.docs[index].id);

                                              controller.gotoChatScreen(
                                                  context,
                                                  snapshot.data!.docs[index].id,
                                                  snapshot.data!.docs[index]
                                                      ['userName'],
                                                  snapshot.data!.docs[index]
                                                      ['deviceToken']);
                                            },
                                            child: Container(
                                              height: 92,
                                              width: Get.width,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 18,
                                                      vertical: 4),
                                              padding: const EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(15)),
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xffF3ECFF),
                                                  ),
                                                  color: ColorRes.white),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    AssetRes.airBnbLogo,
                                                  ),
                                                  const SizedBox(width: 20),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        snapshot.data!
                                                                .docs[index]
                                                            ['userName'],
                                                        style: appTextStyle(
                                                            color:
                                                                ColorRes.black,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      const SizedBox(height: 6),
                                                      Text(
                                                        dataM?['lastMessage'] ??
                                                            "",
                                                        style: appTextStyle(
                                                            color: ColorRes
                                                                .black
                                                                .withOpacity(
                                                                    0.8),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
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
                                                      (dataM?['countU'] == 0 ||
                                                              dataM?['countU'] ==
                                                                  null)
                                                          ? const SizedBox()
                                                          : Container(
                                                              height: 22,
                                                              width: 22,
                                                              decoration:
                                                                  BoxDecoration(
                                                                gradient:
                                                                    const LinearGradient(
                                                                  colors: [
                                                                    ColorRes
                                                                        .gradientColor,
                                                                    ColorRes
                                                                        .containerColor
                                                                  ],
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            22),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 5),
                                                                child: Text(
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  "${dataM?['countU'] ?? ""}",
                                                                  style: appTextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: ColorRes
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                      const Spacer(),
                                                      Text(
                                                        dataM?['lastMessageTime'] ==
                                                                null
                                                            ? ""
                                                            : " ${getFormattedTime(dataM?['lastMessageTime'].toDate() ?? "")}",
                                                        style: appTextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(width: 10),
                                                ],
                                              ),
                                            ),
                                          )
                                        : const SizedBox()
                                    : const SizedBox();
                              },
                            );
                          });
                    }),
              );
      });
}

///delete chat flow done
/*
Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection("Apply")
                      .snapshots(),
                  /*FirebaseFirestore.instance
                .collection("Auth")
                .doc("User")
                .collection("register")
                .snapshots(),*/
                  builder: (context, snapshot) {
                    if (snapshot.data == null ||
                        snapshot.hasData == false) {
                      return const SizedBox();
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        String? o;

                        snapshot.data!.docs[index]['companyName']
                            .forEach((element) {
                          if (element ==
                              PrefService.getString(
                                  PrefKeys.companyName)
                                  .toString()
                                  .toLowerCase()) {
                            print(element);
                            o = element;
                          }
                        });

                        return Dismissible(
                          confirmDismiss: (DismissDirection direction) async {
                            return await showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 290,
                                  decoration: const BoxDecoration(
                                    color: ColorRes.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(45),
                                      topRight: Radius.circular(45),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
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
                                            Image.asset(
                                              AssetRes.chatbox_Men_Image,
                                            ),
                                            const SizedBox(width: 20),
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  snapshot.data!.docs[index]
                                                  ['Occupation'],
                                                  style: appTextStyle(
                                                      color: ColorRes.black,
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                                const SizedBox(height: 6),
                                                Text(
                                                  "last msg",
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
                                                const Spacer(),
                                                Text(
                                                  "20.00",
                                                  style: appTextStyle(
                                                      fontSize: 12,
                                                      color: ColorRes.black
                                                          .withOpacity(0.8),
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 10),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "Archive this chat?",
                                        style: appTextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: ColorRes.black.withOpacity(0.8)),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            child: Container(
                                              height: 50,
                                              width: 160,
                                              decoration: BoxDecoration(
                                                  color: ColorRes.white,
                                                  borderRadius: const BorderRadius.all(
                                                      Radius.circular(10)),
                                                  border: Border.all(
                                                      color: ColorRes.containerColor)),
                                              child: Center(
                                                child: Text(
                                                  "Cancel",
                                                  style: appTextStyle(
                                                    color: ColorRes.containerColor,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          InkWell(
                                            onTap: () {

                                              //controller.deleteUserChat(snapshot.data!.docs[index].id);

                                             // Navigator.of(context).pop(true);

                                            },
                                            child: Container(
                                              height: 50,
                                              width: 160,
                                              decoration: const BoxDecoration(
                                                gradient: LinearGradient(colors: [
                                                  ColorRes.gradientColor,
                                                  ColorRes.containerColor,
                                                ]),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Yes, Archived",
                                                  style: appTextStyle(
                                                    color: ColorRes.white,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          key: Key("INDEX$index"),
                          background: Container(
                            alignment: Alignment.centerRight,
                            decoration: BoxDecoration(
                              color: ColorRes.deleteColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Icon(
                              Icons.archive,
                              size: 40,
                              color: ColorRes.starColor,
                            ),
                          ),
                          direction: DismissDirection.endToStart,


                          child: (o.toString().toLowerCase() ==
                              PrefService.getString(
                                  PrefKeys.companyName)
                                  .toString()
                                  .toLowerCase())
                              ? InkWell(
                            onTap: () async {
                              controller.gotoChatScreen(
                                  context,
                                  snapshot.data!.docs[index].id,
                                  snapshot.data!.docs[index]
                                  ['Occupation']);
                            },
                            child: Container(
                              height: 92,
                              width: Get.width,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 4),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius:
                                  const BorderRadius.all(
                                      Radius.circular(15)),
                                  border: Border.all(
                                      color:
                                      const Color(0xffF3ECFF)),
                                  color: ColorRes.white),
                              child: Row(
                                children: [
                                  Image.asset(
                                    AssetRes.airBnbLogo,
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data!.docs[index]
                                        ['Occupation'],
                                        style: appTextStyle(
                                            color: ColorRes.black,
                                            fontSize: 15,
                                            fontWeight:
                                            FontWeight.w500),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        "last msg",
                                        //docData['lastMessage'],
                                        style: appTextStyle(
                                            color: ColorRes.black,
                                            fontSize: 9,
                                            fontWeight:
                                            FontWeight.w400),
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
                                      Container(
                                        height: 22,
                                        width: 22,
                                        decoration: BoxDecoration(
                                          gradient:
                                          const LinearGradient(
                                            colors: [
                                              ColorRes
                                                  .gradientColor,
                                              ColorRes
                                                  .containerColor
                                            ],
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(
                                              22),
                                        ),
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              top: 5),
                                          child: Text(
                                            textAlign:
                                            TextAlign.center,
                                            '1',
                                            style: appTextStyle(
                                                fontSize: 10,
                                                fontWeight:
                                                FontWeight.w400,
                                                color:
                                                ColorRes.white),
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "20.00",
                                        style: appTextStyle(
                                            fontSize: 12,
                                            color: ColorRes.black
                                                .withOpacity(0.8),
                                            fontWeight:
                                            FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                            ),
                          )
                              : SizedBox(),
                        );
                      },
                    );

                  }),
          ),
*/

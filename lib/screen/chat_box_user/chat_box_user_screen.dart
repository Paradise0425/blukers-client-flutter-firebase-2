import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/common/widgets/common_loader.dart';
import 'package:blukers_client_app/common/widgets/helper.dart';
import 'package:blukers_client_app/screen/create_vacancies/create_vacancies_controller.dart';
import 'package:blukers_client_app/screen/dashboard/home/widgets/search_field.dart';
import 'package:blukers_client_app/screen/job_detail_screen/job_detail_upload_cv_screen/upload_cv_controller.dart';
import 'package:blukers_client_app/service/pref_services.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/pref_keys.dart';
import 'package:blukers_client_app/utils/string.dart';
import 'chat_box_usercontroller.dart';

// ignore: must_be_immutable
class ChatBoxUserScreen extends StatelessWidget {
  ChatBoxUserScreen({Key? key}) : super(key: key);
  final controller = Get.put(ChatBoxUserController());
  List p = [];
  bool abc = false;

  //ManagerHomeScreenController managerHomeScreenController = Get.put(ManagerHomeScreenController());
  JobDetailsUploadCvController jobDetailsUploadCvController =
      Get.put(JobDetailsUploadCvController());
  CreateVacanciesController create = Get.put(CreateVacanciesController());
  @override
  Widget build(BuildContext context) {
    jobDetailsUploadCvController.init();
    controller.getUserData();
    return Scaffold(
      backgroundColor: ColorRes.backgroundColor,
      body: Column(children: [
        const SizedBox(height: 50),
        Row(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: logo(),
          ),
          const SizedBox(width: 80),
          Center(
            child: Text(
              Strings.chatBox,
              style: appTextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  height: 1,
                  color: ColorRes.black),
            ),
          ),
        ]),
        const SizedBox(height: 20),
        searchAreaChatU(),
        const SizedBox(height: 20),
        GetBuilder<ChatBoxUserController>(
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
        GetBuilder<ChatBoxUserController>(
          id: "searchChat",
          builder: (controller) {
            return controller.selectedJobs.value == 0
                ? GetBuilder<ChatBoxUserController>(
                    id: "searchChat",
                    builder: (controller) {
                      return controller.searchController.text.isEmpty
                          ? Expanded(
                              child: StreamBuilder<
                                  QuerySnapshot<Map<String, dynamic>>>(
                                stream: FirebaseFirestore.instance
                                    .collection("Auth")
                                    .doc("Manager")
                                    .collection("register")
                                    .snapshots(),
                                builder: (context, snapshot1) {
                                  if (snapshot1.data == null ||
                                      snapshot1.hasData == false) {
                                    return const SizedBox();
                                  }

                                  return ListView.builder(
                                      itemCount: snapshot1.data?.docs.length,
                                      itemBuilder: (context, index) {
                                        return StreamBuilder<
                                            DocumentSnapshot<
                                                Map<String, dynamic>>>(
                                          stream: FirebaseFirestore.instance
                                              .collection('Auth')
                                              .doc('Manager')
                                              .collection('register')
                                              .doc(snapshot1
                                                  .data!.docs[index].id)
                                              .collection('company')
                                              .doc('details')
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.active) {
                                              if (snapshot.hasData) {
                                                // return Home_Screen();
                                              } else if (snapshot.hasError) {
                                                return Center(
                                                  child:
                                                      Text('${snapshot.error}'),
                                                );
                                              }
                                            } else if (snapshot
                                                    .connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                  child: CommonLoader());
                                            }
                                            Map<String, dynamic>? data =
                                                snapshot.data?.data();
                                            if (data == null) {
                                              return const SizedBox();
                                            }

                                            return StreamBuilder<
                                                DocumentSnapshot<
                                                    Map<String, dynamic>>>(
                                              stream: FirebaseFirestore.instance
                                                  .collection('chats')
                                                  .doc(controller.getChatId(
                                                      controller.userUid,
                                                      snapshot1.data!
                                                          .docs[index].id))
                                                  .snapshots(),
                                              builder: (context, snapshotM) {
                                                if (snapshotM.data == null ||
                                                    snapshotM.hasData ==
                                                        false) {
                                                  return const SizedBox();
                                                }

                                                Map<String, dynamic>? dataM =
                                                    snapshotM.data?.data();
                                                controller.dataChatUser = [];
                                                if (dataM?['countM'] != null) {
                                                  controller.dataChatUser.add({
                                                    "name": data['name'],
                                                    "count": dataM!['countM'],
                                                    "image": create.url,
                                                    "time": dataM[
                                                        'lastMessageTime'],
                                                    "lastMessage":
                                                        dataM['lastMessage'],
                                                    "id": snapshot1
                                                        .data!.docs[index].id,
                                                    "deviceToken":
                                                        data['deviceToken']
                                                            .toString(),
                                                    "userName": data['userName']
                                                  });
                                                }
                                                if (kDebugMode) {
                                                  if (kDebugMode) {
                                                    print(controller
                                                        .dataChatUser);
                                                  }
                                                }
                                                String? o;

                                                // ignore: avoid_function_literals_in_foreach_calls
                                                companyList.forEach((element) {
                                                  if (element['companyName']
                                                          .toString()
                                                          .toLowerCase() ==
                                                      data['name']
                                                          .toString()
                                                          .toLowerCase()) {
                                                    o = element['companyName'];
                                                  }
                                                });

                                                return (o
                                                            .toString()
                                                            .toLowerCase() ==
                                                        data['name']
                                                            .toString()
                                                            .toLowerCase())
                                                    ? InkWell(
                                                        onTap: () async {
                                                          controller
                                                              .lastMessageTrue(
                                                                  snapshot1
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                      .id);

                                                          controller.gotoChatScreen(
                                                              context,
                                                              snapshot1
                                                                  .data!
                                                                  .docs[index]
                                                                  .id,
                                                              data['name'],
                                                              data['deviceToken']
                                                                  .toString());
                                                        },
                                                        child: Container(
                                                          height: 92,
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
                                                          child: Row(
                                                            children: [
                                                              (create.url == "")
                                                                  ? const Image(
                                                                      image: AssetImage(
                                                                          AssetRes
                                                                              .airBnbLogo),
                                                                      height:
                                                                          100,
                                                                    )
                                                                  : Image(
                                                                      image: NetworkImage(
                                                                          create
                                                                              .url),
                                                                      height:
                                                                          100,
                                                                    ),
                                                              /*
                                                      Image.asset(
                                                        AssetRes.airBnbLogo,
                                                      ),*/
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
                                                                    data[
                                                                        'name'],
                                                                    style: appTextStyle(
                                                                        color: ColorRes
                                                                            .black,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          6),
                                                                  Text(
                                                                    dataM?['lastMessage'] ??
                                                                        "",
                                                                    style: appTextStyle(
                                                                        color: ColorRes.black.withOpacity(
                                                                            0.8),
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  ),
                                                                ],
                                                              ),
                                                              const Spacer(),
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  (dataM?['countM'] ==
                                                                              0 ||
                                                                          dataM?['countM'] ==
                                                                              null)
                                                                      ? const SizedBox()
                                                                      : Container(
                                                                          height:
                                                                              22,
                                                                          width:
                                                                              22,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            gradient:
                                                                                const LinearGradient(
                                                                              colors: [
                                                                                ColorRes.gradientColor,
                                                                                ColorRes.containerColor
                                                                              ],
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(22),
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(top: 5),
                                                                            child:
                                                                                Text(
                                                                              textAlign: TextAlign.center,
                                                                              "${dataM?['countM'] ?? ""}",
                                                                              style: appTextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: ColorRes.white),
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
                                                                        fontSize:
                                                                            12,
                                                                        color: ColorRes
                                                                            .black
                                                                            .withOpacity(
                                                                                0.8),
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  width: 10),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : const SizedBox();
                                              },
                                            );
                                          },
                                        );
                                      });
                                },
                              ),
                            )
                          : Expanded(
                              child: StreamBuilder<
                                  QuerySnapshot<Map<String, dynamic>>>(
                                stream: FirebaseFirestore.instance
                                    .collection("Auth")
                                    .doc("Manager")
                                    .collection("register")
                                    .snapshots(),
                                builder: (context, snapshot1) {
                                  if (snapshot1.data == null ||
                                      snapshot1.hasData == false) {
                                    return const SizedBox();
                                  }

                                  return ListView.builder(
                                      itemCount: snapshot1.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        return StreamBuilder<
                                            DocumentSnapshot<
                                                Map<String, dynamic>>>(
                                          stream: FirebaseFirestore.instance
                                              .collection('Auth')
                                              .doc('Manager')
                                              .collection('register')
                                              .doc(snapshot1
                                                  .data!.docs[index].id)
                                              .collection('company')
                                              .doc('details')
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            Map<String, dynamic>? data =
                                                snapshot.data?.data();
                                            if (data == null) {
                                              return const SizedBox();
                                            }

                                            return StreamBuilder<
                                                DocumentSnapshot<
                                                    Map<String, dynamic>>>(
                                              stream: FirebaseFirestore.instance
                                                  .collection('chats')
                                                  .doc(controller.getChatId(
                                                      controller.userUid,
                                                      snapshot1.data!
                                                          .docs[index].id))
                                                  .snapshots(),
                                              builder: (context, snapshotM) {
                                                if (snapshotM.data == null ||
                                                    snapshotM.hasData ==
                                                        false) {
                                                  return const SizedBox();
                                                }

                                                Map<String, dynamic>? dataM =
                                                    snapshotM.data?.data();

                                                String? o;

                                                // ignore: avoid_function_literals_in_foreach_calls
                                                companyList.forEach((element) {
                                                  if (element['companyname']
                                                          .toString()
                                                          .toLowerCase() ==
                                                      data['name']
                                                          .toString()
                                                          .toLowerCase()) {
                                                    o = element['companyname'];
                                                  }
                                                });

                                                if (o.toString().contains(
                                                        controller.searchText
                                                            .value.capitalize
                                                            .toString()) ||
                                                    o.toString().contains(
                                                        controller
                                                            .searchText.value
                                                            .toLowerCase()
                                                            .toString())) {
                                                  return InkWell(
                                                    onTap: () async {
                                                      controller
                                                          .lastMessageTrue(
                                                              snapshot1
                                                                  .data!
                                                                  .docs[index]
                                                                  .id);

                                                      controller.gotoChatScreen(
                                                          context,
                                                          snapshot1.data!
                                                              .docs[index].id,
                                                          data['name'],
                                                          data['deviceToken']
                                                              .toString());
                                                    },
                                                    child: Container(
                                                      height: 92,
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
                                                                  Radius
                                                                      .circular(
                                                                          15)),
                                                          border: Border.all(
                                                              color: const Color(
                                                                  0xffF3ECFF)),
                                                          color:
                                                              ColorRes.white),
                                                      child: Row(
                                                        children: [
                                                          Image.asset(
                                                            AssetRes.airBnbLogo,
                                                          ),
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
                                                                data['name'],
                                                                style: appTextStyle(
                                                                    color: ColorRes
                                                                        .black,
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              const SizedBox(
                                                                  height: 6),
                                                              Text(
                                                                dataM?['lastMessage'] ??
                                                                    "",
                                                                style: appTextStyle(
                                                                    color: ColorRes
                                                                        .black
                                                                        .withOpacity(
                                                                            0.8),
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                          const Spacer(),
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              (dataM?['countM'] ==
                                                                          0 ||
                                                                      dataM?['countM'] ==
                                                                          null)
                                                                  ? const SizedBox()
                                                                  : Container(
                                                                      height:
                                                                          22,
                                                                      width: 22,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        gradient:
                                                                            const LinearGradient(
                                                                          colors: [
                                                                            ColorRes.gradientColor,
                                                                            ColorRes.containerColor
                                                                          ],
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(22),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(top: 5),
                                                                        child:
                                                                            Text(
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          "${dataM?['countM'] ?? ""}",
                                                                          style: appTextStyle(
                                                                              fontSize: 10,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: ColorRes.white),
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
                                                                    fontSize:
                                                                        12,
                                                                    color: ColorRes
                                                                        .black
                                                                        .withOpacity(
                                                                            0.8),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return const SizedBox();
                                                }
                                              },
                                            );
                                          },
                                        );
                                      });
                                },
                              ),
                            );
                    })
                : unread();
          },
        ),
      ]),
    );
  }
}

Widget allChat() {
  return GetBuilder<ChatBoxUserController>(
      id: "searchChat",
      builder: (controller) {
        CreateVacanciesController create = Get.put(CreateVacanciesController());
        return controller.searchController.text.isEmpty
            ? Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection("Auth")
                      .doc("Manager")
                      .collection("register")
                      .snapshots(),
                  builder: (context, snapshot1) {
                    if (snapshot1.data == null || snapshot1.hasData == false) {
                      return const SizedBox();
                    }

                    return ListView.builder(
                        itemCount: snapshot1.data!.docs.length,
                        itemBuilder: (context, index) {
                          return StreamBuilder<
                              DocumentSnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection('Auth')
                                .doc('Manager')
                                .collection('register')
                                .doc(snapshot1.data!.docs[index].id)
                                .collection('company')
                                .doc('details')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.active) {
                                if (snapshot.hasData) {
                                  // return Home_Screen();
                                } else if (snapshot.hasError) {
                                  return Center(
                                    child: Text('${snapshot.error}'),
                                  );
                                }
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(child: CommonLoader());
                              }
                              Map<String, dynamic>? data =
                                  snapshot.data?.data();
                              if (data == null) {
                                return const SizedBox();
                              }

                              return StreamBuilder<
                                  DocumentSnapshot<Map<String, dynamic>>>(
                                stream: FirebaseFirestore.instance
                                    .collection('chats')
                                    .doc(controller.getChatId(
                                        controller.userUid,
                                        snapshot1.data!.docs[index].id))
                                    .snapshots(),
                                builder: (context, snapshotM) {
                                  if (snapshotM.data == null ||
                                      snapshotM.hasData == false) {
                                    return const SizedBox();
                                  }

                                  Map<String, dynamic>? dataM =
                                      snapshotM.data?.data();

                                  String? o;

                                  // ignore: avoid_function_literals_in_foreach_calls
                                  companyList.forEach((element) {
                                    if (element['companyname']
                                            .toString()
                                            .toLowerCase() ==
                                        data['name'].toString().toLowerCase()) {
                                      o = element['companyname'];
                                    }
                                  });

                                  return (o.toString().toLowerCase() ==
                                          data['name'].toString().toLowerCase())
                                      ? InkWell(
                                          onTap: () async {
                                            controller.lastMessageTrue(
                                                snapshot1.data!.docs[index].id);

                                            controller.gotoChatScreen(
                                                context,
                                                snapshot1.data!.docs[index].id,
                                                data['name'],
                                                data['deviceToken'].toString());
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
                                                  color:
                                                      const Color(0xffF3ECFF),
                                                ),
                                                color: ColorRes.white),
                                            child: Row(
                                              children: [
                                                (create.url == "")
                                                    ? const Image(
                                                        image: AssetImage(
                                                            AssetRes
                                                                .airBnbLogo),
                                                        height: 100,
                                                      )
                                                    : Image(
                                                        image: NetworkImage(
                                                            create.url),
                                                        height: 100,
                                                      ),
                                                /*
                                                      Image.asset(
                                                        AssetRes.airBnbLogo,
                                                      ),*/
                                                const SizedBox(width: 20),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      data['name'],
                                                      style: appTextStyle(
                                                          color: ColorRes.black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const SizedBox(height: 6),
                                                    Text(
                                                      dataM?['lastMessage'] ??
                                                          "",
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
                                                    (dataM?['countM'] == 0 ||
                                                            dataM?['countM'] ==
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
                                                                "${dataM?['countM'] ?? ""}",
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
                                      : const SizedBox();
                                },
                              );
                            },
                          );
                        });
                  },
                ),
              )
            : Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection("Auth")
                      .doc("Manager")
                      .collection("register")
                      .snapshots(),
                  builder: (context, snapshot1) {
                    if (snapshot1.data == null || snapshot1.hasData == false) {
                      return const SizedBox();
                    }

                    return ListView.builder(
                        itemCount: snapshot1.data!.docs.length,
                        itemBuilder: (context, index) {
                          return StreamBuilder<
                              DocumentSnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection('Auth')
                                .doc('Manager')
                                .collection('register')
                                .doc(snapshot1.data!.docs[index].id)
                                .collection('company')
                                .doc('details')
                                .snapshots(),
                            builder: (context, snapshot) {
                              Map<String, dynamic>? data =
                                  snapshot.data?.data();
                              if (data == null) {
                                return const SizedBox();
                              }

                              return StreamBuilder<
                                  DocumentSnapshot<Map<String, dynamic>>>(
                                stream: FirebaseFirestore.instance
                                    .collection('chats')
                                    .doc(controller.getChatId(
                                        controller.userUid,
                                        snapshot1.data!.docs[index].id))
                                    .snapshots(),
                                builder: (context, snapshotM) {
                                  if (snapshotM.data == null ||
                                      snapshotM.hasData == false) {
                                    return const SizedBox();
                                  }

                                  Map<String, dynamic>? dataM =
                                      snapshotM.data?.data();

                                  String? o;

                                  companyList.
                                      // ignore: avoid_function_literals_in_foreach_calls
                                      forEach((element) {
                                    if (element['companyname']
                                            .toString()
                                            .toLowerCase() ==
                                        data['name'].toString().toLowerCase()) {
                                      o = element['companyname'];
                                    }
                                  });

                                  if (o.toString().contains(controller
                                          .searchText.value.capitalize
                                          .toString()) ||
                                      o.toString().contains(controller
                                          .searchText.value
                                          .toLowerCase()
                                          .toString())) {
                                    return InkWell(
                                      onTap: () async {
                                        controller.lastMessageTrue(
                                            snapshot1.data!.docs[index].id);

                                        controller.gotoChatScreen(
                                            context,
                                            snapshot1.data!.docs[index].id,
                                            data['name'],
                                            data['deviceToken'].toString());
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
                                                color: const Color(0xffF3ECFF)),
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
                                                  data['name'],
                                                  style: appTextStyle(
                                                      color: ColorRes.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                const SizedBox(height: 6),
                                                Text(
                                                  dataM?['lastMessage'] ?? "",
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
                                                (dataM?['countM'] == 0 ||
                                                        dataM?['countM'] ==
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
                                                                  .circular(22),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(top: 5),
                                                          child: Text(
                                                            textAlign: TextAlign
                                                                .center,
                                                            "${dataM?['countM'] ?? ""}",
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
                                                  dataM?['lastMessageTime'] ==
                                                          null
                                                      ? ""
                                                      : " ${getFormattedTime(dataM?['lastMessageTime'].toDate() ?? "")}",
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
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              );
                            },
                          );
                        });
                  },
                ),
              );
      });
}

Widget unread() {
  return GetBuilder<ChatBoxUserController>(
      id: "searchChat",
      builder: (controller) {
        return controller.searchController.text.isEmpty
            ? Expanded(
                child: ListView.builder(
                    itemCount: controller.dataChatUser.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          controller.lastMessageTrue(
                              controller.dataChatUser[index]["id"]);

                          controller.gotoChatScreen(
                              context,
                              controller.dataChatUser[index]["id"],
                              controller.dataChatUser[index]['userName'],
                              controller.dataChatUser[index]['deviceToken']);
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
                                    controller.dataChatUser[index]["name"],
                                    style: appTextStyle(
                                        color: ColorRes.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    controller.dataChatUser[index]
                                        ["lastMessage"],
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
                                        controller.dataChatUser[index]["count"]
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
                                    getFormattedTime(controller
                                            .dataChatUser[index]["time"]
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

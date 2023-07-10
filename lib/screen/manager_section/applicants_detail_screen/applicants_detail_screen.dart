import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/screen/call/video_receive_screen.dart';
import 'package:blukers_client_app/screen/chat_box/chat_box_screen.dart';
import 'package:blukers_client_app/screen/manager_section/Notification/notification_services.dart';
import 'package:blukers_client_app/screen/manager_section/applicants_detail_screen/applicants_detail_screen_widget/applicants_details_screen_widget.dart';
import 'package:blukers_client_app/screen/manager_section/applicants_detail_screen/applicants_details_controller.dart';
import 'package:blukers_client_app/screen/manager_section/dashboard/manager_dashboard_screen.dart';
import 'package:blukers_client_app/screen/manager_section/dashboard/manager_dashboard_screen_controller.dart';
import 'package:blukers_client_app/screen/manager_section/manager_home_screen/manager_home_screen_widget/manager_home_screen_widget.dart';
import 'package:blukers_client_app/service/pref_services.dart';
import 'package:blukers_client_app/utils/app_res.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/pref_keys.dart';
import 'package:blukers_client_app/utils/string.dart';

// ignore: must_be_immutable
class ApplicantsDetailScreen extends StatelessWidget {
  dynamic args = Get.arguments;
  final bool isWrong;

  ApplicantsDetailScreen({
    Key? key,
    required this.isWrong,
  }) : super(key: key);
  final ApplicantsDetailsController controller =
      Get.put(ApplicantsDetailsController());
  ApplicantsDetailsController ans = Get.put(ApplicantsDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(children: [
        const SizedBox(
          height: 60,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              Container(
                height: 40,
                width: 40,
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: ColorRes.logoColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () {
                    controller.selectedValue = "";
                    controller.msgController.clear();
                    controller.msgController.text = "";
                    controller.showTime = "Hour";
                    controller.showDate = "Date";
                    // Get.back();
                    ManagerDashBoardScreenController controller2 =
                        Get.find<ManagerDashBoardScreenController>();
                    controller2.currentTab.value = 1;
                    controller2.update(["bottom_bar"]);
                    Get.offAll(() => ManagerDashBoardScreen(),
                        arguments: {"index": "1"});
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: ColorRes.containerColor,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    Strings.applicants,
                    style: appTextStyle(color: ColorRes.black, fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: MediaQuery.of(context).viewInsets.bottom > 0
              ? Get.height * 0.5
              : Get.height * 0.8,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GetBuilder<ApplicantsDetailsController>(
                    id: "drop",
                    builder: (controller) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorRes.borderColor),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: ColorRes.black,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Image(
                                      image: AssetImage(AssetRes.detailsImage),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        args['userName'],
                                        style: appTextStyle(
                                            color: ColorRes.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        args['Occupation'],
                                        style: appTextStyle(
                                            color: ColorRes.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (con) => ChatBoxScreen(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: ColorRes.logoColor,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const GradientIcon(
                                        Icons.chat,
                                        20,
                                        LinearGradient(colors: [
                                          ColorRes.gradientColor,
                                          ColorRes.containerColor,
                                        ]),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  /*   InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (con) =>
                                              const VideoReceiveScreen(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: ColorRes.logoColor,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const GradientIcon(
                                        Icons.videocam_sharp,
                                        20,
                                        LinearGradient(colors: [
                                          ColorRes.gradientColor,
                                          ColorRes.containerColor,
                                        ]),
                                      ),
                                    ),
                                  ),*/
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            color: ColorRes.lightGrey,
                            height: 2,
                            width: Get.width,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () => Get.toNamed(AppRes.resumeScreen,
                                arguments: {"doc": args['resumeUrl']}),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: ColorRes.blukersOrangeColor,
                                // gradient: const LinearGradient(colors: [
                                //   ColorRes.gradientColor,
                                //   ColorRes.containerColor
                                // ]),
                              ),
                              child: Center(
                                child: Text(
                                  Strings.seeResume,
                                  style: appTextStyle(
                                      color: ColorRes.white, fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: ColorRes.white,
                              border: Border.all(
                                  color: controller.selectedValue == "Rejected"
                                      ? ColorRes.red
                                      : (controller.selectedValue == "Accepted"
                                          ? ColorRes.darkGreen
                                          : ColorRes.containerColor),
                                  width: 2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: controller.selectedValue == "Rejected"
                                      ? ColorRes.red
                                      : (controller.selectedValue == "Accepted"
                                          ? ColorRes.darkGreen
                                          : ColorRes.containerColor),
                                ),
                                isExpanded: true,
                                value: controller.selectedValue == ""
                                    ? null
                                    : controller.selectedValue,
                                items: controller.list.map((e) {
                                  return DropdownMenuItem<String>(
                                    value: e,
                                    child: Text(
                                      e.toString(),
                                      style: appTextStyle(
                                          color: controller.selectedValue ==
                                                  "Rejected"
                                              ? ColorRes.red
                                              : (controller.selectedValue ==
                                                      "Accepted"
                                                  ? ColorRes.darkGreen
                                                  : ColorRes.containerColor),
                                          fontSize: 14),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  controller.status = value!;
                                  controller.onChangeStatus(value);
                                },
                                hint: Text(
                                  Strings.markStatusAs,
                                  style: appTextStyle(
                                      color: ColorRes.containerColor,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            color: ColorRes.grey.withOpacity(0.15),
                            height: 1,
                            width: Get.width,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          controller.selectedValue == "Schedule Interview"
                              ? Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: dateTimeBox(
                                                text: "Date",
                                                image: AssetRes.calender,
                                                onTap: controller.selectDate,
                                                value: controller.showDate,
                                                context: context),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: dateTimeBox(
                                                text: "Hour",
                                                image: AssetRes.time,
                                                onTap: controller.selectTime,
                                                value: controller.showTime,
                                                context: context),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      Strings.message,
                                      style: appTextStyle(
                                          color: ColorRes.black2, fontSize: 16),
                                    ),
                                  ),
                                  Text(
                                    "*",
                                    style: appTextStyle(color: ColorRes.red),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      color: ColorRes.containerColor,
                                      width: 1.5),
                                ),
                                child: TextFormField(
                                  controller: controller.msgController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Message"),
                                  maxLines: 6,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                InkWell(
                  onTap: () {
                    if (controller.status == null || controller.status == "") {
                      Get.snackbar(
                          "Error", "Select Status & Write Your Message",
                          colorText: const Color(0xffDA1414));
                    }
                    if (controller.msgController.text.isEmpty ||
                        controller.msgController.text == "") {
                      Get.snackbar("Error", "Write Your Message",
                          colorText: const Color(0xffDA1414));
                    } else {
                      FocusScopeNode currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }

                      settingModalBottomSheet(
                          context, isWrong, controller, args);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: Get.width,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: ColorRes.blukersOrangeColor,
                      // gradient: const LinearGradient(colors: [
                      //   ColorRes.gradientColor,
                      //   ColorRes.containerColor
                      // ]),
                    ),
                    child: Center(
                      child: Text(
                        Strings.sendToApplicants,
                        style:
                            appTextStyle(color: ColorRes.white, fontSize: 20),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}

void settingModalBottomSheet(
    context, bool isWrong, ApplicantsDetailsController controller, var args) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return (isWrong == false)
            ? Container(
                height: 390,
                decoration: const BoxDecoration(
                  color: ColorRes.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Image.asset(AssetRes.successImage, height: 130),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        Strings.successful,
                        style: appTextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: ColorRes.containerColor),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:
                            Text("Notifications have been sent to applicants..",
                                style: appTextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: ColorRes.black.withOpacity(0.6),
                                ),
                                textAlign: TextAlign.center),
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () async {
                        ApplicantsDetailsController anscontro =
                            Get.put(ApplicantsDetailsController());

                        SendNotificationModel notification =
                            SendNotificationModel(
                                title:
                                    PrefService.getString(PrefKeys.companyName),
                                body: anscontro.selectedValue,
                                fcmTokens: [
                              args['deviceToken'],
                            ]);
                        NotificationService.sendNotification(notification);

                        // Get.back();
                        ManagerDashBoardScreenController controller2 =
                            Get.find<ManagerDashBoardScreenController>();
                        controller2.currentTab.value = 1;
                        controller2.update(["bottom_bar"]);
                        Get.offAll(() => ManagerDashBoardScreen(),
                            arguments: {"index": "1"});
                        // Navigator.of(context).pop();

                        await FirebaseFirestore.instance
                            .collection("Applicants")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .set({
                          'companyName':
                              PrefService.getString(PrefKeys.companyName),
                        });
                        String? position;
                        args['companyName'].forEach((e) {
                          if (e['companyname'] ==
                              PrefService.getString(PrefKeys.companyName)) {
                            position = e['position'].toString();

                            if (kDebugMode) {
                              print(position);
                            }
                          }
                        });

                        await FirebaseFirestore.instance
                            .collection("Applicants")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("userDetails")
                            .doc(args['uid'])
                            .set({
                          'userName': args['userName'],
                          'status': controller.selectedValue,
                          'userUid': args['uid'],
                          'message': controller.msgController.text,
                          'userOccupation': args['Occupation'],
                          'position': position,
                          'salary': args['salary'],
                          'location': args['location'],
                          'type': args['type']
                        });

                        controller.selectedValue = "";
                        controller.msgController.clear();
                        controller.msgController.text = "";
                        controller.showTime = "Hour";
                        controller.showDate = "Date";
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        margin:
                            const EdgeInsets.only(right: 18, left: 18, top: 10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          gradient: LinearGradient(colors: [
                            ColorRes.gradientColor,
                            ColorRes.containerColor,
                          ]),
                        ),
                        child: Text(
                          Strings.ok,
                          style: appTextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                height: 390,
                decoration: const BoxDecoration(
                  color: ColorRes.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Image.asset(AssetRes.failedImage, height: 130),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        Strings.oopsFailed,
                        style: appTextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: ColorRes.starColor),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(Strings.pleaseMakeSureThatYour,
                            style: appTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: ColorRes.black.withOpacity(0.6),
                            ),
                            textAlign: TextAlign.center),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      margin:
                          const EdgeInsets.only(right: 18, left: 18, top: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        gradient: LinearGradient(colors: [
                          ColorRes.gradientColor,
                          ColorRes.containerColor,
                        ]),
                      ),
                      child: Text(
                        Strings.tryAgain,
                        style: appTextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              );
      });
}

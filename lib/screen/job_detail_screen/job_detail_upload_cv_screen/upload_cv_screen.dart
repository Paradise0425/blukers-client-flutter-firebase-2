import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/screen/job_detail_screen/job_detail_upload_cv_screen/upload_cv_controller.dart';
import 'package:blukers_client_app/screen/job_detail_screen/job_detail_widget/job_details_appbar.dart';
import 'package:blukers_client_app/screen/manager_section/Notification/notification_services.dart';
import 'package:blukers_client_app/service/pref_services.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/pref_keys.dart';
import 'package:blukers_client_app/utils/string.dart';

// ignore: must_be_immutable
class JobDetailsUploadCvScreen extends StatelessWidget {
  JobDetailsUploadCvScreen({Key? key}) : super(key: key);
  final JobDetailsUploadCvController controller =
      Get.put(JobDetailsUploadCvController());
  var args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.backgroundColor,
      body: WillPopScope(
        onWillPop: () async {
          Get.back();
          controller.filepath.value = "";
          return true;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              jobDetailsAppBar(controller),
              SizedBox(
                height: Get.height - 100,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        height: 92,
                        width: Get.width,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            border: Border.all(color: const Color(0xffF3ECFF)),
                            color: ColorRes.white),
                        child: Row(
                          children: [
                            Image.asset(AssetRes.airBnbLogo),
                            const SizedBox(width: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  args["doc"]["Position"],
                                  style: appTextStyle(
                                      color: ColorRes.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  args["doc"]["CompanyName"],
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
                      const SizedBox(height: 20),
                      const Divider(
                        thickness: 0.5,
                        color: Color(0xffD9D9D9),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        Strings.uploadResume,
                        style: appTextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: ColorRes.black),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        Strings.uploadYourCvOr,
                        style: appTextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: ColorRes.black),
                      ),

                      ///upload pdf error Container
                      Obx(
                        () => controller.isPdfUploadError.value
                            ? Container(
                                width: Get.width,
                                // height: 28,
                                margin: const EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: ColorRes.invalidColor),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 18,
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Image(
                                        image: AssetImage(
                                          AssetRes.invalid,
                                        ),
                                        height: 25,
                                      ),
                                      const SizedBox(width: 10),
                                      SizedBox(
                                        width: Get.width * 0.65,
                                        child: Text(
                                          "Upload failed,please re-upload your file",
                                          style: appTextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: ColorRes.starColor),
                                        ),
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.clear,
                                        color: ColorRes.starColor,
                                      )
                                    ]),
                              )
                            : const SizedBox(),
                      ),

                      Obx(
                        () => controller.filepath.value != ""
                            ? Container(
                                // height: 82,
                                width: Get.width,
                                margin: const EdgeInsets.only(top: 10),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xffEEEBF4),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  border:
                                      Border.all(color: ColorRes.borderColor),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(AssetRes.pdfIcon, height: 90),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: Get.width * 0.6,
                                          child: Text(
                                            controller.filepath.value,
                                            style: appTextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: ColorRes.black),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "440 kb",
                                          style: appTextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              color: ColorRes.grey),
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        controller.pdfUrl = null;
                                        controller.filepath.value = "";
                                      },
                                      child: const Image(
                                        image: AssetImage(
                                          AssetRes.pdfRemove,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : const SizedBox(),
                      ),

                      GestureDetector(
                        onTap: () {
                          (controller.pdfUrl != "" || controller.pdfUrl == null)
                              ? controller.applyResume()
                              : null;
                        },
                        child: Container(
                          width: Get.width,
                          margin: const EdgeInsets.only(top: 15),
                          padding: const EdgeInsets.only(top: 50, bottom: 40),
                          decoration: BoxDecoration(
                            color: ColorRes.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            border: Border.all(color: ColorRes.borderColor),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(AssetRes.uploadIcon, height: 70),
                              const SizedBox(height: 20),
                              Text(
                                "Upload Resume/CV",
                                style: appTextStyle(
                                    color: ColorRes.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 50),
                      GestureDetector(
                        onTap: () {
                          SendNotificationModel notification =
                              SendNotificationModel(
                                  title:
                                      PrefService.getString(PrefKeys.fullName),
                                  body: "applied your vacancies",
                                  fcmTokens: [
                                args["doc"]["deviceToken"],
                              ]);
                          NotificationService.sendNotification(notification);
                          if (controller.pdfUrl == null ||
                              controller.pdfUrl == "") {
                            Get.snackbar("Error", "Upload Your Resume",
                                colorText: const Color(0xffDA1414));
                          } else {
                            controller.onTapApply(args: args["doc"]);
                          }
                        },
                        child: Obx(() {
                          return Container(
                            height: 50,
                            width: Get.width,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            margin: const EdgeInsets.only(
                                right: 10, left: 10, top: 10, bottom: 30),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              gradient: controller.filepath.value == ""
                                  ? const LinearGradient(colors: [
                                      ColorRes.gradientColor,
                                      ColorRes.containerColor,
                                    ])
                                  : const LinearGradient(colors: [
                                      ColorRes.gradientColor,
                                      ColorRes.containerColor,
                                    ]),
                            ),
                            child: Text(
                              Strings.apply,
                              style: appTextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

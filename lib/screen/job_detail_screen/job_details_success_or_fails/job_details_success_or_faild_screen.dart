import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/screen/dashboard/applications/applications_screen.dart';
import 'package:blukers_client_app/screen/dashboard/dashboard_screen.dart';
import 'package:blukers_client_app/screen/job_detail_screen/job_detail_upload_cv_screen/upload_cv_controller.dart';
import 'package:blukers_client_app/screen/job_detail_screen/job_detail_widget/job_details_appbar.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';

// ignore: must_be_immutable
class JobDetailsSuccessOrFailedScreen extends StatelessWidget {
  JobDetailsSuccessOrFailedScreen({Key? key}) : super(key: key);
  var args = Get.arguments;
  final JobDetailsUploadCvController controller =
      JobDetailsUploadCvController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          await Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return DashBoardScreen();
            },
          ));
          return true;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              jobDetailsSuccessAppBar(context),
              SizedBox(
                height: Get.height - 100,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                Text(args[0]['doc']['Position'],
                                    style: appTextStyle(
                                        color: ColorRes.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                                Text(args[0]['doc']['CompanyName'],
                                    style: appTextStyle(
                                        color: ColorRes.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        width: Get.width,
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xffEEEBF4),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          border: Border.all(color: ColorRes.borderColor),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(AssetRes.pdfIcon, height: 90),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: Get.width * 0.6,
                                  child: Text(
                                    args[1]['filename']
                                        .value /*"Resume - Adam Smith.pdf"*/,
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
                                image: AssetImage(AssetRes.pdfRemove),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Image.asset(
                          args[1]["error"] == false
                              ? AssetRes.successImage
                              : AssetRes.failedImage,
                          height: 130),
                      const SizedBox(height: 10),
                      args[1]["error"] == false
                          ? Text(
                              Strings.successful,
                              style: appTextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: ColorRes.containerColor),
                            )
                          : Text(
                              Strings.failed,
                              style: appTextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: ColorRes.red),
                            ),
                      const SizedBox(height: 5),
                      Text(
                          args[1]["error"] == false
                              ? Strings.youHaveSuccessfullyApplied
                              : Strings.pleaseMakeSureThatYourInternet,
                          style: appTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: ColorRes.grey),
                          textAlign: TextAlign.center),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          if (args[1]["error"] == false) {
                            ///see applied job list tap event
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (con) => ApplicationsScreen()));
                          } else {
                            ///try again tap event
                          }
                        },
                        child: Container(
                          height: 50,
                          width: Get.width,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            gradient: LinearGradient(colors: [
                              ColorRes.gradientColor,
                              ColorRes.containerColor,
                            ]),
                          ),
                          child: Text(
                              args[1]["error"] == false
                                  ? Strings.seeAppliedJobsList
                                  : Strings.tryAgain,
                              style: appTextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (args[1]["error"] == false) {
                            ///discover more jobs
                            Get.offAll(() => DashBoardScreen());
                          } else {
                            ///discover more jobs event
                            Get.offAll(() => DashBoardScreen());
                          }
                        },
                        child: Container(
                          height: 50,
                          width: Get.width,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 10, bottom: 30),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            border: Border.all(color: ColorRes.containerColor),
                          ),
                          child: Text(
                            args[1]["error"] == false
                                ? Strings.discoverMoreJobs
                                : Strings.discoverMoreJobs,
                            style: appTextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: ColorRes.containerColor),
                          ),
                        ),
                      ),
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

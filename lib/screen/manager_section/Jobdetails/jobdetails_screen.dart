import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/screen/create_vacancies/create_vacancies_screen.dart';
import 'package:blukers_client_app/screen/manager_section/Jobdetails/jobdetails_controller.dart';
import 'package:blukers_client_app/screen/manager_section/dashboard/manager_dashboard_screen.dart';
import 'package:blukers_client_app/screen/manager_section/manager_application_screen/manger_application_screen.dart';
import 'package:blukers_client_app/service/pref_services.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/pref_keys.dart';
import 'package:blukers_client_app/utils/string.dart';

// ignore: must_be_immutable
class JobDetailsScreen extends StatelessWidget {
  final bool isError;
  String? position;

  JobDetailsScreen({Key? key, required this.isError, this.position})
      : super(key: key);
  final JobDetailsController controller = Get.put(JobDetailsController());
  // var args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    // debugPrint("Args Print $args");
    return WillPopScope(
      onWillPop: () async {
        await Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return ManagerDashBoardScreen();
          },
        ));
        return true;
      },
      child: Scaffold(
        backgroundColor: ColorRes.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                // Row(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.all(10),
                //       child: InkWell(
                //         onTap: () {
                //           Get.back();
                //         },
                //         child: backButton(),
                //       ),
                //     ),
                //     SizedBox(width: Get.width - 280),
                //     Text(
                //       Strings.jobDetails,
                //       style: appTextStyle(
                //           fontSize: 20,
                //           fontWeight: FontWeight.w500,
                //           height: 1,
                //           color: ColorRes.black),
                //     ),
                //   ],
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Stack(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        padding: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            color: ColorRes.logoColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return ManagerDashBoardScreen();
                              },
                            ));
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
                            Strings.jobDetails,
                            style: appTextStyle(
                                color: ColorRes.black, fontSize: 20),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 92,
                  width: Get.width,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
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
                          Text(
                            position ?? "",
                            style: appTextStyle(
                                color: ColorRes.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            PrefService.getString(PrefKeys.companyName),
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
                const SizedBox(height: 80),
                Center(
                  child: Image.asset(
                      isError == true
                          ? AssetRes.successImage
                          : AssetRes.failedImage,
                      height: 130),
                ),
                const SizedBox(height: 10),
                Center(
                  child: isError == true
                      ? Text(
                          Strings.jobVacancyPosted,
                          style: appTextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: ColorRes.containerColor),
                        )
                      : Text(
                          Strings.oopsFailedToPost,
                          style: appTextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: ColorRes.starColor),
                        ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: isError == false
                        ? Text(Strings.nowYouCanSeeAllTheApplier,
                            style: appTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: ColorRes.black.withOpacity(0.6),
                            ),
                            textAlign: TextAlign.center)
                        : Text(Strings.pleaseMakeSureThatYour,
                            style: appTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: ColorRes.black.withOpacity(0.6),
                            ),
                            textAlign: TextAlign.center),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: GestureDetector(
                    onTap: () {
                      if (isError == false) {
                        ///see applied job list tap event
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (con) => ManagerApplicationScreen()));
                      } else {
                        ///try again tap event
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (con) => ManagerApplicationScreen()));
                      }
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      margin:
                          const EdgeInsets.only(right: 18, left: 18, top: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        gradient: LinearGradient(colors: [
                          ColorRes.gradientColor,
                          ColorRes.containerColor,
                        ]),
                      ),
                      child: Text(
                          isError == true
                              ? Strings.gotoApplications
                              : Strings.tryAgain,
                          style: appTextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: GestureDetector(
                    onTap: () {
                      if (isError == true) {
                        ///discover more jobs
                        Get.offAll(() => const CreateVacanciesScreenM());
                      } else {
                        ///discover more jobs event
                        Get.offAll(() => ManagerDashBoardScreen());
                      }
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      margin: const EdgeInsets.only(
                        right: 18,
                        left: 18,
                      ),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: ColorRes.white,
                          border: Border.all(color: ColorRes.containerColor)),
                      child: Text(
                          isError == true
                              ? Strings.postAnotherVacancy
                              : Strings.backToHome,
                          style: appTextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: ColorRes.containerColor)),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}

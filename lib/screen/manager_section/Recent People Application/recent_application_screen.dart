import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/screen/job_detail_screen/job_detail_upload_cv_screen/upload_cv_controller.dart';
import 'package:blukers_client_app/screen/manager_section/manager_home_screen/manager_home_screen_controller.dart';
import 'package:blukers_client_app/screen/manager_section/manager_home_screen/manager_home_screen_widget/manager_home_screen_widget.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';

// ignore: must_be_immutable
class RecentApplicationScreen extends StatelessWidget {
  RecentApplicationScreen({Key? key}) : super(key: key);
  JobDetailsUploadCvController jobDetailsUploadCvController =
      Get.put(JobDetailsUploadCvController());

  @override
  Widget build(BuildContext context) {
    jobDetailsUploadCvController.init();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorRes.backgroundColor,
      body: Column(
        children: [
          const SizedBox(height: 55),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: backButton(),
                ),
              ),
              SizedBox(width: Get.width - 350),
              Text(
                Strings.recentPeopleApplication,
                style: appTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 1,
                    color: ColorRes.black),
              ),
            ],
          ),
          GetBuilder<ManagerHomeScreenController>(
              id: "userDataSeeAll",
              builder: (con) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: InkWell(
                        //  onTap: () => Get.toNamed(AppRes.applicantsDetails),
                        child: recentPeopleBox()),
                  ),
                );
              }),
        ],
      ),
    );
  }
}

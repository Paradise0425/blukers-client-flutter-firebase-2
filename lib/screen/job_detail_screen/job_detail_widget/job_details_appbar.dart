import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/screen/dashboard/dashboard_screen.dart';
import 'package:blukers_client_app/screen/job_detail_screen/job_detail_upload_cv_screen/upload_cv_controller.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';

Widget jobDetailsAppBar(JobDetailsUploadCvController controller) {
  return Column(
    children: [
      const SizedBox(height: 60),
      SizedBox(
        height: 40,
        width: Get.width,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                    controller.filepath.value = "";
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    padding: const EdgeInsets.only(left: 10),
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
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      AssetRes.bookMarkBorderIcon,
                      height: 21,
                      width: 15,
                    ),
                  ),
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
            )
          ],
        ),
      ),
    ],
  );
}

Widget jobDetailsSuccessAppBar(BuildContext context) {
  return Column(
    children: [
      const SizedBox(height: 60),
      SizedBox(
        height: 40,
        width: Get.width,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return DashBoardScreen();
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    padding: const EdgeInsets.only(left: 10),
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
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      AssetRes.bookMarkBorderIcon,
                      height: 21,
                      width: 15,
                    ),
                  ),
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
            )
          ],
        ),
      ),
    ],
  );
}

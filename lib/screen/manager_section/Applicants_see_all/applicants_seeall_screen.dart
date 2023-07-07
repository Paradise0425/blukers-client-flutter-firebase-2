import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/screen/dashboard/home/widgets/search_field.dart';
import 'package:blukers_client_app/screen/manager_section/manager_home_screen/manager_home_screen_widget/manager_home_screen_widget.dart';
import 'package:blukers_client_app/utils/app_res.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';

class ApplicantsSeeAllScreen extends StatelessWidget {
  const ApplicantsSeeAllScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorRes.backgroundColor,
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
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
                      Get.back();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: ColorRes.containerColor,
                    ),
                  ),
                ),
                Container(
                  width: Get.width - 80,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      Strings.applicants,
                      style: appTextStyle(color: ColorRes.black, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          searchArea(),
          const SizedBox(height: 12),
          SizedBox(
            height: Get.height * 0.76,
            child: ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: 6,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: InkWell(
                        onTap: () => Get.toNamed(AppRes.applicantsDetails),
                        child: recentPeopleBox()),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

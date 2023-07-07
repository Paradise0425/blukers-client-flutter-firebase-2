import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/screen/manager_section/manager_home_screen/manager_home_screen_widget/manager_home_screen_widget.dart';
import 'package:blukers_client_app/utils/app_res.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';

// ignore: must_be_immutable
class ManagerApplicationDetailScreen extends StatelessWidget {
  ManagerApplicationDetailScreen({Key? key}) : super(key: key);
  var args = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  logo(),
                  Container(
                    width: Get.width - 110,
                    alignment: Alignment.center,
                    child: Text(
                      Strings.applications,
                      style: appTextStyle(
                          color: ColorRes.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Get.toNamed(AppRes.updateVacanciesRequirementScreen,
                    arguments: args);
              },
              child: Container(
                height: 92,
                width: Get.width,
                margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
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
                    Image.asset(AssetRes.airBnbLogo),
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          args["docs"]["Position"],
                          style: appTextStyle(
                              color: ColorRes.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          args["docs"]["CompanyName"],
                          style: appTextStyle(
                              color: ColorRes.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        Row(
                          children: [
                            Text(
                              args["docs"]["location"],
                              style: appTextStyle(
                                  color: ColorRes.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              args["docs"]["type"],
                              style: appTextStyle(
                                  color: ColorRes.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 18,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: args["docs"]["Status"] == "Active"
                                ? ColorRes.lightGreen
                                : ColorRes.invalidColor,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            args["docs"]["Status"],
                            style: appTextStyle(
                                color: args["docs"]["Status"] == "Active"
                                    ? ColorRes.darkGreen
                                    : ColorRes.starColor,
                                fontSize: 12),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          args["docs"]["salary"],
                          style: appTextStyle(
                              fontSize: 15,
                              color: ColorRes.containerColor,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    const SizedBox(width: 10)
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Strings.applicants,
                    style: appTextStyle(
                        color: const Color(0xff242424),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: Get.height * 0.6,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: InkWell(
                  child: recentPeopleBox(
                      homeScreen: true, position: args["docs"]["Position"]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

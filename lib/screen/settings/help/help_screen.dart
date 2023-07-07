import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/screen/manager_section/help/faq/faq_screen.dart';
import 'package:blukers_client_app/screen/manager_section/help/policy/policy_screen.dart';
import 'package:blukers_client_app/screen/manager_section/help/terms/terms_Screen.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';

class HelpScreenU extends StatelessWidget {
  const HelpScreenU({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.backgroundColor,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: backButton(),
                  ),
                ),
                const SizedBox(width: 80),
                Text(
                  'Help',
                  style: appTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      height: 1,
                      color: ColorRes.black),
                ),
              ],
            ),
            const SizedBox(height: 28),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (con) => const FaqScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    Text(
                      'FAQ',
                      style: appTextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: ColorRes.black),
                    ),
                    const Spacer(),
                    // SizedBox(width: Get.width - 75),
                    const Image(
                      image: AssetImage(AssetRes.settingArrow),
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              color: ColorRes.lightGrey.withOpacity(0.8),
              height: 1,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (con) => const TermsScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      'Terms & Conditions',
                      style: appTextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: ColorRes.black),
                    ),
                    const Spacer(),
                    // SizedBox(width: Get.width - 185),
                    const Image(
                      image: AssetImage(AssetRes.settingArrow),
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              color: ColorRes.lightGrey.withOpacity(0.8),
              height: 1,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (con) => const PolicyScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      'Privacy Policy',
                      style: appTextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: ColorRes.black),
                    ),
                    SizedBox(width: Get.width - 141),
                    const Image(
                      image: AssetImage(AssetRes.settingArrow),
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ]),
    );
  }
}

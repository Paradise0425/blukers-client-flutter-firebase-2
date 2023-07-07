import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/screen/first_page/first_screen.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';

class CongratsScreen extends StatelessWidget {
  const CongratsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorRes.backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * 0.29),
            backButton(),
            const Center(
              child: Image(
                height: 180,
                image: AssetImage(AssetRes.congratsLogo),
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: Text(
                Strings.congrats,
                style: appTextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 26,
                    color: ColorRes.containerColor),
              ),
            ),
            const SizedBox(height: 25),
            Center(
              child: Text(
                'Your account is ready to use',
                style: appTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorRes.black),
              ),
            ),
            const SizedBox(height: 120),
            Center(
              child: Container(
                height: 50,
                width: 339,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(colors: [
                    ColorRes.gradientColor,
                    ColorRes.containerColor,
                  ]),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (con) => FirstScreen()));
                  },
                  child: Text("Go to homepage",
                      style: appTextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: ColorRes.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

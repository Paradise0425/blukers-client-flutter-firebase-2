import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/screen/manager_section/auth_manager/first_page/first_screen.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';

class CongratsScreenM extends StatelessWidget {
  const CongratsScreenM({Key? key}) : super(key: key);

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
                'Congrats!',
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
                  borderRadius: BorderRadius.circular(6),
                  color: ColorRes.blukersOrangeColor,
                  // gradient: const LinearGradient(colors: [
                  //   ColorRes.gradientColor,
                  //   ColorRes.containerColor
                  // ]),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (con) => const FirstPageScreenM()));
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

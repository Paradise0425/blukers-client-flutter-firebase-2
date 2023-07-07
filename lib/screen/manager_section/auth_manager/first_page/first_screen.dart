import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/screen/manager_section/auth_manager/Sign_in/sign_in_screen.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';
import 'package:url_launcher/url_launcher.dart';
import '../sign_up_new/sign_up_new_screen.dart';

class FirstPageScreenM extends StatelessWidget {
  const FirstPageScreenM({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorRes.backgroundColor,
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                AssetRes.firstBackScreen,
              ),
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    backButton(),
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.12),
              Text(
                Strings.logo,
                style: appTextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w600,
                    color: ColorRes.black),
              ),
              SizedBox(height: Get.height * 0.12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  textAlign: TextAlign.center,
                  Strings.firstScreenSentences,
                  style: appTextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 26,
                    color: ColorRes.black.withOpacity(0.7),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.03),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (con) => SignUpScreenM()));
                },
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ColorRes.containerColor),
                  child: Text(
                    Strings.createAccount,
                    style: appTextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: ColorRes.white),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.03),
              Text(
                Strings.alreadyHaveAccount,
                style: appTextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: ColorRes.black.withOpacity(0.6),
                ),
              ),
              SizedBox(height: Get.height * 0.0344),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (con) => const SignInScreenM()));
                },
                child: Container(
                  height: 55,
                  width: 327,
                  // width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: ColorRes.containerColor),
                  ),
                  child: Text(Strings.signIn,
                      style: appTextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: ColorRes.containerColor)),
                ),
              ),
              SizedBox(height: Get.height * 0.03),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: Strings.screenSentences,
                        style: appTextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: ColorRes.textColor),
                      ),
                      TextSpan(
                          text: Strings.termsOfService,
                          style: appTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: ColorRes.black,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              // ignore: deprecated_member_use
                              if (!await launch(
                                  "https://www.termsfeed.com/live/588c37bc-3594-490a-be8b-d9409af52df7")) {
                                throw 'Could not launch :https://www.termsfeed.com/live/588c37bc-3594-490a-be8b-d9409af52df7';
                              }
                            })
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

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/screen/auth/sign_in_screen/sign_in_screen.dart';
import 'package:blukers_client_app/screen/auth/sign_up/sign_up_screen.dart';
import 'package:blukers_client_app/screen/first_page/first_controller.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class FirstScreen extends StatelessWidget {
  FirstScreen({Key? key}) : super(key: key);
  FirstScreenController controller = Get.put(FirstScreenController());

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      if (kDebugMode) {
        print(Get.height);
      }
    }
    if (kDebugMode) {
      print(Get.width);
    }
    return Scaffold(
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
              // const SizedBox(height: 110),
              // // Get.height * 0.12),
              // Text(
              //   Strings.logo,
              //   style: GoogleFonts.montserrat(
              //     fontSize: 44,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              // SizedBox(height: Get.height * 0.12),
              Container(
                height: Get.height * 0.15,
                width: Get.height * 0.15,
                // padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  // shape: BoxShape.circle,
                  color: ColorRes.logoColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.hardEdge,
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.asset(AssetRes.wantJob2),
                ),
              ),
              SizedBox(height: Get.height * 0.03),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  textAlign: TextAlign.center,
                  Strings.firstScreenSentences,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    // color: ColorRes.black.withOpacity(0.7),
                    color: ColorRes.blukersOrangeColor,
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.03),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (con) => const SignUpScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: ColorRes.containerColor),
                  child: Text(
                    Strings.createAccount,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: ColorRes.white),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.03),
              Text(
                Strings.alreadyHaveAccount,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: ColorRes.black.withOpacity(0.6),
                ),
              ),
              SizedBox(height: Get.height * 0.0344),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (con) => const SigninScreenU()));
                },
                child: Container(
                  height: 55,
                  width: 327,
                  // width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: ColorRes.containerColor),
                  ),
                  child: Text(Strings.signIn,
                      style: GoogleFonts.montserrat(
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
                                  "https://www.blukers.com/app-terms-of-service")) {
                                throw 'Could not launch :https://www.blukers.com/app-terms-of-service';
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

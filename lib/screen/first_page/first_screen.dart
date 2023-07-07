import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/screen/auth/sign_in_screen/sign_in_screen.dart';
import 'package:blukers_client_app/screen/auth/sign_up/sign_up_screen.dart';
import 'package:blukers_client_app/screen/first_page/first_controller.dart';
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
              const SizedBox(height: 110),
              // Get.height * 0.12),
              Text(
                Strings.logo,
                style: GoogleFonts.poppins(
                  fontSize: 44,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: Get.height * 0.12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  textAlign: TextAlign.center,
                  Strings.firstScreenSentences,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 26,
                    color: ColorRes.black.withOpacity(0.7),
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
                      borderRadius: BorderRadius.circular(15),
                      color: ColorRes.containerColor),
                  child: Text(
                    Strings.createAccount,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: ColorRes.white),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.03),
              Text(
                Strings.alreadyHaveAccount,
                style: GoogleFonts.poppins(
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
                          builder: (con) => const SigninScreenU()));
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
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: ColorRes.containerColor)),
                ),
              ),
              SizedBox(height: Get.height * 0.03),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              'By creating an account, you are agreeing\n                to our',
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: ColorRes.textColor)),
                      TextSpan(
                          text: Strings.termsOfService,
                          style: GoogleFonts.poppins(
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

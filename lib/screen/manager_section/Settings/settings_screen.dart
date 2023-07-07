import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:blukers_client_app/screen/looking_for_screen/looking_for_screen.dart';
import 'package:blukers_client_app/screen/manager_section/appearance/appearance_controller.dart';
import 'package:blukers_client_app/screen/manager_section/appearance/appearance_screen.dart';
import 'package:blukers_client_app/service/pref_services.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/pref_keys.dart';
import 'package:blukers_client_app/utils/string.dart';
import 'localization_screen.dart';

// ignore: must_be_immutable
class SettingScreenM extends StatelessWidget {
  SettingScreenM({Key? key}) : super(key: key);
  AppearanceControllerM controller = Get.put(AppearanceControllerM());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorRes.backgroundColor,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    padding: const EdgeInsets.only(left: 10),
                    margin: const EdgeInsets.only(left: 14),
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
                Align(
                  alignment: Alignment.center,
                  child: Center(
                    child: Text(
                      Strings.settings,
                      style: appTextStyle(
                          color: ColorRes.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (con) => const AppearanceScreenM()));
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            color: ColorRes.logoColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.visibility,
                            color: ColorRes.containerColor,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          Strings.appearance,
                          style: appTextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: ColorRes.black),
                        ),
                      ],
                    ),
                    const Image(
                      image: AssetImage(AssetRes.settingArrow),
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 3),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              color: ColorRes.lightGrey.withOpacity(0.8),
              height: 1,
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (con) => LocalizationScreenM(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            color: ColorRes.logoColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.language,
                            color: ColorRes.containerColor,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          Strings.localization,
                          style: appTextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: ColorRes.black),
                        ),
                      ],
                    ),
                    const Image(
                      image: AssetImage(AssetRes.settingArrow),
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 3),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              color: ColorRes.lightGrey.withOpacity(0.8),
              height: 1,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                onTap: () {
                  settingModalBottomSheet(context);
                },
                child: Row(
                  children: [
                    Container(
                      height: 55,
                      width: 55,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: ColorRes.deleteColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Image(
                        image: AssetImage(
                          AssetRes.logout,
                        ),
                        color: ColorRes.starColor,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Text(
                      Strings.logout,
                      style: appTextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: ColorRes.black),
                    ),
                  ],
                ),
              ),
            ),
          ]),
    );
  }
}

Future settingModalBottomSheet(context) {
  return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return Container(
          height: 265,
          decoration: const BoxDecoration(
            color: ColorRes.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45),
              topRight: Radius.circular(45),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Image(
                image: AssetImage(AssetRes.logout),
                color: ColorRes.starColor,
              ),
              const SizedBox(height: 20),
              Text(
                "Are you sure want to logout?",
                style: appTextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: ColorRes.black.withOpacity(0.8)),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Container(
                        height: 50,
                        width: 160,
                        decoration: BoxDecoration(
                            color: ColorRes.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: ColorRes.containerColor)),
                        child: Center(
                            child: Text(
                          "Cancel",
                          style: appTextStyle(
                            color: ColorRes.containerColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () async {
                      final GoogleSignIn googleSignIn = GoogleSignIn();
                      if (await googleSignIn.isSignedIn()) {
                        await googleSignIn.signOut();
                      }
                      await FirebaseAuth.instance.signOut();
                      /* PrefService.clear();*/
                      PrefService.setValue(PrefKeys.password, "");
                      PrefService.setValue(PrefKeys.rememberMe, "");
                      PrefService.setValue(PrefKeys.registerToken, "");
                      PrefService.setValue(PrefKeys.userId, "");
                      PrefService.setValue(PrefKeys.country, "");
                      PrefService.setValue(PrefKeys.email, "");
                      PrefService.setValue(PrefKeys.totalPost, "");
                      PrefService.setValue(PrefKeys.phoneNumber, "");
                      PrefService.setValue(PrefKeys.city, "");
                      PrefService.setValue(PrefKeys.state, "");

                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const LookingForScreen(),
                          ),
                          (route) => false);
                    },
                    child: Container(
                      height: 50,
                      width: 160,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                          ColorRes.gradientColor,
                          ColorRes.containerColor,
                        ]),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Center(
                        child: Text(
                          "Yes, Logout",
                          style: appTextStyle(
                            color: ColorRes.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      });
}

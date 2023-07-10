import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blukers_client_app/api/api_country.dart';
import 'package:blukers_client_app/screen/looking_for_intro_screen/looking_for_intro_screen.dart';
import 'package:blukers_client_app/screen/intro/introducation_screen.dart';
import 'package:blukers_client_app/screen/splashScreen/splash_controller.dart';
import 'package:blukers_client_app/service/pref_services.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/pref_keys.dart';
import 'package:blukers_client_app/utils/string.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashController controller = Get.put(SplashController());
  @override
  void initState() {
    super.initState();
    getpref();
  }

  getpref() async {
    await PrefService.init();
    // ignore: unnecessary_null_comparison
    if (PrefService.getList(PrefKeys.allDesignation) == null ||
        PrefService.getList(PrefKeys.allDesignation).isEmpty ||
        // ignore: unnecessary_null_comparison
        PrefService.getList(PrefKeys.allCountryData) == null ||
        PrefService.getList(PrefKeys.allCountryData).isEmpty) {
      countryApi();
    }
    splash();
  }

  void splash() async {
    await Future.delayed(const Duration(seconds: 3), () {
      // return Get.offAll(IntroductionScreen());
      return Get.offAll(const LookingForIntroScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider backgroundImage = const AssetImage(AssetRes.splashScreenBack);
    backgroundImage.resolve(createLocalImageConfiguration(context));
    ImageProvider backgroundImageBoy = const AssetImage(AssetRes.splashBoyImg);
    backgroundImageBoy.resolve(createLocalImageConfiguration(context));
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
            image: DecorationImage(image: backgroundImage, fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   alignment: Alignment.centerRight,
            //   padding: const EdgeInsets.only(top: 54, right: 30),
            //   child: Text(
            //     textAlign: TextAlign.end,
            //     Strings.logo,
            //     style: GoogleFonts.montserrat(
            //         fontSize: 30,
            //         fontWeight: FontWeight.w400,
            //         color: ColorRes.splashLogoColor),
            //   ),
            // ),
            // SizedBox(
            //   height: 140,
            //   child: Row(
            //     children: [
            //       Container(
            //         margin: const EdgeInsets.only(bottom: 15),
            //         child: RichText(
            //           text: TextSpan(
            //             children: <TextSpan>[
            //               TextSpan(
            //                   text: ' Find Your  \n',
            //                   style: GoogleFonts.montserrat(
            //                     color: ColorRes.black2,
            //                     fontWeight: FontWeight.w500,
            //                     fontSize: 40,
            //                     height: 1,
            //                   )),
            //               TextSpan(
            //                 text: ' dream job \n',
            //                 style: GoogleFonts.montserrat(
            //                   fontSize: 40,
            //                   fontWeight: FontWeight.w500,
            //                   color: ColorRes.black2,
            //                   background: Paint()..color = Colors.white,
            //                   height: 1,
            //                 ),
            //               ),
            //               TextSpan(
            //                   text: ' here',
            //                   style: GoogleFonts.montserrat(
            //                       color: ColorRes.black2,
            //                       fontWeight: FontWeight.w500,
            //                       fontSize: 40,
            //                       height: 1))
            //             ],
            //           ),
            //         ),
            //       ),
            //       const Spacer(),
            //       Padding(
            //         padding: const EdgeInsets.only(top: 10),
            //         child: Container(
            //           height: 140,
            //           alignment: Alignment.bottomRight,
            //           child: Container(
            //             margin: const EdgeInsets.only(right: 33),
            //             alignment: Alignment.center,
            //             height: 70,
            //             width: 70,
            //             decoration: BoxDecoration(
            //                 border: Border.all(),
            //                 shape: BoxShape.circle,
            //                 color: ColorRes.black2),
            //             child: const Icon(
            //               Icons.search,
            //               color: Colors.white,
            //               size: 40,
            //             ),
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            const Spacer(),
            // Image.asset(
            //   AssetRes.splashBoyImg,
            //   height: Get.height < 657 ? Get.height / 2 : Get.height / 1.6,
            //   width: Get.width,
            //   fit: BoxFit.cover,
            //   filterQuality: FilterQuality.none,
            // )
          ],
        ),
      ),
    );
  }

  countryApi() async {
    controller.countryData = await CountrySearch.countNotification();

    // ignore: avoid_function_literals_in_foreach_calls
    controller.countryData!.forEach((element) {
      controller.allData.add(element.name ?? "");
      // ignore: avoid_function_literals_in_foreach_calls
      element.state!.forEach((el) {
        controller.allData.add(el.name ?? "");
        // ignore: avoid_function_literals_in_foreach_calls
        el.city!.forEach((e) {
          controller.allData.add(e.name ?? "");
        });
      });
    });

    if (kDebugMode) {
      print(PrefService.getList(PrefKeys.allDesignation));
    }
    // ignore: unnecessary_null_comparison
    if (PrefService.getList(PrefKeys.allCountryData) == null ||
        PrefService.getList(PrefKeys.allCountryData).isEmpty) {
      PrefService.setValue(PrefKeys.allCountryData, controller.allData);
    }
    // ignore: unnecessary_null_comparison
    if (PrefService.getList(PrefKeys.allDesignation) == null ||
        PrefService.getList(PrefKeys.allDesignation).isEmpty) {
      PrefService.setValue(PrefKeys.allDesignation, controller.allDesignation);
    }
  }
}

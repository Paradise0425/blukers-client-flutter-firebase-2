import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';

Widget tipsForYouSection() {
  return Column(
    children: [
      const SizedBox(height: 27),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          children: [
            Text(
              Strings.tipsForYou,
              style: appTextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: ColorRes.black,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
      const SizedBox(height: 18),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 18),
        height: 150,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          color: ColorRes.blukersOrangeColor,
          // gradient: const LinearGradient(colors: [
          //   ColorRes.gradientColor,
          //   ColorRes.containerColor,
          // ]),
          boxShadow: [
            BoxShadow(
                offset: const Offset(6, 6),
                color: ColorRes.containerColor.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 10),
            BoxShadow(
                offset: const Offset(0, 7),
                color: ColorRes.containerColor.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 20),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20),
              width: Get.width - 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    Strings.howToFindAPerfectJob,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: ColorRes.white),
                  ),
                  SizedBox(
                    child: Container(
                      height: 32,
                      width: 110,
                      margin: const EdgeInsets.only(top: 15),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: ColorRes.orange,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Text(
                        Strings.readMore,
                        style: appTextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: ColorRes.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            Image.asset(AssetRes.girlImage),
            const SizedBox(width: 20)
          ],
        ),
      ),
      const SizedBox(height: 27),
    ],
  );
}

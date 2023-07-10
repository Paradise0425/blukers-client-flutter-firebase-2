import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';

Widget backButton() {
  return InkWell(
    onTap: () {
      Get.back();
    },
    child: Container(
      height: 40,
      width: 40,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(12),
      //   border: Border.all(
      //     color: ColorRes.containerColor,
      //     width: 2,
      //   ),
      // ),
      decoration: BoxDecoration(
        // color: ColorRes.logoColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: ColorRes.containerColor,
          width: 2,
        ),
      ),
      child: const Icon(
        Icons.arrow_back_ios_new_rounded,
        color: ColorRes.containerColor,
      ),
    ),
  );
}

Widget logo() {
  return Container(
    alignment: Alignment.center,
    height: 40,
    width: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(13),
    ),
    child: const Image(
      image: AssetImage(AssetRes.logo),
    ),
  );
}

Widget indicator(bool isActive, Color activeIndicatorColor) {
  return SizedBox(
    height: 9,
    width: 15,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      height: 8,
      width: 12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: isActive ? activeIndicatorColor : Colors.grey,
      ),
    ),
  );
}

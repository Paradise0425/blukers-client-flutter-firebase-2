import 'package:flutter/material.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/color_res.dart';

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
        color:
            isActive ? activeIndicatorColor : ColorRes.black.withOpacity(0.20),
      ),
    ),
  );
}

Widget pageViewPart(
    {required String image,
    required String title,
    required String description,
    required Color textColor}) {
  return Column(
    children: [
      Image.asset(
        image,
        height: 200,
      ),
      const SizedBox(height: 30),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          title,
          style: appTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: ColorRes.containerColor,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Text(
          description,
          style: appTextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: ColorRes.black),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}

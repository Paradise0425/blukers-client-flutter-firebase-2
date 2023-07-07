import 'package:flutter/material.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/color_res.dart';

Widget commonErrorBox(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: ColorRes.invalidColor),
    child: Row(
      children: [
        const Icon(
          Icons.error,
          color: ColorRes.starColor,
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          text,
          style: appTextStyle(
              color: ColorRes.starColor,
              fontWeight: FontWeight.w400,
              fontSize: 10),
        )
      ],
    ),
  );
}

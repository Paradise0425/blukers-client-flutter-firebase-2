import 'package:flutter/material.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/color_res.dart';

Widget dateTimeBox(
    {String? text,
    image,
    Function(BuildContext)? onTap,
    BuildContext? context,
    String? value}) {
  return InkWell(
    onTap: () => onTap!(context!),
    child: Container(
        height: 39,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorRes.containerColor, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value ?? text!,
              style: appTextStyle(color: ColorRes.containerColor, fontSize: 15),
            ),
            Image.asset(
              image,
              height: 20,
              width: 20,
            )
          ],
        )),
  );
}

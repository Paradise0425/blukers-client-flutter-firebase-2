import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/color_res.dart';

Widget detailBox(text, values) {
  return Container(
    // height: 50,
    width: Get.width,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [
        const Color(0xFFF3F0F8),
        const Color(0xFFF3F0F8).withOpacity(0.1),
      ], begin: Alignment.centerLeft, end: Alignment.centerRight),
      borderRadius: BorderRadius.circular(13),
    ),
    child: Row(
      children: [
        const Icon(
          Icons.check_circle_outline,
          color: ColorRes.containerColor,
          size: 30,
        ),
        const SizedBox(
          width: 20,
        ),
        SizedBox(
          width: Get.width * 0.57,
          child: Text(
            text,
            style: appTextStyle(
                color: ColorRes.black,
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
        ),
        /*   PopupMenuButton(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20))),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,height: 18,
              child: Container(
                height: 18,
                width: 116,
                child: Row(
                  children: const [
                    Icon(
                      Icons.edit,
                      color: ColorRes.containerColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("edit")
                  ],
                ),
              ),
            ),
            PopupMenuItem(height: 1,
                child: Container(
              height: 1,
              width: 116,
                  color: Colors.grey,
            )),
            PopupMenuItem(
              value: 2,height: 18,
              child: Container(
                height: 18,
                width: 116,
                child: Row(
                  children: const [
                    Icon(
                      Icons.delete,
                      color: ColorRes.starColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("remove")
                  ],
                ),
              ),
            ),
          ],
          offset: const Offset(0, 50),
          color: Colors.white,
          elevation: 1,
        ),*/
      ],
    ),
  );
}

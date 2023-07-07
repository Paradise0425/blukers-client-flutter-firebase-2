import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/screen/manager_section/Notification/notification_services.dart';
import 'package:blukers_client_app/screen/manager_section/applicants_detail_screen/applicants_details_controller.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';

Widget notificationBox() {
  ApplicantsDetailsController anscontro =
      Get.put(ApplicantsDetailsController());
  return Container(
    height: 92,
    margin: const EdgeInsets.only(bottom: 30),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: ColorRes.borderColor, width: 2),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20),
          alignment: Alignment.center,
          height: 50,
          width: 70,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetRes.notificationDetail),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: Get.width * 0.65,
          padding: const EdgeInsets.only(right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Text(
                anscontro.selectedValue ?? NotificationService.noti["title"],
                style: appTextStyle(
                    color: ColorRes.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 13),
                maxLines: 2,
              ),
              Text(
                anscontro.selectedValue ?? NotificationService.noti["body"],
                style: appTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: ColorRes.black.withOpacity(0.5),
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        )
      ],
    ),
  );
}

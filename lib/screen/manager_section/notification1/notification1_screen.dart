import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/screen/manager_section/Notification/notification_services.dart';
import 'package:blukers_client_app/screen/manager_section/applicants_detail_screen/applicants_details_controller.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';

// ignore: must_be_immutable
class NotificationScreenM extends StatelessWidget {
  NotificationScreenM({Key? key}) : super(key: key);
  ApplicantsDetailsController anscontro =
      Get.put(ApplicantsDetailsController());

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
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(18),
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: backButton(),
                ),
              ),
              const SizedBox(width: 60),
              Text(
                Strings.notification,
                style: appTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 1,
                    color: ColorRes.black),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: Get.height - 150,
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin:
                      const EdgeInsets.only(left: 18, right: 18, bottom: 20),
                  padding: const EdgeInsets.all(15),
                  width: Get.width,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      border: Border.all(
                        color: const Color(0xffF3ECFF),
                      ),
                      color: ColorRes.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 80,
                        child: Image(
                          image: AssetImage(AssetRes.rightLogo),
                        ),
                      ),
                      SizedBox(
                        height: 92,
                        width: Get.width / 1.5 - 26,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                /*  noti[0]['title'],*/
                                anscontro.selectedValue ??
                                    NotificationService.noti["title"],
                                style: appTextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: ColorRes.black),
                              ),
                              Text(
                                anscontro.selectedValue ??
                                    NotificationService.noti["body"],
                                style: appTextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: ColorRes.black.withOpacity(0.5),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

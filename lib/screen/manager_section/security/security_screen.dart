import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/screen/manager_section/security/security_controller.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SecurityController controller = Get.put(SecurityController());
    return Scaffold(
        backgroundColor: ColorRes.backgroundColor,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: backButton(),
                    ),
                  ),
                  const SizedBox(width: 75),
                  Text(
                    Strings.security,
                    style: appTextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        height: 1,
                        color: ColorRes.black),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Face Id',
                      style: appTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: ColorRes.black),
                    ),
                  ),
                  const Spacer(),
                  // SizedBox(width: Get.width - 140),
                  Obx(() => FlutterSwitch(
                      height: 27,
                      width: 45,
                      value: controller.isSwitchedFace.value,
                      activeColor: ColorRes.blueColor,
                      toggleSize: 20,
                      onToggle: (value) => controller.onchangeFace(value))),
                  const SizedBox(width: 15),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                color: ColorRes.lightGrey.withOpacity(0.8),
                height: 1,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Remember me',
                      style: appTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: ColorRes.black),
                    ),
                  ),
                  const Spacer(),
                  // SizedBox(width: Get.width - 195),
                  Obx(() => FlutterSwitch(
                      height: 27,
                      width: 45,
                      value: controller.isSwitchedRemember.value,
                      activeColor: ColorRes.blueColor,
                      toggleSize: 20,
                      onToggle: (value) => controller.onchangeRemember(value))),
                  const SizedBox(width: 15),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                color: ColorRes.lightGrey.withOpacity(0.8),
                height: 1,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Touch ID',
                      style: appTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: ColorRes.black),
                    ),
                  ),
                  const Spacer(),
                  // SizedBox(width: Get.width - 150),
                  Obx(
                    () => FlutterSwitch(
                      height: 27,
                      width: 45,
                      value: controller.isSwitchedTouch.value,
                      activeColor: ColorRes.blueColor,
                      toggleSize: 20,
                      onToggle: (value) => controller.onchangeTouch(value),
                    ),
                  ),
                  const SizedBox(width: 15),
                ],
              ),
            ]));
  }
}

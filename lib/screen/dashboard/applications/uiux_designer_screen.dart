import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/screen/chat_box/chat_box_screen.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';

// ignore: must_be_immutable
class SentScreen extends StatelessWidget {
  String? position;
  String? companyName;
  String? message;
  String? salary;
  String? location;
  String? type;
  SentScreen(
      {Key? key,
      this.position,
      this.companyName,
      this.message,
      this.salary,
      this.location,
      this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.backgroundColor,
      body: Column(
        children: [
          const SizedBox(height: 50),
          Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: backButton(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    Strings.applications,
                    style: appTextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        height: 1,
                        color: ColorRes.black),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: Get.height - 140,
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 135,
                      width: Get.width,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 4),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          border: Border.all(color: const Color(0xffF3ECFF)),
                          color: ColorRes.white),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                Image.asset(AssetRes.airBnbLogo, height: 40),
                                const SizedBox(width: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      position ?? "",
                                      style: appTextStyle(
                                          color: ColorRes.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      companyName ?? "",
                                      style: appTextStyle(
                                          color: ColorRes.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            color: ColorRes.grey,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 28,
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: const Color(0xffEEF2FA),
                              borderRadius: BorderRadius.circular(99),
                            ),
                            child: Center(
                              child: Text(
                                "Application Sent",
                                style: appTextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff2E5AAC)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: Get.width,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 5),
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 18),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          border: Border.all(color: ColorRes.borderColor),
                          color: ColorRes.white),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Strings.salary,
                                style: appTextStyle(
                                    color: ColorRes.black.withOpacity(0.8),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                salary ?? "",
                                style: appTextStyle(
                                    color: ColorRes.containerColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Strings.type,
                                style: appTextStyle(
                                    color: ColorRes.black.withOpacity(0.8),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                type ?? "",
                                style: appTextStyle(
                                    color: ColorRes.containerColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Strings.location,
                                style: appTextStyle(
                                    color: ColorRes.black.withOpacity(0.8),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                location ?? "",
                                style: appTextStyle(
                                    color: ColorRes.containerColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        message ?? "",
                        style: appTextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: ColorRes.black.withOpacity(0.9)),
                      ),
                    ),
                    const SizedBox(height: 55),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (con) => ChatBoxScreen()));
                      },
                      child: Container(
                        height: 50,
                        width: Get.width,
                        // width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: const LinearGradient(
                            colors: [
                              ColorRes.gradientColor,
                              ColorRes.containerColor,
                            ],
                          ),
                        ),
                        child: Text(Strings.joiningInterview,
                            style: appTextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: ColorRes.white)),
                      ),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}

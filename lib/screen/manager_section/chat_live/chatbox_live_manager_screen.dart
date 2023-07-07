import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';

class ChatBovLiveScreen extends StatelessWidget {
  const ChatBovLiveScreen({Key? key}) : super(key: key);

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
                  padding: const EdgeInsets.all(12),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: backButton(),
                  ),
                ),
                const SizedBox(width: 85),
                Text(
                  Strings.chatBox,
                  style: appTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      height: 1,
                      color: ColorRes.black),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Center(
              child: Container(
                height: 92,
                width: Get.width,
                margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(
                      color: const Color(0xffF3ECFF),
                    ),
                    color: ColorRes.white),
                child: Row(
                  children: [
                    Image.asset(
                      AssetRes.chatBoxMenImage,
                    ),
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.airBNB,
                          style: appTextStyle(
                              color: ColorRes.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          Strings.online,
                          style: appTextStyle(
                              color: ColorRes.black,
                              fontSize: 9,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    const SizedBox(width: 70),
                    /*  Container(
                      height: 35,
                      width: 35,
                      decoration: const BoxDecoration(
                        color: ColorRes.logoColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: const Icon(Icons.videocam,
                          color: ColorRes.containerColor),
                    ),*/
                    const SizedBox(width: 14),
                    Container(
                      height: 35,
                      width: 35,
                      decoration: const BoxDecoration(
                        color: ColorRes.logoColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: const Icon(Icons.call,
                          color: ColorRes.containerColor),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 214,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Color(0xffEEEBF4)),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Hi,Adam Smith,'
                    '\nCongratulations!'
                    '\nAfter we reviewed your application for the position'
                    '\nof UI/UX Designer,we congratulate you for being'
                    '\npart of us.After this you will be con'
                    'tacted'
                    '\npersonally by our team.Thank You ...'
                    '\nGreetings,'
                    '\n Hiring Manager',
                    style: appTextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        color: ColorRes.black),
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}

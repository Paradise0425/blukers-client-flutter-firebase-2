import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/common/widgets/common_text_field.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';

import 'forgot_password_new_controller.dart';

class ForgotPasswordScreenU extends StatelessWidget {
  ForgotPasswordScreenU({Key? key}) : super(key: key);

  final ForgotPasswordControllerU controller =
      Get.put(ForgotPasswordControllerU());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.backgroundColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 50),
            Row(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: backButton(),
              ),
            ]),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.only(right: 130),
              child: Text(
                textAlign: TextAlign.start,
                'Forgot password',
                style: appTextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: ColorRes.black),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Enter the email associated with your account and we’ll send an email with instructions to forgot password.",
                style: appTextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: ColorRes.black.withOpacity(0.6)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 220),
              child: Text('Email address',
                  style: appTextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: ColorRes.black.withOpacity(0.6))),
            ),
            const SizedBox(height: 10),
            GetBuilder<ForgotPasswordControllerU>(
              id: "showEmail",
              builder: (controller) => Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(6, 6),
                            color: ColorRes.containerColor.withOpacity(0.12),
                            spreadRadius: 0,
                            blurRadius: 35),
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Material(
                      shadowColor: ColorRes.containerColor,
                      borderRadius: BorderRadius.circular(10),
                      child: commonTextFormField(
                        controller: controller.forgotEmailController,
                        textDecoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            hintText: 'Email',
                            fillColor: Colors.transparent,
                            filled: true,
                            hintStyle: appTextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: ColorRes.black.withOpacity(0.15)),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  controller.emailError == ""
                      ? const SizedBox(height: 20)
                      : Container(
                          margin: const EdgeInsets.all(10),
                          width: 339,
                          height: 28,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: ColorRes.invalidColor),
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Image(
                                  image: AssetImage(
                                    AssetRes.invalid,
                                  ),
                                  height: 14,
                                ),
                                const SizedBox(width: 10),
                                Text(controller.emailError,
                                    style: appTextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 9,
                                        color: ColorRes.starColor))
                              ]),
                        ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            GetBuilder<ForgotPasswordControllerU>(
                id: "colorChange",
                builder: (controller) {
                  return InkWell(
                    onTap: controller.onLoginBtnTap,
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: ColorRes.blukersOrangeColor,
                        // gradient: const LinearGradient(colors: [
                        //   ColorRes.gradientColor,
                        //   ColorRes.containerColor
                        // ]),
                      ),
                      child: Text("Send Instructions",
                          style: appTextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: ColorRes.white)),
                    ),
                  );
                }),
          ]),
        ),
      ),
    );
  }
}

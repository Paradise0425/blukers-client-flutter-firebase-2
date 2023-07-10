import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/screen/auth/reset_password_page/reset_password_screen.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';
import 'package:pinput/pinput.dart';
import 'otp_controller.dart';

// ignore: must_be_immutable
class OtpScreen extends StatelessWidget {
  OtpScreen({Key? key}) : super(key: key);
  OtpController controller = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorRes.backgroundColor,
      body: Column(children: [
        const SizedBox(height: 50),
        backButton(),
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
            const SizedBox(width: 46),
            Text(
              Strings.forgotPassword,
              style: appTextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  height: 1,
                  color: ColorRes.black),
            ),
          ],
        ),
        SizedBox(height: Get.height * 0.19),
        Text(
          Strings.codeHasBeen,
          style: appTextStyle(
              fontSize: 12, fontWeight: FontWeight.w400, color: ColorRes.black),
        ),
        SizedBox(height: Get.height * 0.05),
        Pinput(
          autofocus: true,
          keyboardType: TextInputType.number,
          length: 4,
          showCursor: true,
          closeKeyboardWhenCompleted: true,
          defaultPinTheme: controller.defaultTheme,
          focusedPinTheme: controller.defaultTheme.copyDecorationWith(
            //border: Border.all(color: const Color.fromRGBO(139, 78, 255, 0.05)),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        SizedBox(height: Get.height * 0.01),
        controller.otpError == ''
            ? const SizedBox(height: 20)
            : Container(
                width: Get.width - 50,
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
                      Text(
                        Strings.invalidOTPCode,
                        style: appTextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w400,
                            color: ColorRes.starColor),
                      ),
                    ]),
              ),
        SizedBox(height: Get.height * 0.0600),
        GetBuilder<OtpController>(
            id: "Seconds",
            builder: (controller) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(Strings.resendCodeIn,
                      style: appTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: ColorRes.black)),
                  Text(
                    '${controller.seconds}',
                    style: appTextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: ColorRes.containerColor),
                  ),
                  Text(
                    ' s',
                    style: appTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: ColorRes.black),
                  ),
                ],
              );
            }),
        const SizedBox(height: 210),
        InkWell(
          onTap: controller.otpvalidation(),
          child: Container(
            height: 50,
            width: 339,
            //width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: ColorRes.blukersOrangeColor,
              // gradient: const LinearGradient(colors: [
              //   ColorRes.gradientColor,
              //   ColorRes.containerColor
              // ]),
            ),
            child: InkWell(
              onTap: () {
                // controller.startTimer();
                Navigator.push(context,
                    MaterialPageRoute(builder: (con) => ResetPasswordScreen()));
              },
              child: Text(Strings.verify,
                  style: appTextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: ColorRes.white)),
            ),
          ),
        ),
      ]),
    );
  }
}

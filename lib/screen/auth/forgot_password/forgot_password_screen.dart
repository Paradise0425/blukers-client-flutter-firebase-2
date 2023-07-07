import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/screen/auth/otp_page/otp_screen.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'forgot_password_controller.dart';

// ignore: must_be_immutable
class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);
  ForgotPasswordController con = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.backgroundColor,
      body: Column(
        children: [
          SizedBox(height: Get.height * 0.0738),
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
                'Forgot Password',
                style: appTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 1,
                    color: ColorRes.black),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'Select which contact details should we use to reset your password',
              style: appTextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: ColorRes.black),
            ),
          ),
          const SizedBox(height: 16),
          GetBuilder<ForgotPasswordController>(
            id: "SMS",
            builder: (controller) => InkWell(
              onTap: controller.mobileUpdate,
              child: Container(
                height: 120,
                width: 339,
                decoration: BoxDecoration(
                  color: ColorRes.white,
                  border: Border.all(
                      color: controller.isSelected
                          ? ColorRes.containerColor
                          : ColorRes.borderColor,
                      width: controller.isSelected ? 1 : 0),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 80,
                        width: 80,
                        padding: const EdgeInsets.all(26),
                        decoration: BoxDecoration(
                          color: ColorRes.logoColor,
                          borderRadius: BorderRadius.circular(80),
                        ),
                        child: const Image(
                          image: AssetImage(
                            AssetRes.inboxLogo,
                          ),
                          height: 10,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            textAlign: TextAlign.start,
                            'Via SMS:',
                            style: appTextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              color: ColorRes.black.withOpacity(0.6),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '+6282******39',
                          style: appTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: ColorRes.black),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          GetBuilder<ForgotPasswordController>(
            id: "SMS",
            builder: (controller) => InkWell(
              onTap: controller.emailUpdate,
              child: Container(
                height: 120,
                width: 339,
                decoration: BoxDecoration(
                  color: ColorRes.white,
                  border: Border.all(
                      color: controller.isselectedemail
                          ? ColorRes.containerColor
                          : ColorRes.borderColor,
                      width: controller.isselectedemail ? 1 : 0),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 80,
                        width: 80,
                        padding: const EdgeInsets.all(26),
                        decoration: BoxDecoration(
                          color: ColorRes.logoColor,
                          borderRadius: BorderRadius.circular(80),
                        ),
                        child: const Image(
                          image: AssetImage(
                            AssetRes.emailLogo,
                          ),
                          height: 10,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Via Email:',
                          style: appTextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            color: ColorRes.black.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'ex***le@yourdomain.com',
                          style: appTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: ColorRes.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 130),
          Container(
            height: 50,
            width: 339,
            //width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(colors: [
                ColorRes.gradientColor,
                ColorRes.containerColor,
              ]),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (con) => OtpScreen()));
              },
              child: Text("Continue",
                  style: appTextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: ColorRes.white)),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

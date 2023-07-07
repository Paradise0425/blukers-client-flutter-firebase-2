import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/common/widgets/common_text_field.dart';
import 'package:blukers_client_app/screen/manager_section/auth_manager/reset_password/reset_password_controller.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';

// ignore: must_be_immutable
class ResetPasswordScreenM extends StatelessWidget {
  ResetPasswordScreenM({Key? key}) : super(key: key);
  ResetPasswordControllerM controller = Get.put(ResetPasswordControllerM());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorRes.backgroundColor,
      body: Column(children: [
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
            const SizedBox(width: 50),
            Center(
              child: Text(
                'Reset Password',
                style: appTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 1,
                    color: ColorRes.black),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(right: 170),
          child: Text(
            'Create a new password',
            style: appTextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: ColorRes.black),
          ),
        ),
        const SizedBox(height: 20),
        Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      'New Password',
                      style: appTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: ColorRes.black.withOpacity(0.6)),
                    ),
                    const Text(
                      '*',
                      style: TextStyle(fontSize: 15, color: ColorRes.starColor),
                    ),
                  ],
                ),
              ),
              GetBuilder<ResetPasswordControllerM>(
                id: "NewPassword",
                builder: (controller) => Container(
                  width: 339,
                  height: 51,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(6, 6),
                          color: ColorRes.containerColor.withOpacity(0.05),
                          spreadRadius: 0,
                          blurRadius: 35),
                    ],
                  ),
                  child: Material(
                    shadowColor: ColorRes.containerColor,
                    borderRadius: BorderRadius.circular(12),
                    child: commonTextFormField(
                      controller: controller.passwordController,
                      obscureText: controller.show,
                      textDecoration: InputDecoration(
                        hintText: 'New Password',
                        fillColor: Colors.transparent,
                        suffixIcon: IconButton(
                          icon: controller.show
                              ? Icon(
                                  Icons.visibility_off,
                                  color: ColorRes.black.withOpacity(0.15),
                                )
                              : Icon(
                                  Icons.visibility,
                                  color: ColorRes.black.withOpacity(0.15),
                                ),
                          onPressed: controller.chang,
                        ),
                        filled: true,
                        hintStyle: TextStyle(
                            color: ColorRes.black.withOpacity(
                              0.15,
                            ),
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                        border:
                            controller.passwordController.text.trim().isEmpty
                                ? InputBorder.none
                                : controller.newPassword.isNotEmpty
                                    ? errorBorder()
                                    : enableBorder(),
                        focusedBorder:
                            controller.passwordController.text.trim().isEmpty
                                ? InputBorder.none
                                : controller.newPassword.isNotEmpty
                                    ? errorBorder()
                                    : enableBorder(),
                        disabledBorder:
                            controller.passwordController.text.trim().isEmpty
                                ? InputBorder.none
                                : controller.newPassword.isNotEmpty
                                    ? errorBorder()
                                    : enableBorder(),
                        enabledBorder:
                            controller.passwordController.text.trim().isEmpty
                                ? InputBorder.none
                                : controller.newPassword.isNotEmpty
                                    ? errorBorder()
                                    : enableBorder(),
                        errorBorder:
                            controller.passwordController.text.trim().isEmpty
                                ? InputBorder.none
                                : controller.newPassword.isNotEmpty
                                    ? errorBorder()
                                    : enableBorder(),
                        focusedErrorBorder:
                            controller.passwordController.text.trim().isEmpty
                                ? InputBorder.none
                                : controller.newPassword.isNotEmpty
                                    ? errorBorder()
                                    : enableBorder(),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      'Confirm New Password',
                      style: appTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: ColorRes.black.withOpacity(0.6)),
                    ),
                    const Text(
                      '*',
                      style: TextStyle(fontSize: 15, color: ColorRes.starColor),
                    ),
                  ],
                ),
              ),
              GetBuilder<ResetPasswordControllerM>(
                id: "ConfirmPassword",
                builder: (controller) => Column(
                  children: [
                    Container(
                      width: 339,
                      height: 51,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(6, 6),
                              color: ColorRes.containerColor.withOpacity(0.05),
                              spreadRadius: 0,
                              blurRadius: 35),
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Material(
                        shadowColor: ColorRes.containerColor,
                        borderRadius: BorderRadius.circular(12),
                        child: commonTextFormField(
                          controller: controller.confirmPasswordController,
                          obscureText: controller.confirm,
                          textDecoration: InputDecoration(
                            hintText: 'Confirm New Password',
                            fillColor: Colors.transparent,
                            suffixIcon: IconButton(
                              icon: controller.confirm
                                  ? Icon(Icons.visibility_off,
                                      color: ColorRes.black.withOpacity(0.15))
                                  : Icon(Icons.visibility,
                                      color: ColorRes.black.withOpacity(0.15)),
                              onPressed: controller.Rechange,
                            ),
                            filled: true,
                            hintStyle: TextStyle(
                                color: ColorRes.black.withOpacity(
                                  0.15,
                                ),
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                            border: controller.confirmPasswordController.text
                                    .trim()
                                    .isEmpty
                                ? InputBorder.none
                                : controller.confirmPassword.isNotEmpty
                                    ? errorBorder()
                                    : enableBorder(),
                            focusedBorder: controller
                                    .confirmPasswordController.text
                                    .trim()
                                    .isEmpty
                                ? InputBorder.none
                                : controller.confirmPassword.isNotEmpty
                                    ? errorBorder()
                                    : enableBorder(),
                            disabledBorder: controller
                                    .confirmPasswordController.text
                                    .trim()
                                    .isEmpty
                                ? InputBorder.none
                                : controller.confirmPassword.isNotEmpty
                                    ? errorBorder()
                                    : enableBorder(),
                            enabledBorder: controller
                                    .confirmPasswordController.text
                                    .trim()
                                    .isEmpty
                                ? InputBorder.none
                                : controller.confirmPassword.isNotEmpty
                                    ? errorBorder()
                                    : enableBorder(),
                            errorBorder: controller
                                    .confirmPasswordController.text
                                    .trim()
                                    .isEmpty
                                ? InputBorder.none
                                : controller.confirmPassword.isNotEmpty
                                    ? errorBorder()
                                    : enableBorder(),
                            focusedErrorBorder: controller
                                    .confirmPasswordController.text
                                    .trim()
                                    .isEmpty
                                ? InputBorder.none
                                : controller.confirmPassword.isNotEmpty
                                    ? errorBorder()
                                    : enableBorder(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    controller.confirmPassword == ""
                        ? const SizedBox(height: 20)
                        : Container(
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
                                  Text(
                                    controller.confirmPassword,
                                    style: const TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w400,
                                        color: ColorRes.starColor),
                                  ),
                                ]),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            GetBuilder<ResetPasswordControllerM>(
                id: "remember_me",
                builder: (controller) {
                  return InkWell(
                    onTap: () {
                      controller.rememberMe = !controller.rememberMe;
                      controller.update(["remember_me"]);
                    },
                    child: Row(
                      children: [
                        Checkbox(
                          activeColor: ColorRes.containerColor,
                          checkColor: ColorRes.white,
                          side: const BorderSide(
                              width: 1, color: ColorRes.containerColor),
                          value: controller.rememberMe,
                          onChanged: controller.onRememberMeChange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const Text(
                          'Remember me',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: ColorRes.black),
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ),
        const SizedBox(height: 190),
        InkWell(
          onTap: () => controller.onLoginBtnTap(context),
          child: Container(
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
            child: Text(
              "Save",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: ColorRes.white),
            ),
          ),
        ),
      ]),
    );
  }
}

OutlineInputBorder enableBorder() {
  return OutlineInputBorder(
    borderSide: const BorderSide(color: ColorRes.containerColor),
    // borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(10),
  );
}

OutlineInputBorder errorBorder() {
  return OutlineInputBorder(
    borderSide: const BorderSide(color: ColorRes.starColor),
    // borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(10),
  );
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/common/widgets/common_loader.dart';
import 'package:blukers_client_app/common/widgets/common_text_field.dart';
import 'package:blukers_client_app/screen/auth/sign_up/widget/signup_bottom/country.dart';
import 'package:blukers_client_app/screen/manager_section/auth_manager/Sign_in/sign_in_screen.dart';
import 'package:blukers_client_app/screen/manager_section/auth_manager/sign_up_new/sign_up_new_controller.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';

// ignore: must_be_immutable
class SignUpScreenM extends StatelessWidget {
  SignUpScreenM({Key? key}) : super(key: key);
  SignUpControllerM controller = Get.put(SignUpControllerM());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: Obx(() {
        return Stack(
          children: [
            SingleChildScrollView(
                child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    backButton(),
                    Center(
                      child: Container(
                        alignment: Alignment.center,
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: ColorRes.logoColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Image(
                          image: AssetImage(AssetRes.logo),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Center(
                      child: Text(
                        Strings.signUpForFree,
                        style: appTextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: ColorRes.black),
                      ),
                    ),
                    const SizedBox(height: 37),
                    Padding(
                      padding: const EdgeInsets.only(left: 13, bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            Strings.firstName,
                            style: appTextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: ColorRes.black.withOpacity(0.6),
                            ),
                          ),
                          Text(
                            '*',
                            style: appTextStyle(
                                fontSize: 15, color: ColorRes.starColor),
                          ),
                        ],
                      ),
                    ),
                    GetBuilder<SignUpControllerM>(
                      id: "showFirstname",
                      builder: (controller) => Column(
                        children: [
                          Container(
                            height: 51,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(6, 6),
                                    color: ColorRes.containerColor
                                        .withOpacity(0.10),
                                    spreadRadius: 0,
                                    blurRadius: 35),
                              ],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Material(
                              shadowColor: ColorRes.containerColor,
                              borderRadius: BorderRadius.circular(12),
                              child: commonTextFormField(
                                onChanged: controller.onChanged,
                                controller: controller.firstnameController,
                                textDecoration: InputDecoration(
                                  hintText: 'First Name',
                                  fillColor: Colors.transparent,
                                  filled: true,
                                  hintStyle: appTextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: ColorRes.black.withOpacity(0.15)),
                                  border: controller.firstnameController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.firstError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  focusedBorder: controller
                                          .firstnameController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.firstError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  disabledBorder: controller
                                          .firstnameController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.firstError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  enabledBorder: controller
                                          .firstnameController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.firstError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  errorBorder: controller
                                          .firstnameController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.firstError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  focusedErrorBorder: controller
                                          .firstnameController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.firstError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                ),
                              ),
                            ),
                          ),
                          controller.firstError == ""
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Image(
                                          image: AssetImage(
                                            AssetRes.invalid,
                                          ),
                                          height: 14,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(controller.firstError,
                                            style: appTextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 9,
                                                color: ColorRes.starColor))
                                      ]),
                                ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 13, bottom: 10),
                      child: Row(
                        children: [
                          Text(Strings.lastName,
                              style: appTextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: ColorRes.black.withOpacity(0.6))),
                          Text(
                            '*',
                            style: appTextStyle(
                                fontSize: 15, color: ColorRes.starColor),
                          ),
                        ],
                      ),
                    ),
                    GetBuilder<SignUpControllerM>(
                      id: "showLastname",
                      builder: (controller) => Column(
                        children: [
                          Container(
                            height: 51,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(6, 6),
                                    color: ColorRes.containerColor
                                        .withOpacity(0.10),
                                    spreadRadius: 0,
                                    blurRadius: 35),
                              ],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Material(
                              shadowColor: ColorRes.containerColor,
                              borderRadius: BorderRadius.circular(12),
                              child: commonTextFormField(
                                onChanged: controller.onChanged,
                                controller: controller.lastnameController,
                                textDecoration: InputDecoration(
                                  hintText: 'Last Name',
                                  fillColor: Colors.transparent,
                                  filled: true,
                                  hintStyle: appTextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: ColorRes.black.withOpacity(0.15)),
                                  border: controller.lastnameController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.lastError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  focusedBorder: controller
                                          .lastnameController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.lastError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  disabledBorder: controller
                                          .lastnameController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.lastError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  enabledBorder: controller
                                          .lastnameController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.lastError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  errorBorder: controller
                                          .lastnameController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.lastError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  focusedErrorBorder: controller
                                          .lastnameController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.lastError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                ),
                              ),
                            ),
                          ),
                          controller.lastError == ""
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Image(
                                          image: AssetImage(
                                            AssetRes.invalid,
                                          ),
                                          height: 14,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(controller.lastError,
                                            style: appTextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 9,
                                                color: ColorRes.starColor))
                                      ]),
                                ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 13, bottom: 10),
                      child: Row(
                        children: [
                          Text(Strings.email,
                              style: appTextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: ColorRes.black.withOpacity(0.6))),
                          Text(
                            '*',
                            style: appTextStyle(
                                fontSize: 15, color: ColorRes.starColor),
                          ),
                        ],
                      ),
                    ),
                    GetBuilder<SignUpControllerM>(
                      id: "showEmail",
                      builder: (controller) => Column(
                        children: [
                          Container(
                            height: 51,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(6, 6),
                                    color: ColorRes.containerColor
                                        .withOpacity(0.10),
                                    spreadRadius: 0,
                                    blurRadius: 35),
                              ],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Material(
                              shadowColor: ColorRes.containerColor,
                              borderRadius: BorderRadius.circular(12),
                              child: commonTextFormField(
                                onChanged: controller.onChanged,
                                controller: controller.emailController,
                                textDecoration: InputDecoration(
                                  hintText: 'Email',
                                  fillColor: Colors.transparent,
                                  filled: true,
                                  hintStyle: appTextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: ColorRes.black.withOpacity(0.15),
                                  ),
                                  border: controller.emailController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.emailError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  focusedBorder: controller.emailController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.emailError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  disabledBorder: controller
                                          .emailController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.emailError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  enabledBorder: controller.emailController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.emailError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  errorBorder: controller.emailController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.emailError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  focusedErrorBorder: controller
                                          .emailController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.emailError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                ),
                              ),
                            ),
                          ),
                          controller.emailError == ""
                              ? const SizedBox(height: 20)
                              : Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 28,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: ColorRes.invalidColor),
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, bottom: 10),
                      child: Row(
                        children: [
                          Text(Strings.phoneNumber,
                              style: appTextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: ColorRes.black.withOpacity(0.6))),
                          Text(
                            '*',
                            style: appTextStyle(
                                fontSize: 15, color: ColorRes.starColor),
                          ),
                        ],
                      ),
                    ),
                    GetBuilder<SignUpControllerM>(
                      id: "showPhoneNumber",
                      builder: (controller) => Column(
                        children: [
                          Container(
                            width: Get.width,
                            height: 51,
                            padding: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: ColorRes.white,
                              border: Border.all(
                                  color: controller.phoneController.text
                                          .trim()
                                          .isEmpty
                                      ? ColorRes.borderColor
                                      : controller.phoneError == ""
                                          ? ColorRes.containerColor
                                          : ColorRes.starColor),
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(6, 6),
                                    color: ColorRes.containerColor
                                        .withOpacity(0.10),
                                    spreadRadius: 0,
                                    blurRadius: 35),
                              ],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                countryCodePicker(context, padding: 3),
                                SizedBox(
                                  width: Get.width / 2,
                                  child: Material(
                                    shadowColor: ColorRes.containerColor,
                                    borderRadius: BorderRadius.circular(12),
                                    child: TextFormField(
                                      onChanged: controller.onChanged,
                                      keyboardType: TextInputType.number,
                                      controller: controller.phoneController,
                                      decoration: InputDecoration(
                                          // prefix:countryCodePicker(context) ,
                                          hintText: 'Phone number',
                                          fillColor: ColorRes.white,
                                          filled: true,
                                          hintStyle: appTextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: ColorRes.black
                                                  .withOpacity(0.15)),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          controller.phoneError == ""
                              ? SizedBox(height: Get.height * 0.0197)
                              : Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 28,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: ColorRes.invalidColor),
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Image(
                                          image: AssetImage(
                                            AssetRes.invalid,
                                          ),
                                          height: 14,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          controller.phoneError,
                                          style: appTextStyle(
                                              fontSize: 9,
                                              fontWeight: FontWeight.w400,
                                              color: ColorRes.starColor),
                                        )
                                      ]),
                                ),
                          // Text(controller.phoneError)
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 13, bottom: 10),
                      child: Row(
                        children: [
                          Text(Strings.password,
                              style: appTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: ColorRes.black.withOpacity(0.6))),
                          Text(
                            '*',
                            style: appTextStyle(
                                fontSize: 15, color: ColorRes.starColor),
                          ),
                        ],
                      ),
                    ),
                    GetBuilder<SignUpControllerM>(
                      id: "showPassword",
                      builder: (controller) => Column(
                        children: [
                          Container(
                            height: 51,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(6, 6),
                                    color: ColorRes.containerColor
                                        .withOpacity(0.10),
                                    spreadRadius: 0,
                                    blurRadius: 35),
                              ],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Material(
                              shadowColor: ColorRes.containerColor,
                              borderRadius: BorderRadius.circular(12),
                              child: commonTextFormField(
                                onChanged: controller.onChanged,
                                controller: controller.passwordController,
                                obscureText: controller.show,
                                textDecoration: InputDecoration(
                                  hintText: 'Password',
                                  fillColor: Colors.transparent,
                                  suffixIcon: IconButton(
                                    icon: controller.show
                                        ? Icon(
                                            Icons.visibility_off,
                                            color: ColorRes.black
                                                .withOpacity(0.15),
                                          )
                                        : Icon(Icons.visibility,
                                            color: ColorRes.black
                                                .withOpacity(0.15)),
                                    onPressed: controller.chang,
                                  ),
                                  filled: true,
                                  hintStyle: appTextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: ColorRes.black.withOpacity(0.15)),
                                  border: controller.passwordController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.pwdError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  focusedBorder: controller
                                          .passwordController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.pwdError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  disabledBorder: controller
                                          .passwordController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.pwdError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  enabledBorder: controller
                                          .passwordController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.pwdError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  errorBorder: controller
                                          .passwordController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.pwdError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  focusedErrorBorder: controller
                                          .passwordController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.pwdError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                ),
                              ),
                            ),
                          ),
                          controller.pwdError == ""
                              ? const SizedBox(height: 20)
                              : Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 28,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: ColorRes.invalidColor),
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Image(
                                          image: AssetImage(
                                            AssetRes.invalid,
                                          ),
                                          height: 14,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          controller.pwdError,
                                          style: appTextStyle(
                                              fontSize: 9,
                                              fontWeight: FontWeight.w400,
                                              color: ColorRes.starColor),
                                        )
                                      ]),
                                ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 13, bottom: 10),
                      child: Row(
                        children: [
                          Text(Strings.city,
                              style: appTextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: ColorRes.black.withOpacity(0.6))),
                          Text(
                            '*',
                            style: appTextStyle(
                                fontSize: 15, color: ColorRes.starColor),
                          ),
                        ],
                      ),
                    ),
                    GetBuilder<SignUpControllerM>(
                      id: "showCity",
                      builder: (controller) => Column(
                        children: [
                          Container(
                            height: 51,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(6, 6),
                                    color: ColorRes.containerColor
                                        .withOpacity(0.10),
                                    spreadRadius: 0,
                                    blurRadius: 35),
                              ],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Material(
                              shadowColor: ColorRes.containerColor,
                              borderRadius: BorderRadius.circular(12),
                              child: commonTextFormField(
                                onChanged: controller.onChanged,
                                controller: controller.cityController,
                                textDecoration: InputDecoration(
                                  hintText: 'City',
                                  fillColor: Colors.transparent,
                                  filled: true,
                                  hintStyle: appTextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: ColorRes.black.withOpacity(0.15)),
                                  border: controller.cityController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.cityError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  focusedBorder: controller.cityController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.cityError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  disabledBorder: controller.cityController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.cityError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  enabledBorder: controller.cityController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.cityError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  errorBorder: controller.cityController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.cityError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  focusedErrorBorder: controller
                                          .cityController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.cityError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                ),
                              ),
                            ),
                          ),
                          controller.cityError == ""
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Image(
                                          image: AssetImage(
                                            AssetRes.invalid,
                                          ),
                                          height: 14,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(controller.cityError,
                                            style: appTextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 9,
                                                color: ColorRes.starColor))
                                      ]),
                                ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 13, bottom: 10),
                      child: Row(
                        children: [
                          Text(Strings.state,
                              style: appTextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: ColorRes.black.withOpacity(0.6))),
                          const Text(
                            '*',
                            style: TextStyle(
                                fontSize: 15, color: ColorRes.starColor),
                          ),
                        ],
                      ),
                    ),
                    GetBuilder<SignUpControllerM>(
                      id: "showState",
                      builder: (controller) => Column(
                        children: [
                          Container(
                            height: 51,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(6, 6),
                                    color: ColorRes.containerColor
                                        .withOpacity(0.10),
                                    spreadRadius: 0,
                                    blurRadius: 35),
                              ],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Material(
                              shadowColor: Colors.purple.shade700,
                              borderRadius: BorderRadius.circular(12),
                              child: commonTextFormField(
                                onChanged: controller.onChanged,
                                controller: controller.stateController,
                                textDecoration: InputDecoration(
                                  hintText: 'State',
                                  fillColor: Colors.transparent,
                                  filled: true,
                                  hintStyle: appTextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: ColorRes.black.withOpacity(0.15)),
                                  border: controller.stateController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.stateError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  focusedBorder: controller.stateController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.stateError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  disabledBorder: controller
                                          .stateController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.stateError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  enabledBorder: controller.stateController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.stateError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  errorBorder: controller.stateController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.stateError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  focusedErrorBorder: controller
                                          .stateController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.stateError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                ),
                              ),
                            ),
                          ),
                          controller.stateError == ""
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Image(
                                          image: AssetImage(
                                            AssetRes.invalid,
                                          ),
                                          height: 14,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(controller.stateError,
                                            style: appTextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 9,
                                                color: ColorRes.starColor))
                                      ]),
                                ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 13, bottom: 10),
                      child: Row(
                        children: [
                          Text(Strings.country,
                              style: appTextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: ColorRes.black.withOpacity(0.6))),
                          const Text(
                            '*',
                            style: TextStyle(
                                fontSize: 15, color: ColorRes.starColor),
                          ),
                        ],
                      ),
                    ),
                    GetBuilder<SignUpControllerM>(
                      id: "showCountry",
                      builder: (controller) => Column(
                        children: [
                          Container(
                            height: 51,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(6, 6),
                                    color: ColorRes.containerColor
                                        .withOpacity(0.10),
                                    spreadRadius: 0,
                                    blurRadius: 35),
                              ],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Material(
                              shadowColor: ColorRes.containerColor,
                              borderRadius: BorderRadius.circular(12),
                              child: commonTextFormField(
                                onChanged: controller.onChanged,
                                controller: controller.countryController,
                                textDecoration: InputDecoration(
                                  hintText: 'Country',
                                  fillColor: Colors.transparent,
                                  suffixIcon: GetBuilder<SignUpControllerM>(
                                    id: "dropdown",
                                    builder: (controller) {
                                      return DropdownButton(
                                          iconSize: 35.0,
                                          iconEnabledColor:
                                              Colors.grey.shade400,
                                          iconDisabledColor:
                                              Colors.grey.shade400,
                                          underline: Container(),
                                          icon:
                                              const Icon(Icons.arrow_drop_down),
                                          items: controller.items1.map(
                                            (val) {
                                              return DropdownMenuItem<String>(
                                                value: val,
                                                child: Text(val),
                                              );
                                            },
                                          ).toList(),
                                          onChanged: (String? val) {
                                            controller.changeDropdwon(
                                                val: val!);
                                          });
                                    },
                                  ),
                                  filled: true,
                                  hintStyle: appTextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: ColorRes.black.withOpacity(0.15)),
                                  border: controller.countryController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.countryError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  focusedBorder: controller
                                          .countryController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.countryError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  disabledBorder: controller
                                          .countryController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.countryError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  enabledBorder: controller
                                          .countryController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.countryError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  errorBorder: controller.countryController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.countryError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                  focusedErrorBorder: controller
                                          .countryController.text
                                          .trim()
                                          .isEmpty
                                      ? InputBorder.none
                                      : controller.countryError.isNotEmpty
                                          ? errorBorder()
                                          : enableBorder(),
                                ),
                              ),
                            ),
                          ),
                          controller.countryError == ""
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Image(
                                          image: AssetImage(
                                            AssetRes.invalid,
                                          ),
                                          height: 14,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(controller.countryError,
                                            style: appTextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 9,
                                                color: ColorRes.starColor))
                                      ]),
                                ),
                        ],
                      ),
                    ),
                    GetBuilder<SignUpControllerM>(
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
                                Text(Strings.rememberMe,
                                    style: appTextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: ColorRes.black))
                              ],
                            ),
                          );
                        }),
                    const SizedBox(height: 25),
                    GetBuilder<SignUpControllerM>(
                        id: "dark",
                        builder: (controller) {
                          return
                              /* (controller.firstnameController.text == '' ||
                                  controller.lastnameController.text == '' ||
                                  controller.emailController.text == '' ||
                                  controller.phoneController.text == '' ||
                                  controller.passwordController.text == '' ||
                                  controller.cityController.text == '' ||
                                  controller.stateController.text == '' ||
                                  controller.countryController.text == '')
                              ? Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(colors: [
                                      ColorRes.gradientColor.withOpacity(0.2),
                                      ColorRes.containerColor.withOpacity(0.4)
                                    ]),
                                  ),
                                  child: Text("Sign up",
                                      style: appTextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: ColorRes.white)),
                                )
                              :*/
                              InkWell(
                            // dashboard write
                            onTap: controller.onSignUpBtnTap,
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(colors: [
                                  ColorRes.gradientColor,
                                  ColorRes.containerColor
                                ]),
                              ),
                              child: Text(Strings.signUp,
                                  style: appTextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: ColorRes.white)),
                            ),
                          );
                        }),
                    const SizedBox(height: 28),
                    Center(
                      child: InkWell(
                        onTap: () {},
                        child: Text(Strings.orContinueWith,
                            style: appTextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: ColorRes.black)),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          width: 145,
                          decoration: BoxDecoration(
                              border: Border.all(color: ColorRes.borderColor),
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(6, 6),
                                    color: ColorRes.containerColor
                                        .withOpacity(0.08),
                                    spreadRadius: 0,
                                    blurRadius: 35),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              color: ColorRes.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Image(
                                image: AssetImage(
                                  AssetRes.facebookImage,
                                ),
                                height: 27,
                              ),
                              const SizedBox(width: 15),
                              Text(Strings.facebook,
                                  style: appTextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: ColorRes.black))
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.SignUpWithGoogle();
                          },
                          child: Container(
                            height: 50,
                            width: 145,
                            decoration: BoxDecoration(
                                border: Border.all(color: ColorRes.borderColor),
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(6, 6),
                                      color: ColorRes.containerColor
                                          .withOpacity(0.08),
                                      spreadRadius: 0,
                                      blurRadius: 35),
                                ],
                                borderRadius: BorderRadius.circular(10),
                                color: ColorRes.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Image(
                                  image: AssetImage(
                                    AssetRes.googleLogo,
                                  ),
                                  height: 27,
                                ),
                                const SizedBox(width: 15),
                                Text(Strings.google,
                                    style: appTextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: ColorRes.black))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Strings.alreadyHaveAccount,
                          style: appTextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: ColorRes.black),
                        ),
                        GetBuilder<SignUpControllerM>(
                          builder: (controller) => InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (con) => const SignInScreenM()));
                            },
                            child: Text(
                              Strings.signIn,
                              style: appTextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: ColorRes.containerColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            )),
            controller.loading.isTrue
                ? const Center(
                    child: CommonLoader(),
                  )
                : const SizedBox(),
          ],
        );
      }),
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

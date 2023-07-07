import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/common/widgets/common_loader.dart';
import 'package:blukers_client_app/common/widgets/common_text_field.dart';
import 'package:blukers_client_app/screen/auth/sign_in_screen/sign_in_controller.dart';
import 'package:blukers_client_app/screen/auth/sign_in_screen/sign_in_screen.dart';
import 'package:blukers_client_app/screen/auth/sign_up/sign_up_controller.dart';
import 'package:blukers_client_app/screen/auth/sign_up/widget/signup_bottom/country.dart';
import 'package:blukers_client_app/service/pref_services.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/pref_keys.dart';
import 'package:blukers_client_app/utils/string.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignUpController controller = Get.put(SignUpController());
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Obx(() {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
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
                      GetBuilder<SignUpController>(
                        id: "showFirstname",
                        builder: (controller) => texFieldColumn(
                            title: Strings.firstName,
                            hintText: 'First Name',
                            onChanged: controller.onChanged,
                            error: controller.firstError,
                            txtController: controller.firstnameController),
                      ),
                      const SizedBox(height: 10),
                      GetBuilder<SignUpController>(
                        id: "showLastname",
                        builder: (controller) => texFieldColumn(
                          title: Strings.lastName,
                          hintText: 'Last Name',
                          onChanged: controller.onChanged,
                          error: controller.lastError,
                          txtController: controller.lastnameController,
                        ),
                      ),
                      const SizedBox(height: 10),
                      GetBuilder<SignUpController>(
                        id: "showEmail",
                        builder: (controller) => texFieldColumn(
                            title: Strings.email,
                            hintText: 'Email',
                            onChanged: controller.onChanged,
                            error: controller.emailError,
                            txtController: controller.emailController),
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
                      GetBuilder<SignUpController>(
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
                                        keyboardType: TextInputType.number,
                                        controller: controller.phoneController,
                                        onChanged: controller.onChanged,
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
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
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
                                          ),
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
                            Text(
                              Strings.password,
                              style: appTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
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
                      GetBuilder<SignUpController>(
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
                                  controller: controller.passwordController,
                                  obscureText: controller.show,
                                  onChanged: controller.onChanged,
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
                                        color:
                                            ColorRes.black.withOpacity(0.15)),
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
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
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
                      GetBuilder<SignUpController>(
                        id: "showOccupation",
                        builder: (controller) => texFieldColumn(
                            title: Strings.occupation,
                            hintText: 'Occupation',
                            onChanged: controller.onChanged,
                            error: controller.occupationError,
                            txtController: controller.occupationController),
                      ),
                      const SizedBox(height: 10),
                      GetBuilder<SignUpController>(
                        id: "showCity",
                        builder: (controller) => texFieldColumn(
                            title: Strings.city,
                            hintText: 'City',
                            onChanged: controller.onChanged,
                            error: controller.cityError,
                            txtController: controller.cityController),
                      ),
                      const SizedBox(height: 10),
                      GetBuilder<SignUpController>(
                        id: "showState",
                        builder: (controller) => texFieldColumn(
                          title: Strings.state,
                          hintText: 'State',
                          onChanged: controller.onChanged,
                          error: controller.stateError,
                          txtController: controller.stateController,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 13, bottom: 10),
                        child: Row(
                          children: [
                            Text(
                              Strings.country,
                              style: appTextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: ColorRes.black.withOpacity(0.6),
                              ),
                            ),
                            const Text(
                              '*',
                              style: TextStyle(
                                  fontSize: 15, color: ColorRes.starColor),
                            ),
                          ],
                        ),
                      ),
                      GetBuilder<SignUpController>(
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
                                  controller: controller.countryController,
                                  textDecoration: InputDecoration(
                                    hintText: 'Country',
                                    fillColor: Colors.transparent,
                                    suffixIcon: GetBuilder<SignUpController>(
                                      id: "dropdown",
                                      builder: (controller) {
                                        return DropdownButton(
                                            iconSize: 35.0,
                                            iconEnabledColor:
                                                Colors.grey.shade400,
                                            iconDisabledColor:
                                                Colors.grey.shade400,
                                            underline: Container(),
                                            icon: const Icon(
                                                Icons.arrow_drop_down),
                                            items: controller.items.map(
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
                                        color:
                                            ColorRes.black.withOpacity(0.15)),
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
                                    errorBorder: controller
                                            .countryController.text
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
                      GetBuilder<SignUpController>(
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
                                        width: 1,
                                        color: ColorRes.containerColor),
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
                      GetBuilder<SignUpController>(
                          id: "dark",
                          builder: (controller) {
                            return InkWell(
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
                          InkWell(
                            onTap: () {
                              controller.faceBookSignIn();
                            },
                            child: Container(
                              height: 50,
                              width: 145,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: ColorRes.borderColor),
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
                                  Text(
                                    Strings.facebook,
                                    style: appTextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: ColorRes.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              controller.signWithGoogle();
                            },
                            child: Container(
                              height: 50,
                              width: 145,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: ColorRes.borderColor),
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
                                          color: ColorRes.black)),
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
                          GetBuilder<SignUpController>(
                            builder: (controller) => InkWell(
                              onTap: () async {
                                SignInScreenController controller2 =
                                    Get.put(SignInScreenController());
                                controller2.emailController.clear();
                                controller2.passwordController.clear();
                                await PrefService.setValue(
                                    PrefKeys.firstnameu,
                                    controller.firstnameController.text
                                        .toString());
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (con) => const SigninScreenU(),
                                  ),
                                ).then((value) => {
                                      controller.firstnameController.clear(),
                                      controller.lastnameController.clear(),
                                      controller.emailController.clear(),
                                      controller.phoneController.clear(),
                                      controller.passwordController.clear(),
                                      controller.occupationController.clear(),
                                      controller.cityController.clear(),
                                      controller.stateController.clear(),
                                      controller.countryController.clear(),
                                    });
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
                    ],
                  ),
                ),
              ),
              controller.loading.isTrue
                  ? const Center(
                      child: CommonLoader(),
                    )
                  : const SizedBox(),
            ],
          );
        }),
      ),
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

Widget texFieldColumn({
  required String title,
  required String hintText,
  required String error,
  Function(String)? onChanged,
  required TextEditingController txtController,
  bool? read,
}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 15, bottom: 10),
        child: Row(
          children: [
            Text(title,
                style: appTextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: ColorRes.black.withOpacity(0.6))),
            Text(
              '*',
              style: appTextStyle(fontSize: 15, color: ColorRes.starColor),
            ),
          ],
        ),
      ),
      Container(
        height: 51,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                offset: const Offset(6, 6),
                color: ColorRes.containerColor.withOpacity(0.10),
                spreadRadius: 0,
                blurRadius: 35),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Material(
          shadowColor: ColorRes.containerColor,
          borderRadius: BorderRadius.circular(12),
          child: commonTextFormField(
            controller: txtController,
            readOnly: read ?? false,
            onChanged: onChanged,
            textDecoration: InputDecoration(
              hintText: hintText,
              fillColor: Colors.transparent,
              filled: true,
              hintStyle: appTextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: ColorRes.black.withOpacity(0.15)),
              border: txtController.text.trim().isEmpty
                  ? InputBorder.none
                  : error.isNotEmpty
                      ? errorBorder()
                      : enableBorder(),
              focusedBorder: txtController.text.trim().isEmpty
                  ? InputBorder.none
                  : error.isNotEmpty
                      ? errorBorder()
                      : enableBorder(),
              disabledBorder: txtController.text.trim().isEmpty
                  ? InputBorder.none
                  : error.isNotEmpty
                      ? errorBorder()
                      : enableBorder(),
              enabledBorder: txtController.text.trim().isEmpty
                  ? InputBorder.none
                  : error.isNotEmpty
                      ? errorBorder()
                      : enableBorder(),
              errorBorder: txtController.text.trim().isEmpty
                  ? InputBorder.none
                  : error.isNotEmpty
                      ? errorBorder()
                      : enableBorder(),
              focusedErrorBorder: txtController.text.trim().isEmpty
                  ? InputBorder.none
                  : error.isNotEmpty
                      ? errorBorder()
                      : enableBorder(),
            ),
          ),
        ),
      ),
      error == ""
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
                  Text(error,
                      style: appTextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 9,
                          color: ColorRes.starColor))
                ],
              ),
            ),
    ],
  );
}

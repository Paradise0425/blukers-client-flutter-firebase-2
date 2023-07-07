import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/common_text_field.dart';
import 'package:blukers_client_app/screen/auth/sign_up/google_signup_controller.dart';
import 'package:blukers_client_app/screen/auth/sign_up/sign_up_screen.dart';
import 'package:blukers_client_app/screen/auth/sign_up/widget/signup_bottom/country.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';

class GoogleSignupScreen extends StatelessWidget {
  final String email;
  final String firstName;
  final String lastName;
  final String uid;
  const GoogleSignupScreen(
      {Key? key,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("EMAIL : $email , $firstName , $lastName");
    }

    /*  GoogleSignupController
    controller = Get.put(GoogleSignupController(
        uid: uid, email: email, firstname: firstName, lastname: lastName));*/

    return Scaffold(
      backgroundColor: ColorRes.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 50,
            ),
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
            GetBuilder<GoogleSignupController>(
              id: "showFirstname",
              builder: (controller) => texFieldColumn(
                  title: Strings.firstName,
                  hintText: 'First Name',
                  onChanged: controller.onChanged,
                  error: controller.firstError,
                  txtController: controller.firstnameController),
            ),
            const SizedBox(height: 10),
            GetBuilder<GoogleSignupController>(
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
            GetBuilder<GoogleSignupController>(
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
                    style:
                        appTextStyle(fontSize: 15, color: ColorRes.starColor),
                  ),
                ],
              ),
            ),
            GetBuilder<GoogleSignupController>(
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
                          color: controller.phoneController.text.trim().isEmpty
                              ? ColorRes.borderColor
                              : controller.phoneError == ""
                                  ? ColorRes.containerColor
                                  : ColorRes.starColor),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(6, 6),
                            color: ColorRes.containerColor.withOpacity(0.10),
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
                                  hintText: 'Phone number',
                                  fillColor: ColorRes.white,
                                  filled: true,
                                  hintStyle: appTextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: ColorRes.black.withOpacity(0.15)),
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
                          margin: const EdgeInsets.symmetric(vertical: 10),
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
              padding: const EdgeInsets.only(left: 15, bottom: 10),
              child: Row(
                children: [
                  Text(Strings.occupation,
                      style: appTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: ColorRes.black.withOpacity(0.6))),
                  Text(
                    '*',
                    style:
                        appTextStyle(fontSize: 15, color: ColorRes.starColor),
                  ),
                ],
              ),
            ),
            GetBuilder<GoogleSignupController>(
              id: "showOccupation",
              builder: (controller) => Column(
                children: [
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
                        controller: controller.occupationController,
                        onChanged: controller.onChanged,
                        // obscureText: controller.show,
                        textDecoration: InputDecoration(
                          hintText: 'Occupation',
                          fillColor: Colors.transparent,
                          filled: true,
                          hintStyle: appTextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: ColorRes.black.withOpacity(0.15)),
                          border: controller.occupationController.text
                                  .trim()
                                  .isEmpty
                              ? InputBorder.none
                              : controller.occupationError.isNotEmpty
                                  ? errorBorder()
                                  : enableBorder(),
                          focusedBorder: controller.occupationController.text
                                  .trim()
                                  .isEmpty
                              ? InputBorder.none
                              : controller.occupationError.isNotEmpty
                                  ? errorBorder()
                                  : enableBorder(),
                          disabledBorder: controller.occupationController.text
                                  .trim()
                                  .isEmpty
                              ? InputBorder.none
                              : controller.occupationError.isNotEmpty
                                  ? errorBorder()
                                  : enableBorder(),
                          enabledBorder: controller.occupationController.text
                                  .trim()
                                  .isEmpty
                              ? InputBorder.none
                              : controller.occupationError.isNotEmpty
                                  ? errorBorder()
                                  : enableBorder(),
                          errorBorder: controller.occupationController.text
                                  .trim()
                                  .isEmpty
                              ? InputBorder.none
                              : controller.occupationError.isNotEmpty
                                  ? errorBorder()
                                  : enableBorder(),
                          focusedErrorBorder: controller
                                  .occupationController.text
                                  .trim()
                                  .isEmpty
                              ? InputBorder.none
                              : controller.occupationError.isNotEmpty
                                  ? errorBorder()
                                  : enableBorder(),
                        ),
                      ),
                    ),
                  ),
                  controller.occupationError == ""
                      ? const SizedBox(height: 20)
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          height: 28,
                          margin: const EdgeInsets.symmetric(vertical: 10),
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
                                controller.occupationError,
                                style: appTextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w400,
                                    color: ColorRes.starColor),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            GetBuilder<GoogleSignupController>(
              id: "showCity",
              builder: (controller) => texFieldColumn(
                  title: Strings.city,
                  hintText: 'City',
                  onChanged: controller.onChanged,
                  error: controller.cityError,
                  txtController: controller.cityController),
            ),
            const SizedBox(height: 10),
            GetBuilder<GoogleSignupController>(
                id: "showState",
                builder: (controller) => texFieldColumn(
                      title: Strings.state,
                      hintText: 'State',
                      onChanged: controller.onChanged,
                      error: controller.stateError,
                      txtController: controller.stateController,
                    )),
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
                    style: TextStyle(fontSize: 15, color: ColorRes.starColor),
                  ),
                ],
              ),
            ),
            GetBuilder<GoogleSignupController>(
              id: "showCountry",
              builder: (controller) => Column(
                children: [
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
                        controller: controller.countryController,
                        textDecoration: InputDecoration(
                          hintText: 'Country',
                          fillColor: Colors.transparent,
                          suffixIcon: GetBuilder<GoogleSignupController>(
                            id: "dropdown",
                            builder: (controller) {
                              return DropdownButton(
                                  iconSize: 35.0,
                                  iconEnabledColor: Colors.grey.shade400,
                                  iconDisabledColor: Colors.grey.shade400,
                                  underline: Container(),
                                  icon: const Icon(Icons.arrow_drop_down),
                                  items: controller.items.map(
                                    (val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (String? val) {
                                    controller.changeDropdwon(val: val!);
                                  });
                            },
                          ),
                          filled: true,
                          hintStyle: appTextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: ColorRes.black.withOpacity(0.15)),
                          border:
                              controller.countryController.text.trim().isEmpty
                                  ? InputBorder.none
                                  : controller.countryError.isNotEmpty
                                      ? errorBorder()
                                      : enableBorder(),
                          focusedBorder:
                              controller.countryController.text.trim().isEmpty
                                  ? InputBorder.none
                                  : controller.countryError.isNotEmpty
                                      ? errorBorder()
                                      : enableBorder(),
                          disabledBorder:
                              controller.countryController.text.trim().isEmpty
                                  ? InputBorder.none
                                  : controller.countryError.isNotEmpty
                                      ? errorBorder()
                                      : enableBorder(),
                          enabledBorder:
                              controller.countryController.text.trim().isEmpty
                                  ? InputBorder.none
                                  : controller.countryError.isNotEmpty
                                      ? errorBorder()
                                      : enableBorder(),
                          errorBorder:
                              controller.countryController.text.trim().isEmpty
                                  ? InputBorder.none
                                  : controller.countryError.isNotEmpty
                                      ? errorBorder()
                                      : enableBorder(),
                          focusedErrorBorder:
                              controller.countryController.text.trim().isEmpty
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
            GetBuilder<GoogleSignupController>(
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
                        Text(
                          Strings.rememberMe,
                          style: appTextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: ColorRes.black),
                        ),
                      ],
                    ),
                  );
                }),
            const SizedBox(height: 25),
            GetBuilder<GoogleSignupController>(
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
          ]),
        ),
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/screen/auth/sign_up/sign_up_screen.dart';
import 'package:blukers_client_app/screen/auth/sign_up/widget/signup_bottom/country.dart';
import 'package:blukers_client_app/screen/manager_section/auth_manager/sign_up_new/google_sign_up_new_controller.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';

class GoogleSignupScreenM extends StatelessWidget {
  final String email;
  final String firstName;
  final String lastName;
  final String uid;
  const GoogleSignupScreenM(
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

    /* GoogleSignUpControllerM controller = Get.put(GoogleSignUpControllerM(
        email: email, firstname: firstName, lastname: lastName, uid: uid));*/

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
            GetBuilder<GoogleSignUpControllerM>(
              id: "showFirstname",
              builder: (controller) => texFieldColumn(
                  title: Strings.firstName,
                  hintText: 'First Name',
                  onChanged: controller.onChanged,
                  error: controller.firstError,
                  txtController: controller.firstnameController),
            ),
            const SizedBox(height: 10),
            GetBuilder<GoogleSignUpControllerM>(
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
            GetBuilder<GoogleSignUpControllerM>(
              id: "showEmail",
              builder: (controller) => texFieldColumn(
                  title: Strings.email,
                  hintText: 'Email',
                  read: true,
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
            GetBuilder<GoogleSignUpControllerM>(
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
                                  // prefix:countryCodePicker(context) ,
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
            GetBuilder<GoogleSignUpControllerM>(
              id: "showCity",
              builder: (controller) => texFieldColumn(
                  title: Strings.city,
                  hintText: 'City',
                  onChanged: controller.onChanged,
                  error: controller.cityError,
                  txtController: controller.cityController),
            ),
            const SizedBox(height: 10),
            GetBuilder<GoogleSignUpControllerM>(
                id: "showState",
                builder: (controller) => texFieldColumn(
                      title: Strings.state,
                      hintText: 'State',
                      onChanged: controller.onChanged,
                      error: controller.stateError,
                      txtController: controller.stateController,
                    )),
            const SizedBox(height: 10),
            GetBuilder<GoogleSignUpControllerM>(
                id: "showCountry",
                builder: (controller) => texFieldColumn(
                      title: Strings.country,
                      hintText: 'Country',
                      onChanged: controller.onChanged,
                      error: controller.countryError,
                      txtController: controller.countryController,
                    )),
            GetBuilder<GoogleSignUpControllerM>(
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
                        )
                      ],
                    ),
                  );
                }),
            const SizedBox(height: 25),
            GetBuilder<GoogleSignUpControllerM>(
                id: "dark",
                builder: (controller) {
                  return
                      /* (controller.firstnameController.text == '' ||
                      controller.lastnameController.text == '' ||
                      controller.emailController.text == '' ||
                      controller.phoneController.text == '' ||
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
                        borderRadius: BorderRadius.circular(6),
                        color: ColorRes.blukersOrangeColor,
                        // gradient: const LinearGradient(colors: [
                        //   ColorRes.gradientColor,
                        //   ColorRes.containerColor
                        // ]),
                      ),
                      child: Text(
                        Strings.signUp,
                        style: appTextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: ColorRes.white),
                      ),
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

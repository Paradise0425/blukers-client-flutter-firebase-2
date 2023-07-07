import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/common/widgets/common_loader.dart';
import 'package:blukers_client_app/common/widgets/common_text_field.dart';
import 'package:blukers_client_app/screen/job_detail_screen/job_detail_upload_cv_screen/upload_cv_controller.dart';
import 'package:blukers_client_app/screen/manager_section/auth_manager/Sign_in/sign_in_controller.dart';
import 'package:blukers_client_app/screen/manager_section/auth_manager/forgot_Password/forgot_password_screen.dart';
import 'package:blukers_client_app/screen/manager_section/auth_manager/sign_up_new/sign_up_new_screen.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';

class SignInScreenM extends StatefulWidget {
  const SignInScreenM({Key? key}) : super(key: key);

  @override
  State<SignInScreenM> createState() => _SignInScreenMState();
}

class _SignInScreenMState extends State<SignInScreenM> {
  SignInScreenControllerM controller = Get.put(SignInScreenControllerM());

  final formGlobalKey = GlobalKey<FormState>();

  JobDetailsUploadCvController jobDetailsUploadCvController =
      Get.put(JobDetailsUploadCvController());
  @override
  void initState() {
    controller.getRememberEmailDataManger();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    jobDetailsUploadCvController.init();
    return Scaffold(
        backgroundColor: ColorRes.white,
        body: Obx(() {
          return Stack(children: [
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
                        child: Text(Strings.signInToYourAccount,
                            style: appTextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: ColorRes.black)),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 10),
                        child: Form(
                          key: formGlobalKey,
                          child: Row(
                            children: [
                              Text(Strings.email,
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
                      ),
                      GetBuilder<SignInScreenControllerM>(
                        id: "showEmail",
                        builder: (controller) => Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(6, 6),
                                      color: ColorRes.containerColor
                                          .withOpacity(0.12),
                                      spreadRadius: 0,
                                      blurRadius: 35),
                                ],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Material(
                                shadowColor: ColorRes.containerColor,
                                borderRadius: BorderRadius.circular(10),
                                child: commonTextFormField(
                                  onChanged: controller.onChanged,
                                  controller: controller.emailController,
                                  textDecoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    hintText: 'Email',
                                    fillColor: Colors.transparent,
                                    filled: true,
                                    hintStyle: appTextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            ColorRes.black.withOpacity(0.15)),
                                    border: controller.emailController.text
                                            .trim()
                                            .isEmpty
                                        ? InputBorder.none
                                        : controller.emailError.isNotEmpty
                                            ? errorBorder()
                                            : enableBorder(),
                                    focusedBorder: controller
                                            .emailController.text
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
                                    enabledBorder: controller
                                            .emailController.text
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
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 10),
                        child: Row(
                          children: [
                            Text(Strings.password,
                                style: appTextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: ColorRes.black.withOpacity(0.6))),
                            const Text(
                              '*',
                              style: TextStyle(
                                  fontSize: 15, color: ColorRes.starColor),
                            ),
                          ],
                        ),
                      ),
                      GetBuilder<SignInScreenControllerM>(
                        id: "showPassword",
                        builder: (controller) => Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(6, 6),
                                      color: ColorRes.containerColor
                                          .withOpacity(0.13),
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
                                    contentPadding: const EdgeInsets.all(10),
                                    hintText: 'Password',
                                    fillColor: Colors.transparent,
                                    suffixIcon: IconButton(
                                      icon: controller.show
                                          ? Icon(Icons.visibility_off,
                                              color: ColorRes.black
                                                  .withOpacity(0.15))
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
                                    width: 339,
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
                                          ),
                                        ]),
                                  ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          GetBuilder<SignInScreenControllerM>(
                              id: "remember_me",
                              builder: (controller) {
                                return InkWell(
                                  onTap: () {
                                    controller.rememberMe =
                                        !controller.rememberMe;
                                    controller.update(["remember_me"]);
                                  },
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        activeColor: ColorRes.containerColor,
                                        checkColor: ColorRes.white,
                                        side: const BorderSide(
                                            width: 1.2,
                                            color: ColorRes.containerColor),
                                        value: controller.rememberMe,
                                        onChanged:
                                            controller.onRememberMeChange,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
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
                        ],
                      ),
                      const SizedBox(height: 25),
                      GetBuilder<SignInScreenControllerM>(
                          id: "colorChange",
                          builder: (controller) {
                            return InkWell(
                              onTap: controller.onLoginBtnTap,
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
                                child: Text(Strings.signIn,
                                    style: appTextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: ColorRes.white)),
                              ),
                            );
                          }),
                      const SizedBox(height: 18),
                      Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (con) => ForgotPasswordScreenM()));
                          },
                          child: Text(Strings.forgotThePassword,
                              style: appTextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: ColorRes.containerColor)),
                        ),
                      ),
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
                                  Text(Strings.facebook,
                                      style: appTextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: ColorRes.black))
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
                                  Text(
                                    Strings.google,
                                    style: appTextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: ColorRes.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 27),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Strings.donTHaveAccount,
                            style: appTextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: ColorRes.black),
                          ),
                          GetBuilder<SignInScreenControllerM>(
                            builder: (controller) => InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (con) => SignUpScreenM(),
                                  ),
                                ).then((value) => {
                                      controller.passwordController.clear(),
                                      controller.emailController.clear()
                                    });
                              },
                              child: Text(
                                Strings.signUp,
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
              ),
            ),
            controller.loading.isTrue
                ? const Center(
                    child: CommonLoader(),
                  )
                : const SizedBox(),
          ]);
        }));
  }

  OutlineInputBorder enableBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: ColorRes.containerColor),
      borderRadius: BorderRadius.circular(10),
    );
  }

  OutlineInputBorder errorBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: ColorRes.starColor),
      borderRadius: BorderRadius.circular(10),
    );
  }
}

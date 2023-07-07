import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/common/widgets/common_loader.dart';
import 'package:blukers_client_app/common/widgets/common_text_field.dart';
import 'package:blukers_client_app/screen/auth/forgot_password_new/forgot_password_new_screen.dart';
import 'package:blukers_client_app/screen/auth/sign_in_screen/sign_in_controller.dart';
import 'package:blukers_client_app/screen/auth/sign_up/sign_up_screen.dart';
import 'package:blukers_client_app/screen/job_detail_screen/job_detail_upload_cv_screen/upload_cv_controller.dart';
import 'package:blukers_client_app/service/pref_services.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/pref_keys.dart';
import 'package:blukers_client_app/utils/string.dart';

class SigninScreenU extends StatefulWidget {
  const SigninScreenU({Key? key}) : super(key: key);

  @override
  State<SigninScreenU> createState() => _SigninScreenUState();
}

class _SigninScreenUState extends State<SigninScreenU> {
  SignInScreenController controller = Get.put(SignInScreenController());

  JobDetailsUploadCvController jobDetailsUploadCvController =
      Get.put(JobDetailsUploadCvController());
  @override
  void initState() {
    controller.getRememberEmailDataUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    jobDetailsUploadCvController.init();
    return Scaffold(
        backgroundColor: ColorRes.white,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Obx(() {
            return Stack(children: [
              SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 50),
                        backButton(),
                        // SizedBox(height: Get.height * 0.061),
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
                        SizedBox(height: Get.height * 0.022),
                        Center(
                          child: Text(
                            Strings.signInToYourAccount,
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: ColorRes.black),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.05),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 15, bottom: Get.height * 0.012),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: .0),
                                child: Text(
                                  Strings.email,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: ColorRes.black.withOpacity(0.6),
                                  ),
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
                        GetBuilder<SignInScreenController>(
                          id: "showEmail",
                          builder: (controller) => Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0, 0),
                                      color: ColorRes.containerColor
                                          .withOpacity(0.15),
                                      spreadRadius: -8,
                                      blurRadius: 20,
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: commonTextFormField(
                                  onChanged: controller.onChanged,
                                  controller: controller.emailController,
                                  textDecoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(
                                        left: 15,
                                        top: 10,
                                        bottom: 10,
                                        right: 15),
                                    hintText: 'Email',
                                    fillColor: Colors.transparent,
                                    filled: true,
                                    hintStyle: GoogleFonts.poppins(
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
                              controller.emailError == ""
                                  ? const SizedBox()
                                  : Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      width: 339,
                                      height: 28,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
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
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 9,
                                                    color: ColorRes.starColor))
                                          ]),
                                    ),
                            ],
                          ),
                        ),
                        SizedBox(height: Get.height * 0.025),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 13, bottom: Get.height * 0.012),
                          child: Row(
                            children: [
                              Text(Strings.password,
                                  style: GoogleFonts.poppins(
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
                        GetBuilder<SignInScreenController>(
                          id: "showPassword",
                          builder: (controller) => Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0, 0),
                                      color: ColorRes.containerColor
                                          .withOpacity(0.15),
                                      spreadRadius: -8,
                                      blurRadius: 20,
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: commonTextFormField(
                                  onChanged: controller.onChanged,
                                  controller: controller.passwordController,
                                  obscureText: controller.show,
                                  textDecoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(
                                        left: 13,
                                        top: 10,
                                        bottom: 10,
                                        right: 15),
                                    hintText: 'Password',
                                    fillColor: Colors.transparent,
                                    suffixIcon: IconButton(
                                      icon: controller.show
                                          ? Icon(
                                              Icons.visibility_off,
                                              color: ColorRes.black
                                                  .withOpacity(0.15),
                                            )
                                          : Icon(
                                              Icons.visibility,
                                              color: ColorRes.black
                                                  .withOpacity(0.15),
                                            ),
                                      onPressed: controller.chang,
                                    ),
                                    filled: true,
                                    hintStyle: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: ColorRes.black.withOpacity(0.15),
                                    ),
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
                              controller.pwdError == ""
                                  ? const SizedBox()
                                  : Container(
                                      width: 339,
                                      height: 28,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
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
                                            style: GoogleFonts.poppins(
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
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            GetBuilder<SignInScreenController>(
                                id: "remember_me",
                                builder: (controller) {
                                  return InkWell(
                                    onTap: () {
                                      controller.rememberMe =
                                          !controller.rememberMe;
                                      if (controller.rememberMe) {
                                        PrefService.setValue(PrefKeys.email,
                                            controller.emailController.text);
                                        PrefService.setValue(PrefKeys.password,
                                            controller.passwordController.text);
                                        PrefService.setValue(
                                            PrefKeys.rememberMe,
                                            controller.rememberMe);
                                      } else {
                                        PrefService.remove(
                                          PrefKeys.email,
                                        );
                                        PrefService.remove(
                                          PrefKeys.password,
                                        );
                                        PrefService.remove(
                                          PrefKeys.rememberMe,
                                        );
                                      }
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
                                        Text(
                                          Strings.rememberMe,
                                          style: GoogleFonts.poppins(
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
                        SizedBox(height: Get.height * 0.036),
                        GetBuilder<SignInScreenController>(
                            id: "colorChange",
                            builder: (controller) {
                              return InkWell(
                                onTap: () {
                                  controller.onLoginBtnTap(
                                      password:
                                          controller.passwordController.text,
                                      email: controller.emailController.text);
                                },
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
                                  child: Text(
                                    Strings.signIn,
                                    style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: ColorRes.white),
                                  ),
                                ),
                              );
                            }),
                        SizedBox(height: Get.height * 0.022),
                        Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (con) =>
                                          ForgotPasswordScreenU()));
                            },
                            child: Text(
                              Strings.forgotThePassword,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: ColorRes.containerColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.035),
                        Center(
                          child: InkWell(
                            onTap: () {},
                            child: Text(Strings.orContinueWith,
                                style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: ColorRes.black)),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.035),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: ColorRes.black)),
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
                                      style: GoogleFonts.poppins(
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
                        SizedBox(height: Get.height * 0.033),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              Strings.donTHaveAccount,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: ColorRes.black),
                            ),
                            GetBuilder<SignInScreenController>(
                              builder: (controller) => InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (con) => const SignUpScreen(),
                                    ),
                                  ).then((value) {
                                    controller.emailController.clear();
                                    controller.passwordController.clear();
                                  });
                                },
                                child: Text(
                                  Strings.signUp,
                                  style: GoogleFonts.poppins(
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
                  ? const CommonLoader()
                  : const SizedBox(),
            ]);
          }),
        ));
  }

  OutlineInputBorder enableBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: ColorRes.containerColor),
      borderRadius: BorderRadius.circular(12),
    );
  }

  OutlineInputBorder errorBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: ColorRes.starColor),
      borderRadius: BorderRadius.circular(12),
    );
  }
}

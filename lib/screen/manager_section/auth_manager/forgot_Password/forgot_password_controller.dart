import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordControllerM extends GetxController {
  GlobalKey<FormState> forgotFormKey = GlobalKey();

  TextEditingController forgotEmailController = TextEditingController();
  String emailError = "";

  static FirebaseFirestore fireStore = FirebaseFirestore.instance;

  emailValidation() {
    if (forgotEmailController.text.trim() == "") {
      emailError = 'Please Enter email';
    } else {
      if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(forgotEmailController.text)) {
        // return 'Enter  valid Email';
        emailError = '';
      } else {
        emailError = "Invalid email";
      }
    }
  }

  bool validator() {
    emailValidation();
    if (emailError == "") {
      return true;
    } else {
      return false;
    }
  }

  onLoginBtnTap() {
    if (validator()) {
      if (kDebugMode) {
        resetPassword();
        print("GO TO HOME PAGE");
      }
      /*Get.to(OtpScreenM());*/
    }
    update([
      "showEmail",
    ]);
  }

  Future resetPassword() async{

    FirebaseAuth.instance.sendPasswordResetEmail(email:forgotEmailController.text.trim()).then((_) {
      Get.back();
      Get.snackbar("Reset Password", "link has been sent to your email for password reset", colorText: Colors.black);
    }).catchError((error) {
      Get.snackbar("Error", "$error", colorText: const Color(0xffDA1414));
    });

    /*try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email:forgotEmailController.text.trim()).then((value) => (value) {
        print(value);
      });

      Get.snackbar("Reset Password", "Password Reset Email Send", colorText: Colors.black);
    } on FirebaseAuthException catch (x) {
      if (kDebugMode) {
        print(x.toString());
      }
      Get.snackbar("Error", "$x", colorText: const Color(0xffDA1414));
    }*/

  }

  RxBool isEmailValidate = false.obs;
}

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:pinput/pinput.dart';

class OtpController extends GetxController {
  TextEditingController otpController = TextEditingController();
  int seconds = 60;
  Timer? _countDown;
  Future startTimer() async {
    update(["Seconds"]);
    const oneSec = Duration(seconds: 1);
    _countDown = Timer.periodic(
      oneSec,
      (timer) {
        if (seconds == 0) {
          _countDown?.cancel();
          update(["Seconds"]);
        } else {
          seconds--;
          update(["Seconds"]);
        }
      },
    );
    update(["Seconds"]);
  }

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  String otpError = "";
  otpvalidation() {
    if (otpController.text.trim() == "") {
      otpError = "Enter otp";
    } else {
      if (otpController.text.trim().length >= 8) {
        otpError = 'Invalid OTP code';
      } else {
        otpError = "Enter  valid otp";
      }
    }
  }

  bool validator() {
    otpvalidation();

    if (otpError == "") {
      return true;
    } else {
      return false;
    }
  }

  final defaultTheme = PinTheme(
    width: 73,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20, color: ColorRes.black, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: ColorRes.white,
      border: Border.all(color: ColorRes.containerColor),
      borderRadius: BorderRadius.circular(15),
    ),
  );
}

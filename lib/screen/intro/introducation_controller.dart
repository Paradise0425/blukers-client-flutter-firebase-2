import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/screen/new_home_page/new_home_page_screen.dart';

class IntroductionController extends GetxController {
  PageController pageController = PageController();

  RxInt selectIndicator = 0.obs;

  void onSkipTap() {
    Get.offAll(HomePageNewScreenU());
  }
}

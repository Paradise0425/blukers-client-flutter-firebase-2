// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/screen/chat_box/chat_box_screen.dart';
import 'package:blukers_client_app/screen/manager_section/Profile/profile_screen.dart';
import 'package:blukers_client_app/screen/manager_section/dashboard/manager_dashboard_screen_controller.dart';
import 'package:blukers_client_app/screen/manager_section/dashboard/widget.dart';
import 'package:blukers_client_app/screen/manager_section/manager_application_screen/manger_application_screen.dart';
import 'package:blukers_client_app/screen/manager_section/manager_home_screen/manager_home_screen.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class ManagerDashBoardScreen extends StatelessWidget {
  ManagerDashBoardScreen({Key? key}) : super(key: key);
  ManagerDashBoardScreenController controller =
      Get.put(ManagerDashBoardScreenController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        alert(context);
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorRes.backgroundColor,
        body: Obx(
          () => controller.currentTab.value == 0
              ? ManagerHomeScreen()
              : controller.currentTab.value == 1
                  ? ManagerApplicationScreen()
                  : controller.currentTab.value == 2
                      ? ChatBoxScreen()
                      : ProfileScreen(),
        ),
        bottomNavigationBar: Obx(
          () => Container(
            margin: const EdgeInsets.only(left: 18, right: 18, bottom: 10),
            decoration: const BoxDecoration(
              color: ColorRes.white,
              // border: Border.all(),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: SalomonBottomBar(
              margin: const EdgeInsets.all(12),
              selectedItemColor: const Color(0xff8B4EFF),
              unselectedItemColor: ColorRes.containerColor,
              currentIndex: controller.currentTab.value,
              onTap: (int index) {
                controller.onBottomBarChange(index);
              },
              items: [
                /// Home
                SalomonBottomBarItem(
                  selectedColor: ColorRes.containerColor,
                  icon: Image.asset(
                    AssetRes.home,
                    height: 16,
                    width: 16,
                    color: controller.currentTab.value == 0
                        ? ColorRes.containerColor
                        : ColorRes.grey.withOpacity(0.6),
                  ),
                  title: Text(Strings.home,
                      style: controller.currentTab.value == 0
                          ? bottomTitleStyle
                          : bottomTitleStyleDisable),
                ),

                /// application
                SalomonBottomBarItem(
                  icon: Image.asset(
                    AssetRes.applies,
                    height: 16,
                    width: 16,
                    color: controller.currentTab.value == 1
                        ? ColorRes.containerColor
                        : ColorRes.grey.withOpacity(0.6),
                  ),
                  title: Text(Strings.applies,
                      style: controller.currentTab.value == 1
                          ? bottomTitleStyle
                          : bottomTitleStyleDisable),
                ),

                /// chat
                SalomonBottomBarItem(
                  icon: Image.asset(
                    AssetRes.chat,
                    height: 16,
                    width: 16,
                    color: controller.currentTab.value == 2
                        ? ColorRes.containerColor
                        : ColorRes.grey.withOpacity(0.6),
                  ),
                  title: Text(
                    Strings.inbox,
                    style: controller.currentTab.value == 2
                        ? bottomTitleStyle
                        : bottomTitleStyleDisable,
                  ),
                ),

                /// Profile
                SalomonBottomBarItem(
                  icon: Image.asset(
                    AssetRes.profile1,
                    height: 16,
                    width: 16,
                    color: controller.currentTab.value == 3
                        ? ColorRes.containerColor
                        : ColorRes.grey.withOpacity(0.6),
                  ),
                  title: Text(Strings.profile,
                      style: controller.currentTab.value == 3
                          ? bottomTitleStyle
                          : bottomTitleStyleDisable),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

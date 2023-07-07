import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/screen/applies_logo_screen/applies_logo_screen.dart';
import 'package:blukers_client_app/screen/chat_box_user/chat_box_user_screen.dart';
import 'package:blukers_client_app/screen/dashboard/dashboard_controller.dart';
import 'package:blukers_client_app/screen/dashboard/home/home_screen.dart';
import 'package:blukers_client_app/screen/dashboard/widget.dart';
import 'package:blukers_client_app/screen/inbox_logo_screen/inbox_logo_screen.dart';
import 'package:blukers_client_app/screen/new_home_page/new_home_page_screen.dart';
import 'package:blukers_client_app/screen/profile/profile_screen.dart';
import 'package:blukers_client_app/screen/profile_logo_screen/profile_logo_screen.dart';
import 'package:blukers_client_app/service/pref_services.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/pref_keys.dart';
import 'package:blukers_client_app/utils/string.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'applications/applications_screen.dart';

class DashBoardScreen extends StatelessWidget {
  DashBoardScreen({Key? key}) : super(key: key);
  final DashBoardController controller = Get.put(DashBoardController());

  @override
  Widget build(BuildContext context) {
    String token = PrefService.getString(PrefKeys.userId);
    return WillPopScope(
      onWillPop: () async {
        alertU(context);
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorRes.backgroundColor,
        body: GetBuilder<DashBoardController>(
          id: "bottom_bar",
          builder: (controller) {
            return controller.currentTab == 0
                ? token == ""
                    ? HomePageNewScreenU()
                    : HomeScreen()
                : controller.currentTab == 1
                    ? token == ""
                        ? const AppliesLogoScreen()
                        : ApplicationsScreen()
                    : controller.currentTab == 2
                        ? token == ""
                            ? const InboxLogoScreen()
                            : ChatBoxUserScreen()
                        : token == ""
                            ? const ProfileLogoScreen()
                            : ProfileUserScreenU();
          },
        ),
        bottomNavigationBar: GetBuilder<DashBoardController>(
          id: "bottom_bar",
          builder: (controller) {
            return Container(
              margin: const EdgeInsets.only(left: 18, right: 18, bottom: 10),
              decoration: const BoxDecoration(
                  color: ColorRes.white,
                  // border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: SalomonBottomBar(
                margin: const EdgeInsets.all(5),
                selectedItemColor: ColorRes.containerColor,
                unselectedItemColor: ColorRes.containerColor,
                currentIndex: controller.currentTab,
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
                      color: controller.currentTab == 0
                          ? ColorRes.containerColor
                          : ColorRes.grey.withOpacity(0.6),
                    ),
                    title: Text("Home",
                        style: controller.currentTab == 0
                            ? bottomTitleStyle
                            : bottomTitleStyleDisable),
                  ),

                  /// application
                  SalomonBottomBarItem(
                    icon: Image.asset(
                      AssetRes.applies,
                      height: 16,
                      width: 16,
                      color: controller.currentTab == 1
                          ? ColorRes.containerColor
                          : ColorRes.grey.withOpacity(0.6),
                    ),
                    title: Text("Applies",
                        style: controller.currentTab == 1
                            ? bottomTitleStyle
                            : bottomTitleStyleDisable),
                  ),

                  /// chat
                  SalomonBottomBarItem(
                    icon: Image.asset(
                      AssetRes.chat,
                      height: 16,
                      width: 16,
                      color: controller.currentTab == 2
                          ? ColorRes.containerColor
                          : ColorRes.grey.withOpacity(0.6),
                    ),
                    title: Text(
                      "Inbox",
                      style: controller.currentTab == 2
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
                      color: controller.currentTab == 3
                          ? ColorRes.containerColor
                          : ColorRes.grey.withOpacity(0.6),
                    ),
                    title: Text(Strings.profile,
                        style: controller.currentTab == 3
                            ? bottomTitleStyle
                            : bottomTitleStyleDisable),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

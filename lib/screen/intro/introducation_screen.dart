import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/screen/dashboard/dashboard_controller.dart';
import 'package:blukers_client_app/screen/dashboard/dashboard_screen.dart';
import 'package:blukers_client_app/screen/intro/introducation_controller.dart';
import 'package:blukers_client_app/screen/intro/widget/widget.dart';
import 'package:blukers_client_app/screen/manager_section/dashboard/manager_dashboard_screen.dart';
import 'package:blukers_client_app/screen/organization_profile_screen/organization_profile_screen.dart';
import 'package:blukers_client_app/service/pref_services.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/pref_keys.dart';
import 'package:blukers_client_app/utils/string.dart';

class IntroductionScreen extends StatelessWidget {
  IntroductionScreen({Key? key}) : super(key: key);
  final IntroductionController controller = Get.put(IntroductionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Obx(
                  () => controller.selectIndicator.value == 2
                      ? const SizedBox(height: 25)
                      : InkWell(
                          onTap: controller.onSkipTap,
                          child: Text(
                            Strings.skip,
                            style: appTextStyle(
                                fontSize: 15,
                                color: (Theme.of(context).brightness ==
                                        Brightness.dark)
                                    ? Colors.white
                                    : ColorRes.containerColor),
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Container(
              height: Get.height / 1.7,
              alignment: Alignment.center,
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: 3,
                itemBuilder: (context, i) {
                  return i == 0
                      ? pageViewPart(
                          image: AssetRes.page1,
                          title: "search jobs",
                          description:
                              "Lorem ipsum dolor sit amet, consectetur\n    adipiscing elit",
                          textColor: (Theme.of(context).brightness ==
                                  Brightness.dark)
                              ? ColorRes.white
                              : ColorRes.containerColor)
                      : i == 1
                          ? pageViewPart(
                              image: AssetRes.page2,
                              title: "Apply Job",
                              description:
                                  "Lorem ipsum dolor sit amet, consectetur\n    adipiscing elit",
                              textColor: (Theme.of(context).brightness ==
                                      Brightness.dark)
                                  ? ColorRes.white
                                  : ColorRes.containerColor)
                          : pageViewPart(
                              image: AssetRes.page3,
                              title: "Ready For The Job!",
                              description:
                                  "Lorem ipsum dolor sit amet, consectetur\n    adipiscing elit",
                              textColor: (Theme.of(context).brightness ==
                                      Brightness.dark)
                                  ? Colors.white
                                  : Colors.black);
                },
                onPageChanged: (val) {
                  controller.selectIndicator.value = val;
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 9,
              width: 50,
              child: ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Obx(() => indicator(
                        controller.selectIndicator.value == index
                            ? true
                            : false,
                        (Theme.of(context).brightness == Brightness.dark)
                            ? ColorRes.black.withOpacity(0.20)
                            : ColorRes.containerColor));
                  }),
            ),
            const SizedBox(height: 20),
            Obx(() => controller.selectIndicator.value == 2
                ? InkWell(
                    onTap: () {
                      if (controller.selectIndicator.value == 0 ||
                          controller.selectIndicator.value == 1) {
                        controller.pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      } else if (controller.selectIndicator.value == 2) {
                        if (kDebugMode) {
                          print("GO TO HOME SCREEN");
                        }
                      }
                    },
                    child: InkWell(
                      onTap: () {
                        String token = PrefService.getString(PrefKeys.userId);
                        String rol = PrefService.getString(PrefKeys.rol);
                        bool company = PrefService.getBool(PrefKeys.company);
                        final DashBoardController controller =
                            Get.put(DashBoardController());
                        controller.currentTab = 0;
                        Get.off(() => token == ""
                            ? DashBoardScreen()
                            : rol == "User"
                                ? DashBoardScreen()
                                : company
                                    ? ManagerDashBoardScreen()
                                    : const OrganizationProfileScreen());
                      },
                      child: Container(
                        height: 50,
                        width: 294,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        margin:
                            const EdgeInsets.only(right: 18, left: 18, top: 10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                          color: ColorRes.blukersOrangeColor,
                          // gradient: LinearGradient(colors: [
                          //   ColorRes.gradientColor,
                          //   ColorRes.containerColor,
                          // ]),
                        ),
                        child: Text(
                          Strings.getStarted,
                          style: appTextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ))
                : const SizedBox())
          ],
        ),
      ),
    );
  }
}

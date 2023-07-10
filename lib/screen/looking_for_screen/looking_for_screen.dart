import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/screen/looking_for_screen/looking_for_widget/looking_for_widget.dart';
import 'package:blukers_client_app/screen/looking_for_screen/looking_for_you_screen_controller.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';

class LookingForScreen extends StatelessWidget {
  const LookingForScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LookingForYouScreenController());
    return Scaffold(
      // appBar: AppBar(
      //   // backgroundColor: mBackgroundColor,
      //   elevation: 0,
      //   centerTitle: true,
      // ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          Container(
            height: Get.height * 0.6,
            width: Get.width,
            padding: EdgeInsets.only(
              left: Get.width * 0.088,
              right: Get.width * 0.144,
              top: Get.height * 0.130,
            ),
            child: Image.asset(AssetRes.lookingForYou),
          ),
          Expanded(
            child: Container(
              width: Get.width,
              height: Get.height * 0.4,
              decoration: const BoxDecoration(
                // color: Color.fromARGB(255, 255, 147, 107),
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   height: Get.height * 0.06,
                  // ),
                  // SizedBox(
                  //     height: Get.height * 0.045,
                  //     width: Get.height * 0.045,
                  //     child: Image.asset(
                  //       AssetRes.userIcon,
                  //       fit: BoxFit.fill,
                  //     )),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Text(
                    Strings.whatAreYouLookingFor,
                    style: appTextStyle(
                      color: const Color.fromRGBO(242, 100, 34, 1),
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.035,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: Get.width * 0.048),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => controller.onChangeWantJobChoice(),
                          child: Obx(
                            () => lookingForYouBox(
                              // AssetRes.wantJob,
                              AssetRes.wantJob2,
                              "iWantJob".tr,
                              controller.isJob.value,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => controller.onChangeEmployeeChoice(),
                          child: Obx(
                            () => lookingForYouBox(
                              // AssetRes.person,
                              AssetRes.person2,
                              "iWantEmployee".tr,
                              controller.isEmployee.value,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

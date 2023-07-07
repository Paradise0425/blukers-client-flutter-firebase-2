import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/common/widgets/common_loader.dart';
import 'package:blukers_client_app/screen/create_vacancies/create_vacancies_controller.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';

class RequirementsScreen extends StatelessWidget {
  RequirementsScreen({Key? key}) : super(key: key);
  final controller = Get.put(CreateVacanciesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.backgroundColor,
      body: SizedBox(
        height: Get.height,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height * 0.073),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: InkWell(
                        onTap: () {
                          controller.onTapBack("require");
                          Get.back();
                        },
                        child: backButton(),
                      ),
                    ),
                    SizedBox(width: Get.width / 10),
                    Text(
                      Strings.addRequirements,
                      style: appTextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          height: 1,
                          color: ColorRes.black),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.034),
                Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: Text(
                    Strings.requirements,
                    style: appTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1,
                      color: ColorRes.black.withOpacity(0.7),
                    ),
                  ),
                ),
                Expanded(
                  child: GetBuilder<CreateVacanciesController>(
                    id: "requirement",
                    builder: (controller) {
                      return ListView.builder(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        physics: const BouncingScrollPhysics(),
                        padding:
                            const EdgeInsets.only(left: 18, right: 18, top: 18),
                        itemCount: controller.addRequirementsList.length + 1,
                        itemBuilder: (context, index) {
                          return index == controller.addRequirementsList.length
                              ? InkWell(
                                  onTap: controller.onTapAddRequirements,
                                  child: Container(
                                    height: 50,
                                    width: 339,
                                    margin: const EdgeInsets.only(
                                        top: 22, bottom: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: ColorRes.containerColor),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Image(
                                          image: AssetImage(AssetRes.addIcon),
                                          height: 15,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          Strings.addNewRequirements,
                                          style: appTextStyle(
                                              color: ColorRes.containerColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.only(right: 10),
                                  margin:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  width: 339,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xffF3F0F8),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 46,
                                        width: 46,
                                        padding: const EdgeInsets.all(10),
                                        child: const Image(
                                          image: AssetImage(AssetRes.checkIcon),
                                          height: 10,
                                          width: 10,
                                        ),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          controller: controller
                                              .addRequirementsList[index],
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            enabled: true,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 70,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () async {
                    controller.loader.value = true;
                    await //Future.delayed(const Duration(microseconds: 50));
                        controller.onUpdateVacancyTapNext(
                            position: controller.positionController.text);
                    controller.loader.value = false;
                  },
                  child: Container(
                    height: 50,
                    width: 339,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [
                          ColorRes.gradientColor,
                          ColorRes.containerColor,
                        ],
                      ),
                    ),
                    child: Text(
                      Strings.postJobVacancy,
                      style: appTextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: ColorRes.white),
                    ),
                  ),
                ),
              ),
            ),
            Obx(() => controller.loader.isTrue
                ? const CommonLoader()
                : const SizedBox()),
          ],
        ),
      ),
    );
  }
}

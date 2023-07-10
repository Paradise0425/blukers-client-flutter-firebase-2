import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/common/widgets/common_error_box.dart';
import 'package:blukers_client_app/common/widgets/common_text_field.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';
import 'create_vacancies_2_controller.dart';

class CreateVacancies2Screen extends StatelessWidget {
  CreateVacancies2Screen({Key? key}) : super(key: key);
  final controller = Get.put(CreateVacancies2Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.backgroundColor,
      body: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: backButton(),
                ),
              ),
              const SizedBox(width: 28),
              Text(
                'Create Vacancies',
                style: appTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 1,
                    color: ColorRes.black),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.all(10),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: ColorRes.logoColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.edit,
                  color: ColorRes.containerColor,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 44,
                width: 164,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: ColorRes.blukersOrangeColor,
                  // gradient: const LinearGradient(colors: [
                  //   ColorRes.gradientColor,
                  //   ColorRes.containerColor
                  // ]),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    'Job Details',
                    style: appTextStyle(
                        color: ColorRes.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Container(
                height: 44,
                width: 164,
                decoration: BoxDecoration(
                  color: ColorRes.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: ColorRes.containerColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    'Requirements',
                    style: appTextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        color: ColorRes.containerColor),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: Get.height - 190,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      const Image(
                        image: AssetImage(AssetRes.airBnbLogo),
                        height: 55,
                      ),
                      Positioned(
                        bottom: 1,
                        left: 44,
                        child: Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorRes.containerColor),
                          child: const Icon(
                            Icons.edit,
                            size: 8,
                            color: ColorRes.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 18),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    color: ColorRes.lightGrey.withOpacity(0.8),
                    height: 1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Obx(
                      () => Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              Text(
                                "Open Position",
                                style: appTextStyle(
                                  color: ColorRes.black.withOpacity(0.6),
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "*",
                                style: appTextStyle(color: ColorRes.starColor),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        commonTextFormField(
                            onChanged: controller.onChanged,
                            textDecoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Open Position",
                                hintStyle: appTextStyle(
                                    fontSize: 14,
                                    color: ColorRes.black.withOpacity(0.15))),
                            controller: controller.positionController),
                        controller.isPositionValidate.value == true
                            ? Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  commonErrorBox("Please Enter Position"),
                                ],
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              "Salary",
                              style: appTextStyle(
                                  color: ColorRes.grey, fontSize: 14),
                            ),
                            Text(
                              "*",
                              style: appTextStyle(color: ColorRes.starColor),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        commonTextFormField(
                            onChanged: controller.onChanged,
                            textDecoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Salary",
                              hintStyle: appTextStyle(
                                  fontSize: 14,
                                  color: ColorRes.black.withOpacity(0.15)),
                              suffixIcon: Container(
                                padding: const EdgeInsets.all(13),
                                child: Image(
                                  image:
                                      const AssetImage(AssetRes.currencyIcon),
                                  height: 5,
                                  color: ColorRes.black.withOpacity(0.15),
                                ),
                              ),
                            ),
                            controller: controller.salaryController),
                        controller.isSalaryValidate.value == true
                            ? Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  commonErrorBox("Please Enter Salary"),
                                ],
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              "Location",
                              style: appTextStyle(
                                  color: ColorRes.grey, fontSize: 14),
                            ),
                            Text(
                              "*",
                              style: appTextStyle(color: ColorRes.starColor),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        commonTextFormField(
                            onChanged: controller.onChanged,
                            textDecoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Location",
                              hintStyle: appTextStyle(
                                  fontSize: 14,
                                  color: ColorRes.black.withOpacity(0.15)),
                              suffixIcon: Container(
                                padding: const EdgeInsets.all(20),
                                child: Image(
                                  image: const AssetImage(AssetRes.dropIcon),
                                  height: 5,
                                  color: ColorRes.black.withOpacity(0.15),
                                ),
                              ),
                            ),
                            controller: controller.locationController),
                        controller.isLocationValidate.value == true
                            ? Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  commonErrorBox("Please Enter Location"),
                                ],
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              "Type",
                              style: appTextStyle(
                                  color: ColorRes.grey, fontSize: 14),
                            ),
                            Text(
                              "*",
                              style: appTextStyle(color: ColorRes.starColor),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        commonTextFormField(
                            onChanged: controller.onChanged,
                            type: TextInputType.number,
                            textDecoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Type",
                              hintStyle: appTextStyle(
                                fontSize: 14,
                                color: ColorRes.black.withOpacity(0.15),
                              ),
                              suffixIcon: Container(
                                padding: const EdgeInsets.all(20),
                                child: Image(
                                  color: ColorRes.black.withOpacity(0.20),
                                  image: const AssetImage(
                                    AssetRes.dropIcon,
                                  ),
                                  height: 5,
                                ),
                              ),
                            ),
                            controller: controller.typeController),
                        controller.isTypeValidate.value == true
                            ? Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  commonErrorBox("Please Enter Type"),
                                ],
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              "Status",
                              style: appTextStyle(
                                  color: ColorRes.grey, fontSize: 14),
                            ),
                            Text(
                              "*",
                              style: appTextStyle(color: ColorRes.starColor),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        commonTextFormField(
                            onChanged: controller.onChanged,
                            textDecoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Status",
                              hintStyle: appTextStyle(
                                fontSize: 14,
                                color: ColorRes.black.withOpacity(0.15),
                              ),
                              suffixIcon: Container(
                                padding: const EdgeInsets.all(20),
                                child: Image(
                                  color: ColorRes.black.withOpacity(0.20),
                                  image: const AssetImage(
                                    AssetRes.dropIcon,
                                  ),
                                  height: 5,
                                ),
                              ),
                            ),
                            controller: controller.statusController),
                        controller.isStatusValidate.value == true
                            ? Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  commonErrorBox("Please Enter Status"),
                                ],
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 70,
                        ),
                        GetBuilder<CreateVacancies2Controller>(
                            id: "profile",
                            builder: (controller) {
                              return InkWell(
                                // dashboard write
                                onTap: () => controller.validate(),
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: ColorRes.blukersOrangeColor,
                                    // gradient: const LinearGradient(colors: [
                                    //   ColorRes.gradientColor,
                                    //   ColorRes.containerColor
                                    // ]),
                                  ),
                                  child: Text(
                                    Strings.updateVacancy,
                                    style: appTextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: ColorRes.white),
                                  ),
                                ),
                              );
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                      ]),
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

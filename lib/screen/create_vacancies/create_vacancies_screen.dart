import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/common_error_box.dart';
import 'package:blukers_client_app/common/widgets/common_text_field.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';
import 'create_vacancies_controller.dart';

class CreateVacanciesScreenM extends StatelessWidget {
  const CreateVacanciesScreenM({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateVacanciesController());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorRes.backgroundColor,
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              children: [
                const SizedBox(height: 50),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: InkWell(
                        onTap: () {
                          controller.onTapBack("vacancies");
                          Get.back();
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: ColorRes.logoColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: ColorRes.containerColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Get.width / 10,
                    ),
                    Text(
                      Strings.createVacancies,
                      style: appTextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          height: 1,
                          color: ColorRes.black),
                    ),
                  ],
                ),
                Obx(() {
                  return SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom > 0
                        ? Get.height * 0.5
                        : Get.height * 0.82,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              (controller.url == "")
                                  ? const Image(
                                      image: AssetImage(AssetRes.airBnbLogo),
                                      height: 100,
                                    )
                                  : Image(
                                      image: NetworkImage(controller.url),
                                      height: 100,
                                    ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            color: ColorRes.lightGrey.withOpacity(0.8),
                            height: 1,
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      Strings.openPosition,
                                      style: appTextStyle(
                                        color: ColorRes.black.withOpacity(0.6),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "*",
                                    style:
                                        appTextStyle(color: ColorRes.starColor),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              commonTextFormField(
                                  onChanged: controller.onChanged,
                                  textDecoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(15),
                                      border: InputBorder.none,
                                      hintText: "Open Position",
                                      hintStyle: appTextStyle(
                                          fontSize: 14,
                                          color: ColorRes.black
                                              .withOpacity(0.15))),
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
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      Strings.salary,
                                      style: appTextStyle(
                                          color: ColorRes.grey, fontSize: 14),
                                    ),
                                  ),
                                  Text(
                                    "*",
                                    style:
                                        appTextStyle(color: ColorRes.starColor),
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
                                    contentPadding: const EdgeInsets.all(15),
                                    border: InputBorder.none,
                                    hintText: "Salary",
                                    hintStyle: appTextStyle(
                                        fontSize: 14,
                                        color:
                                            ColorRes.black.withOpacity(0.15)),
                                    suffixIcon: Container(
                                      padding: const EdgeInsets.all(13),
                                      child: Image(
                                        image: const AssetImage(
                                            AssetRes.currencyIcon),
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
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      Strings.location,
                                      style: appTextStyle(
                                          color: ColorRes.grey, fontSize: 14),
                                    ),
                                  ),
                                  Text(
                                    "*",
                                    style:
                                        appTextStyle(color: ColorRes.starColor),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              commonTextFormField(
                                  readOnly: true,
                                  onChanged: controller.onChanged,
                                  textDecoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(15),
                                    border: InputBorder.none,
                                    hintText: "Location",
                                    hintStyle: appTextStyle(
                                      fontSize: 14,
                                      color: ColorRes.black.withOpacity(0.15),
                                    ),
                                    suffixIcon:
                                        GetBuilder<CreateVacanciesController>(
                                      id: "Location",
                                      builder: (controller) {
                                        return DropdownButton(
                                          //value: controller.dropDownValue,
                                          iconSize: 35.0,
                                          iconEnabledColor:
                                              Colors.grey.shade400,
                                          iconDisabledColor:
                                              Colors.grey.shade400,
                                          underline: Container(),
                                          icon:
                                              const Icon(Icons.arrow_drop_down),
                                          items: controller.items.map(
                                            (val) {
                                              return DropdownMenuItem<String>(
                                                value: val,
                                                child: Text(val),
                                              );
                                            },
                                          ).toList(),
                                          onChanged: (String? val) {
                                            controller.changeDropwon(val: val!);
                                            controller.update(["profile"]);
                                          },
                                        );
                                      },
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
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      Strings.type,
                                      style: appTextStyle(
                                          color: ColorRes.grey, fontSize: 14),
                                    ),
                                  ),
                                  Text(
                                    "*",
                                    style:
                                        appTextStyle(color: ColorRes.starColor),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              commonTextFormField(
                                  readOnly: true,
                                  onChanged: controller.onChanged,
                                  textDecoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(15),
                                    border: InputBorder.none,
                                    hintText: "Type",
                                    hintStyle: appTextStyle(
                                      fontSize: 14,
                                      color: ColorRes.black.withOpacity(0.15),
                                    ),
                                    suffixIcon:
                                        GetBuilder<CreateVacanciesController>(
                                      id: "type",
                                      builder: (controller) {
                                        return DropdownButton(
                                            iconSize: 35.0,
                                            iconEnabledColor:
                                                Colors.grey.shade400,
                                            iconDisabledColor:
                                                Colors.grey.shade400,
                                            underline: Container(),
                                            icon: const Icon(
                                                Icons.arrow_drop_down),
                                            items: controller.items1.map(
                                              (val) {
                                                return DropdownMenuItem<String>(
                                                  value: val,
                                                  child: Text(val),
                                                );
                                              },
                                            ).toList(),
                                            onChanged: (String? val) {
                                              controller.changetype(val: val!);
                                              controller.update(["profile"]);
                                            });
                                      },
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
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      Strings.category,
                                      style: appTextStyle(
                                          color: ColorRes.grey, fontSize: 14),
                                    ),
                                  ),
                                  Text(
                                    "*",
                                    style:
                                        appTextStyle(color: ColorRes.starColor),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              commonTextFormField(
                                  readOnly: true,
                                  onChanged: controller.onChanged,
                                  textDecoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(15),
                                    border: InputBorder.none,
                                    hintText: "category",
                                    hintStyle: appTextStyle(
                                      fontSize: 14,
                                      color: ColorRes.black.withOpacity(0.15),
                                    ),
                                    suffixIcon:
                                        GetBuilder<CreateVacanciesController>(
                                      id: "category",
                                      builder: (controller) {
                                        return DropdownButton(
                                            iconSize: 35.0,
                                            iconEnabledColor:
                                                Colors.grey.shade400,
                                            iconDisabledColor:
                                                Colors.grey.shade400,
                                            underline: Container(),
                                            icon: const Icon(
                                                Icons.arrow_drop_down),
                                            items: controller.itemsCategory.map(
                                              (val) {
                                                return DropdownMenuItem<String>(
                                                  value: val,
                                                  child: Text(val),
                                                );
                                              },
                                            ).toList(),
                                            onChanged: (String? val) {
                                              controller.changeCategory(
                                                  val: val!);
                                              controller.update(["profile"]);
                                            });
                                      },
                                    ),
                                  ),
                                  controller: controller.categoryController),
                              controller.isCategoryValidate.value == true
                                  ? Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        commonErrorBox("Please Enter category"),
                                      ],
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      Strings.status,
                                      style: appTextStyle(
                                          color: ColorRes.grey, fontSize: 14),
                                    ),
                                  ),
                                  Text(
                                    "*",
                                    style:
                                        appTextStyle(color: ColorRes.starColor),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              commonTextFormField(
                                  readOnly: true,
                                  onChanged: controller.onChanged,
                                  textDecoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(15),
                                    border: InputBorder.none,
                                    hintText: "Status",
                                    hintStyle: appTextStyle(
                                      fontSize: 14,
                                      color: ColorRes.black.withOpacity(0.15),
                                    ),
                                    suffixIcon:
                                        GetBuilder<CreateVacanciesController>(
                                      id: "Status",
                                      builder: (controller) {
                                        return DropdownButton(
                                            iconSize: 35.0,
                                            iconEnabledColor:
                                                Colors.grey.shade400,
                                            iconDisabledColor:
                                                Colors.grey.shade400,
                                            underline: Container(),
                                            icon: const Icon(
                                                Icons.arrow_drop_down),
                                            items: controller.itemsStatus.map(
                                              (val) {
                                                return DropdownMenuItem<String>(
                                                  value: val,
                                                  child: Text(val),
                                                );
                                              },
                                            ).toList(),
                                            onChanged: (String? val) {
                                              controller.changeStatus(
                                                  val: val!);
                                              controller.update(["profile"]);
                                            });
                                      },
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
                                height: 60,
                              ),
                              GetBuilder<CreateVacanciesController>(
                                  id: "profile",
                                  builder: (controller) {
                                    return InkWell(
                                      onTap: () => controller.onTapNextBut(
                                          controller.positionController.text),
                                      child: Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: ColorRes.blukersOrangeColor,
                                          // gradient: const LinearGradient(colors: [
                                          //   ColorRes.gradientColor,
                                          //   ColorRes.containerColor
                                          // ]),
                                        ),
                                        child: Text(
                                          Strings.next,
                                          style: appTextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: ColorRes.white),
                                        ),
                                      ),
                                    );
                                  }),
                              const SizedBox(
                                height: 10,
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ));
  }
}

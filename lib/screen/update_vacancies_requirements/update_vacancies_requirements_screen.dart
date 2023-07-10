import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blukers_client_app/common/widgets/common_error_box.dart';
import 'package:blukers_client_app/common/widgets/common_loader.dart';
import 'package:blukers_client_app/common/widgets/common_text_field.dart';
import 'package:blukers_client_app/screen/update_vacancies_requirements/update_vacancies_requirement_controller.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';

class UpdateVacanciesRequirementsScreen extends StatelessWidget {
  const UpdateVacanciesRequirementsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateVacanciesRequirementController());
    return Scaffold(
      backgroundColor: ColorRes.backgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(children: [
              const SizedBox(height: 50),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      padding: const EdgeInsets.only(left: 10),
                      margin: const EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                        color: ColorRes.logoColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: ColorRes.containerColor,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Center(
                      child: Text(
                        Strings.updateVacancies,
                        style: appTextStyle(
                            color: ColorRes.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      controller.editOnTap();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: ColorRes.logoColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.edit,
                          color: ColorRes.containerColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 18,
                  )
                ],
              ),
              const SizedBox(height: 20),
              Obx(() => Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.isJobDetails.value = true;
                              controller.update();
                            },
                            child: Container(
                              height: 44,
                              width: 164,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  // ignore: unrelated_type_equality_checks
                                  color: controller.isJobDetails == true
                                      ? ColorRes.white
                                      : ColorRes.containerColor,
                                ),
                                gradient: LinearGradient(
                                  // ignore: unrelated_type_equality_checks
                                  colors: controller.isJobDetails == true
                                      ? [
                                          ColorRes.gradientColor,
                                          ColorRes.containerColor
                                        ]
                                      : [ColorRes.white, ColorRes.white],
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  'Job Details',
                                  style: appTextStyle(
                                      // ignore: unrelated_type_equality_checks
                                      color: controller.isJobDetails == true
                                          ? ColorRes.white
                                          : ColorRes.containerColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: controller.ontap,
                            child: Container(
                              height: 44,
                              width: 164,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  // ignore: unrelated_type_equality_checks
                                  colors: controller.isJobDetails == true
                                      ? [ColorRes.white, ColorRes.white]
                                      : [
                                          ColorRes.gradientColor,
                                          ColorRes.containerColor
                                        ],
                                ),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  // ignore: unrelated_type_equality_checks
                                  color: controller.isJobDetails == true
                                      ? ColorRes.containerColor
                                      : ColorRes.white,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: Center(
                                  child: Text(
                                    Strings.requirements,
                                    style: appTextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      // ignore: unrelated_type_equality_checks
                                      color: controller.isJobDetails == true
                                          ? ColorRes.containerColor
                                          : ColorRes.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      controller.isJobDetails.value
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: Get.height - 180,
                                child: SingleChildScrollView(
                                  child: Column(children: [
                                    Stack(
                                      children: [
                                        const Image(
                                          image:
                                              AssetImage(AssetRes.airBnbLogo),
                                          height: 70,
                                        ),
                                        Positioned(
                                          bottom: 1,
                                          left: 57,
                                          child: Container(
                                            height: 12,
                                            width: 12,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                color: ColorRes.containerColor),
                                            child: const Icon(
                                              Icons.edit,
                                              size: 7,
                                              color: ColorRes.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 18),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      color:
                                          ColorRes.lightGrey.withOpacity(0.8),
                                      height: 1,
                                    ),
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Text(
                                            Strings.openPosition,
                                            style: appTextStyle(
                                              color: ColorRes.black
                                                  .withOpacity(0.6),
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "*",
                                          style: appTextStyle(
                                              color: ColorRes.starColor),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    commonTextFormField(
                                        textDecoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.all(15),
                                          border: InputBorder.none,
                                          hintText: "ui ux design",
                                          hintStyle: appTextStyle(
                                              fontSize: 14,
                                              color: ColorRes.black),
                                        ),
                                        controller:
                                            controller.positionController),
                                    controller.isPositionValidate.value == true
                                        ? Column(
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              commonErrorBox(
                                                  "pleaseEnterPosition"),
                                            ],
                                          )
                                        : const SizedBox(),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Text(
                                            Strings.salary,
                                            style: appTextStyle(
                                                color: ColorRes.grey,
                                                fontSize: 14),
                                          ),
                                        ),
                                        Text(
                                          "*",
                                          style: appTextStyle(
                                              color: ColorRes.starColor),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    commonTextFormField(
                                        type: TextInputType.number,
                                        textDecoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.all(15),
                                          border: InputBorder.none,
                                          hintText: '15000',
                                          hintStyle: appTextStyle(
                                              fontSize: 14,
                                              color: ColorRes.black),
                                          suffixIcon: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15),
                                            child: Image(
                                              image: const AssetImage(
                                                  AssetRes.currencyIcon),
                                              color: ColorRes.black
                                                  .withOpacity(0.30),
                                            ),
                                          ),
                                        ),
                                        controller:
                                            controller.salaryController),
                                    controller.isSalaryValidate.value == true
                                        ? Column(
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              commonErrorBox(
                                                  "pleaseEnterSalary"),
                                            ],
                                          )
                                        : const SizedBox(),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Text(
                                            Strings.location,
                                            style: appTextStyle(
                                                color: ColorRes.grey,
                                                fontSize: 14),
                                          ),
                                        ),
                                        Text(
                                          "*",
                                          style: appTextStyle(
                                              color: ColorRes.starColor),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    commonTextFormField(
                                        readOnly: true,
                                        textDecoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.all(15),
                                          border: InputBorder.none,
                                          hintText: 'india',
                                          hintStyle: appTextStyle(
                                            fontSize: 14,
                                            color: ColorRes.black,
                                          ),
                                          suffixIcon: GetBuilder<
                                              UpdateVacanciesRequirementController>(
                                            id: "dropdown",
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
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: val,
                                                        child: Text(val),
                                                      );
                                                    },
                                                  ).toList(),
                                                  onChanged: (String? val) {
                                                    controller.changeDropdwon(
                                                        val: val!);
                                                  });
                                            },
                                          ),
                                        ),
                                        controller:
                                            controller.locationController),
                                    controller.isLocationValidate.value == true
                                        ? Column(
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              commonErrorBox(
                                                  "pleaseEnterLocation"),
                                            ],
                                          )
                                        : const SizedBox(),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Text(
                                            Strings.type,
                                            style: appTextStyle(
                                                color: ColorRes.grey,
                                                fontSize: 14),
                                          ),
                                        ),
                                        Text(
                                          "*",
                                          style: appTextStyle(
                                              color: ColorRes.starColor),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    commonTextFormField(
                                        readOnly: true,
                                        textDecoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.all(15),
                                          border: InputBorder.none,
                                          hintText: 'Full time',
                                          hintStyle: appTextStyle(
                                            fontSize: 14,
                                            color: ColorRes.black,
                                          ),
                                          suffixIcon: DropdownButton(
                                            iconSize: 35.0,
                                            iconEnabledColor:
                                                Colors.grey.shade400,
                                            iconDisabledColor:
                                                Colors.grey.shade400,
                                            underline: Container(),
                                            icon: const Icon(
                                                Icons.arrow_drop_down),
                                            items: controller.items.map(
                                              (val) {
                                                return DropdownMenuItem<String>(
                                                  value: val,
                                                  child: Text(val),
                                                );
                                              },
                                            ).toList(),
                                            onChanged: (String? val) =>
                                                controller.changeDropwonType(
                                                    val: val!),
                                          ),
                                        ),
                                        controller: controller.typeController),
                                    controller.isTypeValidate.value == true
                                        ? Column(
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              commonErrorBox("pleaseEnterType"),
                                            ],
                                          )
                                        : const SizedBox(),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Text(
                                            Strings.status,
                                            style: appTextStyle(
                                                color: ColorRes.grey,
                                                fontSize: 14),
                                          ),
                                        ),
                                        Text(
                                          "*",
                                          style: appTextStyle(
                                              color: ColorRes.starColor),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    commonTextFormField(
                                        readOnly: true,
                                        textDecoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.all(15),
                                          border: InputBorder.none,
                                          hintText: 'Active',
                                          hintStyle: appTextStyle(
                                            fontSize: 14,
                                            color: ColorRes.black,
                                          ),
                                          suffixIcon: DropdownButton(
                                            iconSize: 35.0,
                                            iconEnabledColor:
                                                Colors.grey.shade400,
                                            iconDisabledColor:
                                                Colors.grey.shade400,
                                            underline: Container(),
                                            icon: const Icon(
                                                Icons.arrow_drop_down),
                                            items: controller.items2.map(
                                              (val) {
                                                return DropdownMenuItem<String>(
                                                  value: val,
                                                  child: Text(val),
                                                );
                                              },
                                            ).toList(),
                                            onChanged: (String? val) =>
                                                controller.changeDropdwonStatus(
                                                    val: val!),
                                          ),
                                        ),
                                        controller:
                                            controller.statusController),
                                    controller.isStatusValidate.value == true
                                        ? Column(
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              commonErrorBox(
                                                  "pleaseEnterStatus"),
                                            ],
                                          )
                                        : const SizedBox(),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    GetBuilder<
                                            UpdateVacanciesRequirementController>(
                                        id: "Vacancies",
                                        builder: (controller) {
                                          return (controller.positionController.text == '' ||
                                                  controller.salaryController
                                                          .text ==
                                                      '' ||
                                                  controller.locationController
                                                          .text ==
                                                      '' ||
                                                  controller.typeController
                                                          .text ==
                                                      '' ||
                                                  controller.statusController
                                                          .text ==
                                                      '')
                                              ? InkWell(
                                                  // dashboard write
                                                  onTap: controller
                                                      .onUpdateVacancyTap,

                                                  child: Container(
                                                    height: 50,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          ColorRes.gradientColor
                                                              .withOpacity(0.2),
                                                          ColorRes
                                                              .containerColor
                                                              .withOpacity(0.4)
                                                        ],
                                                      ),
                                                    ),
                                                    child: Text(
                                                        Strings.updateVacancies,
                                                        style: appTextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: ColorRes
                                                                .white)),
                                                  ),
                                                )
                                              : GetBuilder<
                                                  UpdateVacanciesRequirementController>(
                                                  id: "editValues",
                                                  builder: (controller) {
                                                    return controller
                                                                .editValues ==
                                                            true
                                                        ? InkWell(
                                                            onTap: controller
                                                                .onUpdateVacancyTap,
                                                            child: Container(
                                                              height: 50,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                gradient:
                                                                    const LinearGradient(
                                                                        colors: [
                                                                      ColorRes
                                                                          .gradientColor,
                                                                      ColorRes
                                                                          .containerColor
                                                                    ]),
                                                              ),
                                                              child: Text(
                                                                  Strings
                                                                      .updateVacancy,
                                                                  style: appTextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: ColorRes
                                                                          .white)),
                                                            ),
                                                          )
                                                        : const SizedBox();
                                                  },
                                                );
                                        }),
                                    const SizedBox(
                                      height: 245,
                                    ),
                                  ]),
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                GetBuilder<
                                    UpdateVacanciesRequirementController>(
                                  id: "more",
                                  builder: (controller) {
                                    return SizedBox(
                                      height: 350,
                                      child: ListView.builder(
                                          padding: const EdgeInsets.all(0),
                                          shrinkWrap: true,
                                          itemCount:
                                              controller.requirmentList.length +
                                                  controller.addRequirementsList
                                                      .length,
                                          itemBuilder: (context, index) {
                                            int values = (controller
                                                        .requirmentList.length +
                                                    controller
                                                        .addRequirementsList
                                                        .length) -
                                                controller
                                                    .requirmentList.length;
                                            if (kDebugMode) {
                                              print(values);
                                            }
                                            return Column(
                                              children: [
                                                /*  detailBox(
                                                controller.requirementList[index]
                                                    .toString(),
                                                true),*/
                                                index >=
                                                        controller
                                                            .requirmentList
                                                            .length
                                                    ? GetBuilder<
                                                        UpdateVacanciesRequirementController>(
                                                        id: "more",
                                                        builder: (controller) {
                                                          return (controller
                                                                      .text
                                                                      .value ==
                                                                  true)
                                                              ? Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          10),
                                                                  child:
                                                                      Container(
                                                                    //padding: EdgeInsets.symmetric( vertical: 10),
                                                                    height: 46,
                                                                    width: 339,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      color: const Color(
                                                                          0xffF3F0F8),
                                                                    ),
                                                                    child:
                                                                        TextField(
                                                                      onChanged:
                                                                          (value) {
                                                                        controller.onchangeValues =
                                                                            value;
                                                                        if (kDebugMode) {
                                                                          print(
                                                                              controller.onchangeValues);
                                                                        }
                                                                      },
                                                                      onSubmitted:
                                                                          (value) {
                                                                        controller
                                                                            .requirmentList
                                                                            .add(value);
                                                                        controller.addRequirementsList =
                                                                            [];
                                                                        controller.moreOption = List.generate(
                                                                            controller
                                                                                .requirmentList.length,
                                                                            (index) =>
                                                                                false);

                                                                        controller
                                                                            .update([
                                                                          "more"
                                                                        ]);
                                                                      },
                                                                      controller: controller
                                                                              .addRequirementsList[
                                                                          values -
                                                                              1],
                                                                      decoration:
                                                                          const InputDecoration(
                                                                        border:
                                                                            InputBorder.none,
                                                                        prefixIcon:
                                                                            Icon(
                                                                          Icons
                                                                              .check_circle_outline,
                                                                          color:
                                                                              ColorRes.containerColor,
                                                                          size:
                                                                              30,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              : const SizedBox();
                                                        },
                                                      )
                                                    : Stack(
                                                        children: [
                                                          /*  Container(
                                              //padding: EdgeInsets.symmetric( vertical: 10),
                                              height: 46,
                                              width: 339,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                color:
                                                const Color(0xffF3F0F8),
                                              ),
                                              child: const TextField(
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  prefixIcon: Icon(
                                                    Icons
                                                        .check_circle_outline,
                                                    color: ColorRes
                                                        .containerColor,
                                                    size: 30,
                                                  ),),
                                              ),
                                            ),*/
                                                          Container(
                                                            // height: 50,
                                                            width: Get.width,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        10),
                                                            margin:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        18,
                                                                    vertical:
                                                                        4),
                                                            decoration:
                                                                BoxDecoration(
                                                              gradient: LinearGradient(
                                                                  colors: [
                                                                    const Color(
                                                                        0xFFF3F0F8),
                                                                    const Color(
                                                                            0xFFF3F0F8)
                                                                        .withOpacity(
                                                                            0.1),
                                                                  ],
                                                                  begin: Alignment
                                                                      .centerLeft,
                                                                  end: Alignment
                                                                      .centerRight),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          13),
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                const Icon(
                                                                  Icons
                                                                      .check_circle_outline,
                                                                  color: ColorRes
                                                                      .containerColor,
                                                                  size: 30,
                                                                ),
                                                                const SizedBox(
                                                                  width: 20,
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      Get.width *
                                                                          0.57,
                                                                  child: Text(
                                                                    controller
                                                                        .requirmentList[
                                                                            index]
                                                                        .toString(),
                                                                    style: appTextStyle(
                                                                        color: ColorRes
                                                                            .black,
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  ),
                                                                ),
                                                                const Spacer(),
                                                                InkWell(
                                                                  onTap: () {
                                                                    controller
                                                                        .onTapMore(
                                                                            index);
                                                                    controller
                                                                        .update([
                                                                      "more"
                                                                    ]);
                                                                  },
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .more_vert,
                                                                    color: ColorRes
                                                                        .black,
                                                                    size: 20,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 8,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          GetBuilder<
                                                              UpdateVacanciesRequirementController>(
                                                            id: "more",
                                                            builder:
                                                                (controller) {
                                                              return controller
                                                                              .moreOption[
                                                                          index] ==
                                                                      true
                                                                  ? Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topRight,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(40.0),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              50,
                                                                          width:
                                                                              116,
                                                                          padding: const EdgeInsets.only(
                                                                              left: 10,
                                                                              right: 10),
                                                                          decoration: const BoxDecoration(
                                                                              color: Colors.white70,
                                                                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15), topLeft: Radius.circular(15))),
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () {
                                                                              controller.deleteNewRequirement(index);
                                                                            },
                                                                            child:
                                                                                Column(children: [
                                                                              const Spacer(),
                                                                              Row(
                                                                                children: [
                                                                                  Image.asset(
                                                                                    AssetRes.del,
                                                                                    height: 19,
                                                                                    width: 19,
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 10,
                                                                                  ),
                                                                                  Text(
                                                                                    "Remove",
                                                                                    style: GoogleFonts.montserrat(fontSize: 12, color: ColorRes.black),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              const Spacer(),
                                                                            ]),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : const SizedBox();
                                                            },
                                                          )
                                                        ],
                                                      ),
                                              ],
                                            );
                                          }),
                                    );
                                  },
                                ),
                                const SizedBox(height: 22),
                                InkWell(
                                  onTap: () {
                                    controller.onTapNewRequirement();
                                    controller.update(["more"]);
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 339,
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
                                          height: 10,
                                        ),
                                        const SizedBox(width: 5),
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
                                ),
                                const SizedBox(height: 60),
                                GetBuilder<
                                    UpdateVacanciesRequirementController>(
                                  id: "update",
                                  builder: (controller) {
                                    return InkWell(
                                      onTap: () {
                                        controller.onTapRequirements(context);
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 339,
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
                                        child: Text(Strings.updateVacancy,
                                            style: appTextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: ColorRes.white)),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                    ],
                  ))
            ]),
            Obx(() => controller.loader.isTrue
                ? const Center(
                    child: CommonLoader(),
                  )
                : const SizedBox())
          ],
        ),
      ),
    );
  }
}

showCustomDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: const Color(0xffEEEBF4),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextFormField(
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              maxLines: 6,
            ),
          ),
        );
      });
}

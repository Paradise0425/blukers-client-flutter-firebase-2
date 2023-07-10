import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/common/widgets/common_error_box.dart';
import 'package:blukers_client_app/common/widgets/common_loader.dart';
import 'package:blukers_client_app/common/widgets/common_text_field.dart';
import 'package:blukers_client_app/screen/create_vacancies/create_vacancies_controller.dart';
import 'package:blukers_client_app/screen/manager_section/Profile/profile_controller.dart';
import 'package:blukers_client_app/screen/manager_section/Settings/settings_screen.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final controller = Get.put(ProfileController());
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;

  CreateVacanciesController getCreate = Get.put(CreateVacanciesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorRes.backgroundColor,
      body: Obx(
        () => Column(
          children: [
            const SizedBox(height: 60),
            Row(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: logo(),
              ),
              const Spacer(),
              Center(
                child: Text(
                  Strings.profile,
                  style: appTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 1,
                    color: ColorRes.blukersOrangeColor,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.all(15),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  // color: ColorRes.logoColor,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: ColorRes.blukersBlueColor,
                    width: 2,
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (con) => SettingScreenM(),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.settings,
                    color: ColorRes.containerColor,
                  ),
                ),
              ),
            ]),
            Expanded(
              child: controller.isLod.isFalse
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                GetBuilder<ProfileController>(
                                    id: "image",
                                    builder: (con) {
                                      return Stack(
                                        children: [
                                          Container(
                                            width: 90,
                                            height: 90,
                                            decoration: BoxDecoration(
                                              color: ColorRes.black,
                                              shape: BoxShape.circle,
                                              image: (getCreate.url == "")
                                                  ? DecorationImage(
                                                      image: const AssetImage(
                                                        AssetRes.roundAirbnb,
                                                      ),
                                                      fit: BoxFit.fill,
                                                      onError:
                                                          (error, starcase) {
                                                        Image.asset(
                                                            AssetRes.userImage);
                                                      })
                                                  : DecorationImage(
                                                      image: NetworkImage(
                                                        getCreate.url,
                                                      ),
                                                      fit: BoxFit.fill),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                const SizedBox(width: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.companyNameController.text,
                                      style: appTextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: ColorRes.black),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      controller.companyEmailController.text,
                                      style: appTextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: ColorRes.black.withOpacity(0.6),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      controller.countryController.text,
                                      style: appTextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: ColorRes.black.withOpacity(0.6),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          Strings.nameOfCompany,
                                          style: appTextStyle(
                                            color:
                                                ColorRes.black.withOpacity(0.6),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "*",
                                        style: appTextStyle(
                                          color: ColorRes.starColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                commonTextFormField(
                                  readOnly: true,
                                  textDecoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(15),
                                      border: InputBorder.none,
                                      hintText: "name of company",
                                      hintStyle: appTextStyle(
                                          fontSize: 14,
                                          color: ColorRes.black
                                              .withOpacity(0.15))),
                                  controller: controller.companyNameController,
                                ),
                                controller.isNameValidate.value == true
                                    ? Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          commonErrorBox(
                                            Strings.pleaseEnterCompanyName,
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        Strings.companyEmail,
                                        style: appTextStyle(
                                            color: ColorRes.grey, fontSize: 14),
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
                                      contentPadding: const EdgeInsets.all(15),
                                      border: InputBorder.none,
                                      hintText: "Company Email",
                                      hintStyle: appTextStyle(
                                        fontSize: 14,
                                        color: ColorRes.black.withOpacity(0.15),
                                      ),
                                      suffixIcon: Container(
                                        padding: const EdgeInsets.all(16),
                                        child: Image(
                                          image: const AssetImage(
                                              AssetRes.emailLogo),
                                          color:
                                              ColorRes.black.withOpacity(0.15),
                                        ),
                                      ),
                                    ),
                                    controller:
                                        controller.companyEmailController),
                                controller.isEmailValidate.value == true
                                    ? Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          commonErrorBox(
                                            Strings.pleaseEnterCompanyEmail,
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        Strings.establishedDate,
                                        style: appTextStyle(
                                            color: ColorRes.grey, fontSize: 14),
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
                                      contentPadding: const EdgeInsets.all(15),
                                      border: InputBorder.none,
                                      hintText: "Date",
                                      hintStyle: appTextStyle(
                                          fontSize: 14,
                                          color:
                                              ColorRes.black.withOpacity(0.15)),
                                      suffixIcon: Container(
                                        padding: const EdgeInsets.all(15),
                                        child: Image(
                                          image: const AssetImage(
                                              AssetRes.dateIcon),
                                          color:
                                              ColorRes.black.withOpacity(0.15),
                                        ),
                                      ),
                                    ),
                                    controller: controller.dateController),
                                controller.isDateController.value == true
                                    ? Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          commonErrorBox(
                                            Strings.pleaseEnterDate,
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        Strings.country,
                                        style: appTextStyle(
                                            color: ColorRes.grey, fontSize: 14),
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
                                      contentPadding: const EdgeInsets.all(15),
                                      border: InputBorder.none,
                                      hintText: "Country",
                                      hintStyle: appTextStyle(
                                        fontSize: 14,
                                        color: ColorRes.black.withOpacity(0.15),
                                      ),
                                      suffixIcon: Container(
                                        padding: const EdgeInsets.all(20),
                                        child: Image(
                                          color:
                                              ColorRes.black.withOpacity(0.20),
                                          image: const AssetImage(
                                            AssetRes.dropIcon,
                                          ),
                                          height: 5,
                                        ),
                                      ),
                                    ),
                                    controller: controller.countryController),
                                controller.isCountryValidate.value == true
                                    ? Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          commonErrorBox(
                                              Strings.pleaseEnterCountry),
                                        ],
                                      )
                                    : const SizedBox(),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        Strings.companyAddress,
                                        style: appTextStyle(
                                            color: ColorRes.grey, fontSize: 14),
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
                                      contentPadding: const EdgeInsets.all(15),
                                      border: InputBorder.none,
                                      hintText: "Address",
                                      hintStyle: appTextStyle(
                                        fontSize: 14,
                                        color: ColorRes.black.withOpacity(0.15),
                                      ),
                                    ),
                                    controller:
                                        controller.companyAddressController),
                                controller.isAddressValidate.value == true
                                    ? Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          commonErrorBox(
                                              Strings.pleaseEnterAddress),
                                        ],
                                      )
                                    : const SizedBox(),
                                const SizedBox(
                                  height: 20,
                                ),
                                GetBuilder<ProfileController>(
                                  id: "Organization",
                                  builder: (controller) {
                                    return InkWell(
                                      // dashboard write
                                      onTap: controller.onTapEdit,
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
                                          Strings.edit,
                                          style: appTextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: ColorRes.white,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : const Center(
                      child: CommonLoader(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

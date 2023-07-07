import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:blukers_client_app/common/widgets/common_error_box.dart';
import 'package:blukers_client_app/common/widgets/common_loader.dart';
import 'package:blukers_client_app/common/widgets/common_text_field.dart';
import 'package:blukers_client_app/screen/looking_for_screen/looking_for_screen.dart';
import 'package:blukers_client_app/screen/organization_profile_screen/organization_profile_screen_controller.dart';
import 'package:blukers_client_app/service/pref_services.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';

class OrganizationProfileScreen extends StatelessWidget {
  const OrganizationProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrganizationProfileScreenController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Row(children: [
              Container(
                margin: const EdgeInsets.all(15),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: ColorRes.logoColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 11),
                  child: Text(
                    textAlign: TextAlign.center,
                    Strings.logo,
                    style: appTextStyle(
                        color: ColorRes.containerColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 10),
                  ),
                ),
              ),
              const Spacer(),
              Text(
                Strings.organizationProfile,
                style: appTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 1,
                    color: ColorRes.black),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.all(15),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: ColorRes.logoColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  onTap: () {
                    settingModalBottomSheet(context);
                  },
                  child: Container(
                    height: 55,
                    width: 55,
                    padding: const EdgeInsets.all(10),
                    child: const Image(
                      image: AssetImage(
                        AssetRes.logout,
                      ),
                      color: ColorRes.starColor,
                    ),
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 18,
            ),
            Container(
              width: Get.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: ColorRes.borderColor,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () => controller.onTapGallery1(),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: ColorRes.logoColor,
                        shape: BoxShape.circle,
                        image: (controller.image == null)
                            ? const DecorationImage(
                                image: AssetImage(
                                  AssetRes.cloud,
                                ),
                              )
                            : DecorationImage(
                                image: FileImage(
                                  controller.image!,
                                ),
                                fit: BoxFit.fill),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    Strings.uploadCompanyLogo,
                    style: appTextStyle(
                        color: ColorRes.black.withOpacity(0.5), fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
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
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          Strings.nameOfCompany,
                          style: appTextStyle(
                            color: ColorRes.black.withOpacity(0.6),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Text(
                        "*",
                        style: appTextStyle(color: ColorRes.starColor),
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
                        hintText: "Name Of Company",
                        hintStyle: appTextStyle(
                            fontSize: 14,
                            color: ColorRes.black.withOpacity(0.15))),
                    controller: controller.companyNameController,
                  ),
                  controller.isNameValidate.value == true
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            commonErrorBox("pleaseEnterCompanyName"),
                          ],
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          Strings.companyEmail,
                          style:
                              appTextStyle(color: ColorRes.grey, fontSize: 14),
                        ),
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
                        contentPadding: const EdgeInsets.all(15),
                        border: InputBorder.none,
                        hintText: "Company Email",
                        hintStyle: appTextStyle(
                            fontSize: 14,
                            color: ColorRes.black.withOpacity(0.15)),
                        suffixIcon: Container(
                            padding: const EdgeInsets.all(15),
                            child: Icon(
                              Icons.email_outlined,
                              color: ColorRes.black.withOpacity(0.10),
                            )),
                      ),
                      controller: controller.companyEmailController),
                  controller.isEmailValidate.value == true
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            commonErrorBox("pleaseEnterCompanyEmail"),
                          ],
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          Strings.establishedDate,
                          style:
                              appTextStyle(color: ColorRes.grey, fontSize: 14),
                        ),
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
                  InkWell(
                    onTap: () {
                      controller.onDatePickerTap(context);
                    },
                    child: commonTextFormField(
                        onChanged: controller.onChanged,
                        onTap: () => controller.onDatePickerTap(context),
                        textDecoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15),
                          border: InputBorder.none,
                          hintText: "Established date",
                          hintStyle: appTextStyle(
                              fontSize: 14,
                              color: ColorRes.black.withOpacity(0.15)),
                          suffixIcon: Container(
                            padding: const EdgeInsets.all(15),
                            child: Image(
                              image: const AssetImage(AssetRes.dateIcon),
                              color: ColorRes.black.withOpacity(0.15),
                            ),
                          ),
                        ),
                        controller: controller.dateController),
                  ),
                  controller.isDateValidate.value == true
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            commonErrorBox("pleaseEnterDate"),
                          ],
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          Strings.country,
                          style:
                              appTextStyle(color: ColorRes.grey, fontSize: 14),
                        ),
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
                        contentPadding: const EdgeInsets.all(15),
                        border: InputBorder.none,
                        hintText: "Country",
                        hintStyle: appTextStyle(
                          fontSize: 14,
                          color: ColorRes.black.withOpacity(0.15),
                        ),
                        suffixIcon:
                            GetBuilder<OrganizationProfileScreenController>(
                          id: "dropdown",
                          builder: (controller) {
                            return DropdownButton(
                                //value: controller.dropDownValue,
                                iconSize: 35.0,
                                iconEnabledColor: Colors.grey.shade400,
                                iconDisabledColor: Colors.grey.shade400,
                                underline: Container(),
                                icon: const Icon(Icons.arrow_drop_down),
                                items: controller.items.map(
                                  (val) {
                                    return DropdownMenuItem<String>(
                                      value: val,
                                      child: Text(val),
                                    );
                                  },
                                ).toList(),
                                onChanged: (String? val) {
                                  controller.changeDropdwon(val: val!);
                                  controller.update(["Organization"]);
                                });
                          },
                        ),
                      ),
                      controller: controller.countryController),
                  controller.isCountryValidate.value == true
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            commonErrorBox("pleaseEnterCountry"),
                          ],
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          Strings.companyAddress,
                          style:
                              appTextStyle(color: ColorRes.grey, fontSize: 14),
                        ),
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
                        contentPadding: const EdgeInsets.all(15),
                        border: InputBorder.none,
                        hintText: "Address",
                        hintStyle: appTextStyle(
                          fontSize: 14,
                          color: ColorRes.black.withOpacity(0.15),
                        ),
                      ),
                      controller: controller.companyAddressController),
                  controller.isAddressValidate.value == true
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            commonErrorBox("pleaseEnterAddress"),
                          ],
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 35,
                  ),
                  GetBuilder<OrganizationProfileScreenController>(
                    id: "Organization",
                    builder: (controller) {
                      return InkWell(
                        // dashboard write
                        onTap: () {
                          if (kDebugMode) {
                            print("a4fyj66enum j");
                          }
                          controller.onConfirmTap();
                        },

                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(colors: [
                              ColorRes.gradientColor,
                              ColorRes.containerColor
                            ]),
                          ),
                          child: controller.conLoader.value
                              ? const CommonLoader()
                              : Text(
                                  Strings.confirm,
                                  style: appTextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: ColorRes.white),
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
      ),
    );
  }

  Future settingModalBottomSheet(context) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return Container(
            height: 265,
            decoration: const BoxDecoration(
              color: ColorRes.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45),
                topRight: Radius.circular(45),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Image(
                  image: AssetImage(AssetRes.logout),
                  color: ColorRes.starColor,
                ),
                const SizedBox(height: 20),
                Text(
                  "Are you sure want to logout?",
                  style: appTextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: ColorRes.black.withOpacity(0.8)),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Container(
                          height: 50,
                          width: 160,
                          decoration: BoxDecoration(
                              color: ColorRes.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border:
                                  Border.all(color: ColorRes.containerColor)),
                          child: Center(
                              child: Text(
                            "Cancel",
                            style: appTextStyle(
                              color: ColorRes.containerColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () async {
                        final GoogleSignIn googleSignIn = GoogleSignIn();
                        if (await googleSignIn.isSignedIn()) {
                          await googleSignIn.signOut();
                        }
                        await FirebaseAuth.instance.signOut();
                        PrefService.clear();
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const LookingForScreen(),
                            ),
                            (route) => false);
                      },
                      child: Container(
                        height: 50,
                        width: 160,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                            ColorRes.gradientColor,
                            ColorRes.containerColor,
                          ]),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Text(
                            "Yes, Logout",
                            style: appTextStyle(
                              color: ColorRes.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}

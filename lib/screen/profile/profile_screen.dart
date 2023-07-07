import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/common/widgets/common_error_box.dart';
import 'package:blukers_client_app/common/widgets/common_text_field.dart';
import 'package:blukers_client_app/screen/profile/edit_profile_user/edit_profile_user_screen.dart';
import 'package:blukers_client_app/screen/profile/profile_controller.dart';
import 'package:blukers_client_app/screen/settings/settings_screen.dart';
import 'package:blukers_client_app/service/pref_services.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/pref_keys.dart';
import 'package:blukers_client_app/utils/string.dart';

class ProfileUserScreenU extends StatelessWidget {
  ProfileUserScreenU({Key? key}) : super(key: key);
  final controller = Get.put(ProfileUserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorRes.backgroundColor,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            const SizedBox(height: 50),
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
                      color: ColorRes.black),
                ),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (con) => const SettingsScreenU(),
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
            const SizedBox(height: 10),
            SizedBox(
              height: Get.height - 210,
              child: SingleChildScrollView(
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            GetBuilder<ProfileUserController>(
                                id: "pic",
                                builder: (context) {
                                  return Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: ColorRes.black,
                                      borderRadius: BorderRadius.circular(50),
                                      image: controller.fbImageUrl.value != ""
                                          ? DecorationImage(
                                              image: NetworkImage(
                                                  controller.fbImageUrl.value),
                                              fit: BoxFit.fill)
                                          : (controller.image != null)
                                              ? DecorationImage(
                                                  image: FileImage(
                                                      controller.image!),
                                                )
                                              : const DecorationImage(
                                                  image: AssetImage(
                                                      AssetRes.userprofileLogo),
                                                ),
                                    ),
                                  );
                                }),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              PrefService.getString(PrefKeys.fullName),
                              style: appTextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: ColorRes.black),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              PrefService.getString(PrefKeys.email),
                              style: appTextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: ColorRes.black.withOpacity(0.6),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              PrefService.getString(PrefKeys.occupation),
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
                    child: Obx(
                      () => Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                Strings.fullName,
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
                          const SizedBox(
                            height: 10,
                          ),
                          commonTextFormField(
                              onChanged: controller.onChanged,
                              readOnly: true,
                              textDecoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(15),
                                border: InputBorder.none,
                                hintText: "  Full Name",
                                hintStyle: appTextStyle(
                                  fontSize: 14,
                                  color: ColorRes.black.withOpacity(0.15),
                                ),
                              ),
                              controller: controller.fullNameController),
                          controller.isNameValidate.value == true
                              ? Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    commonErrorBox(Strings.enterValidName),
                                  ],
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                Strings.email,
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
                              readOnly: true,
                              textDecoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(15),
                                border: InputBorder.none,
                                hintText: "  Email",
                                hintStyle: appTextStyle(
                                    fontSize: 14,
                                    color: ColorRes.black.withOpacity(0.15)),
                                suffixIcon: Icon(
                                  Icons.mail_outline_outlined,
                                  color: ColorRes.black.withOpacity(0.20),
                                ),
                              ),
                              controller: controller.emailController),
                          controller.isEmailValidate.value == true
                              ? Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    commonErrorBox(Strings.enterValidEmail),
                                  ],
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                Strings.dateOfBirth,
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
                          InkWell(
                            onTap: () {
                              //controller.onDatePickerTap(context);
                            },
                            child: commonTextFormField(
                                readOnly: true,
                                onChanged: controller.onChanged,
                                // onTap: () =>
                                //    controller.onDatePickerTap(context),
                                textDecoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(15),
                                  border: InputBorder.none,
                                  hintText: "  Date of birth",
                                  hintStyle: appTextStyle(
                                    fontSize: 14,
                                    color: ColorRes.black.withOpacity(0.15),
                                  ),
                                  suffixIcon: Container(
                                    padding: const EdgeInsets.all(15),
                                    child: Image(
                                      color: ColorRes.black.withOpacity(0.20),
                                      image: const AssetImage(
                                        AssetRes.dateIcon,
                                      ),
                                      height: 20,
                                    ),
                                  ),
                                ),
                                controller: controller.dateOfBirthController),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                Strings.address,
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
                              readOnly: true,
                              onChanged: controller.onChanged,
                              textDecoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.all(15),
                                hintText: "  Address",
                                hintStyle: appTextStyle(
                                  fontSize: 14,
                                  color: ColorRes.black.withOpacity(0.15),
                                ),
                              ),
                              controller: controller.addressController),
                          controller.isAddressValidate.value == true
                              ? Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    commonErrorBox(Strings.enterValidAddress),
                                  ],
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                Strings.occupation,
                                style: appTextStyle(
                                    color: ColorRes.grey, fontSize: 14),
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
                              readOnly: true,
                              onChanged: controller.onChanged,
                              textDecoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.all(15),
                                hintText: "  Occupation",
                                hintStyle: appTextStyle(
                                  fontSize: 14,
                                  color: ColorRes.black.withOpacity(0.15),
                                ),
                              ),
                              controller: controller.occupationController),
                          controller.isOccupationValidate.value == true
                              ? Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    commonErrorBox(
                                        Strings.enterValidOccupation),
                                  ],
                                )
                              : const SizedBox(),
                          const SizedBox(height: 20),
                          const SizedBox(
                            height: 10,
                          ),
                          GetBuilder<ProfileUserController>(
                              id: "Organization",
                              builder: (controller) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(() => EditProfileUser());
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
                                    child: Text(
                                      Strings.edit,
                                      style: appTextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: ColorRes.white),
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

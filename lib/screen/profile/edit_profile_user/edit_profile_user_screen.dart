import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/common/widgets/common_error_box.dart';
import 'package:blukers_client_app/common/widgets/common_text_field.dart';
import 'package:blukers_client_app/screen/profile/profile_controller.dart';
import 'package:blukers_client_app/service/pref_services.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/pref_keys.dart';

class EditProfileUser extends StatelessWidget {
  EditProfileUser({Key? key}) : super(key: key);
  final controller = Get.put(ProfileUserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorRes.backgroundColor,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(children: [
          const SizedBox(height: 50),
          Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: backButton(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Edit Profile',
                    style: appTextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        height: 1,
                        color: ColorRes.black),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: Get.height - 130,
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
                          Positioned(
                            bottom: 0,
                            right: 2,
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet<void>(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: 450,
                                      decoration: const BoxDecoration(
                                        color: ColorRes.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(45),
                                          topRight: Radius.circular(45),
                                        ),
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            const SizedBox(height: 30),
                                            Text(
                                              'Change Avatar',
                                              style: appTextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: ColorRes.black
                                                    .withOpacity(0.8),
                                              ),
                                            ),
                                            // const SizedBox(height: 20),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 18,
                                                      vertical: 18),
                                              child: Container(
                                                height: 120,
                                                width: Get.width,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xffF3ECFF),
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(5),
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () =>
                                                          controller.ontap(),
                                                      child: Container(
                                                        height: 70,
                                                        width: 70,
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 100,
                                                            vertical: 10),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: ColorRes
                                                              .logoColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(80),
                                                        ),
                                                        child: const Icon(
                                                          Icons.camera_alt,
                                                          size: 40,
                                                          color: ColorRes
                                                              .containerColor,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      "Take photo",
                                                      style: appTextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14,
                                                          color:
                                                              ColorRes.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 18),
                                              child: Container(
                                                height: 120,
                                                width: Get.width,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xffF3ECFF),
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(5),
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () => controller
                                                          .ontapGallery(),
                                                      child: Container(
                                                        height: 70,
                                                        width: 70,
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 100,
                                                            vertical: 10),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: ColorRes
                                                              .logoColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(80),
                                                        ),
                                                        child: const Image(
                                                          image: AssetImage(
                                                              AssetRes
                                                                  .galleryImage),
                                                          color: ColorRes
                                                              .containerColor,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      "Form gallery",
                                                      style: appTextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14,
                                                          color:
                                                              ColorRes.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const CircleAvatar(
                                radius: 10,
                                backgroundColor: ColorRes.containerColor,
                                child: Icon(
                                  Icons.edit,
                                  size: 10,
                                  color: ColorRes.white,
                                ),
                              ),
                            ),
                          ),
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
                                color: ColorRes.black.withOpacity(0.6)),
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
                              "Full Name",
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
                                  commonErrorBox("Enter Valid Name"),
                                ],
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "Email",
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
                                  commonErrorBox("Enter Valid Email"),
                                ],
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "Date of birth",
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
                            controller.onDatePickerTap(context);
                          },
                          child: commonTextFormField(
                              onChanged: controller.onChanged,
                              onTap: () => controller.onDatePickerTap(context),
                              textDecoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(15),
                                border: InputBorder.none,
                                hintText: "  Date of birth",
                                hintStyle: appTextStyle(
                                    fontSize: 14,
                                    color: ColorRes.black.withOpacity(0.15)),
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
                              "Address",
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
                                  commonErrorBox("Enter Valid Address"),
                                ],
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "Occupation",
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
                                  commonErrorBox("Enter Valid Occupation"),
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
                                onTap: controller.EditTap,
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
                                  child: Text("Save Changes",
                                      style: appTextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: ColorRes.white)),
                                ),
                              );
                            }),
                        SizedBox(
                            height: MediaQuery.of(context).viewInsets.bottom +
                                50.0),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}

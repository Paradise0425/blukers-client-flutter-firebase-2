import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/common/widgets/common_error_box.dart';
import 'package:blukers_client_app/common/widgets/common_text_field.dart';
import 'package:blukers_client_app/screen/create_vacancies/create_vacancies_controller.dart';
import 'package:blukers_client_app/screen/manager_section/Profile/profile_controller.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  final controller = Get.put(ProfileController());

  CreateVacanciesController getCreate = Get.put(CreateVacanciesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.backgroundColor,
      body: Column(
        children: [
          const SizedBox(height: 60),
          Row(children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: InkWell(
                onTap: () {
                  controller.init();
                  Get.back();
                },
                child: backButton(),
              ),
            ),
            const Spacer(),
            Center(
              child: Text(
                Strings.editProfile,
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
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              /*child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (con) => const SettingScreenM(),
                    ),
                  );
                },
                child: const Icon(
                  Icons.settings,
                  color: ColorRes.containerColor,
                ),
              ),*/
            ),
          ]),
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          GetBuilder<ProfileController>(
                              id: "image",
                              builder: (context) {
                                return Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: (getCreate.url == "")
                                        ? DecorationImage(
                                            image: const AssetImage(
                                              AssetRes.roundAirbnb,
                                            ),
                                            fit: BoxFit.fill,
                                            onError: (error, starcase) {
                                              Image.asset(AssetRes.userImage);
                                            })
                                        : DecorationImage(
                                            image: NetworkImage(
                                              getCreate.url,
                                            ),
                                            fit: BoxFit.fill),
                                  ),
                                );
                              }),
                          Positioned(
                            bottom: 0,
                            right: 10,
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
                                              'Change Logo Company',
                                              style: appTextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: ColorRes.black
                                                      .withOpacity(0.8)),
                                            ),
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
                                                      onTap: () {
                                                        controller.onTapImage();
                                                      },
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
                                                          .onTapGallery1(),
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
                                                      Strings.formGallery,
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
                                  size: 11,
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
                                color: ColorRes.black.withOpacity(0.6)),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            controller.countryController.text,
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
                    () => Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
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
                          textDecoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(15),
                            border: InputBorder.none,
                            hintText: "name of company",
                            hintStyle: appTextStyle(
                              fontSize: 14,
                              color: ColorRes.black.withOpacity(0.15),
                            ),
                          ),
                          controller: controller.companyNameController),
                      controller.isNameValidate.value == true
                          ? Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                commonErrorBox("Please Enter CompanyName"),
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
                            style: appTextStyle(color: ColorRes.starColor),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      commonTextFormField(
                          textDecoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(15),
                            border: InputBorder.none,
                            hintText: "Company Email",
                            hintStyle: appTextStyle(
                                fontSize: 14,
                                color: ColorRes.black.withOpacity(0.15)),
                            suffixIcon: Container(
                              padding: const EdgeInsets.all(16),
                              child: Image(
                                image: const AssetImage(AssetRes.emailLogo),
                                color: ColorRes.black.withOpacity(0.15),
                              ),
                            ),
                          ),
                          readOnly: true,
                          controller: controller.companyEmailController),
                      controller.isEmailValidate.value == true
                          ? Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                commonErrorBox("Please Enter Company Email"),
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
                            onTap: () => controller.onDatePickerTap(context),
                            textDecoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(15),
                              border: InputBorder.none,
                              hintText: "Date",
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
                      controller.isDateController.value == true
                          ? Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                commonErrorBox("Please Enter Date"),
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
                            style: appTextStyle(color: ColorRes.starColor),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      commonTextFormField(
                          textDecoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(15),
                            border: InputBorder.none,
                            hintText: "Country",
                            hintStyle: appTextStyle(
                              fontSize: 14,
                              color: ColorRes.black.withOpacity(0.15),
                            ),
                            suffixIcon: GetBuilder<ProfileController>(
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
                                commonErrorBox("Please Enter Country"),
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
                            style: appTextStyle(color: ColorRes.starColor),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      commonTextFormField(
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
                                commonErrorBox("Please Enter Address"),
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
                              onTap: controller.onTapSubmit,
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
                      const SizedBox(
                        height: 20,
                      ),
                    ]),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

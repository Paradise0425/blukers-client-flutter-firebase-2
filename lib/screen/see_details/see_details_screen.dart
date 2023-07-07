import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/screen/see_details/see_details_controller.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart';

class SeeDetailsScreen extends StatelessWidget {
  const SeeDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var args = Get.arguments;

    final controller = Get.put(SeeDetailsController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorRes.backgroundColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60),
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  Strings.seeDetails,
                  style: appTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: ColorRes.black),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: const DecorationImage(
                        image: AssetImage(AssetRes.detailsImage),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    height: 60,
                    width: Get.width - 152,
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xffE9DDFF),
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      border: Border.all(color: ColorRes.borderColor),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset(
                            AssetRes.seePdf,
                            height: 40,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            if (args['resumeUrl'] != null) {
                              var url = Uri.parse(args['resumeUrl']);

                              if (kDebugMode) {
                                print(url);
                              }
                              // <-- 1
                              var response = await get(url); // <--2
                              var documentDirectory =
                                  await getExternalStorageDirectory();
                              var firstPath =
                                  "${documentDirectory!.path}/images";
                              var filePathAndName =
                                  "${documentDirectory.path}/images/${DateTime.now().millisecondsSinceEpoch}.pdf";

                              await Directory(firstPath)
                                  .create(recursive: true); // <-- 1
                              File file2 = File(filePathAndName); // <-- 2
                              file2.writeAsBytesSync(response.bodyBytes); // <--

                              if (kDebugMode) {
                                print(file2);
                              } //
                            }
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: Get.width * 0.3,
                                child: Text(
                                  controller.filepath
                                      .value /*"Resume - Adam Smith.pdf"*/,
                                  style: appTextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: ColorRes.black),
                                ),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 90,
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 1),
                                      child: Flexible(
                                        child: Text(
                                          "${args['fileName']}",
                                          overflow: TextOverflow.ellipsis,
                                          style: appTextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: ColorRes.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 50),
                                  Container(
                                    height: 16,
                                    width: 16,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: ColorRes.black),
                                    ),
                                    child: const Icon(
                                      Icons.arrow_downward,
                                      size: 10,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "13/06/2022",
                                    style: appTextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w400,
                                      color: ColorRes.black.withOpacity(0.6),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "9:58",
                                    style: appTextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 8,
                                        color: ColorRes.black.withOpacity(0.6)),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    "${args['fileSize'].toStringAsFixed(1)} MB",
                                    style: appTextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 8,
                                      color: ColorRes.black.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom > 0
                    ? Get.height * 0.4
                    : Get.height * 0.65,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          Strings.name,
                          style: appTextStyle(
                            color: ColorRes.black.withOpacity(0.6),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        height: 51,
                        width: 339,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: ColorRes.containerColor),
                        ),
                        child: Text(
                          args['userName'],
                          style: const TextStyle(
                              color: ColorRes.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          Strings.email,
                          style: appTextStyle(
                            color: ColorRes.black.withOpacity(0.6),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        height: 51,
                        width: 339,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: ColorRes.containerColor),
                        ),
                        child: Text(
                          args['email'],
                          style: const TextStyle(
                              color: ColorRes.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                      // commonTextFormField(
                      //   controller: controller.emailController,
                      //   color: ColorRes.containerColor,
                      //   textDecoration: const InputDecoration(
                      //       hintText: 'example@yourdomain.com',
                      //       hintStyle: TextStyle(color: Colors.black),
                      //       contentPadding: EdgeInsets.all(15),
                      //       border: InputBorder.none),
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          Strings.phoneNumber,
                          style: appTextStyle(
                            color: ColorRes.black.withOpacity(0.6),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        height: 51,
                        width: 339,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: ColorRes.containerColor)),
                        child: Text(
                          args['phone'],
                          style: const TextStyle(
                              color: ColorRes.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                      // Container(
                      //   height: 50,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(12),
                      //     border: Border.all(color: ColorRes.containerColor),
                      //   ),
                      //   child: Row(
                      //     children: [
                      //       countryCodePicker(context, padding: 4),
                      //       // SizedBox(
                      //       //   width: Get.width / 2,
                      //       //   child: TextFormField(
                      //       //     // keyboardType: TextInputType.number,
                      //       //     // controller: controller.phoneNumberController,
                      //       //     decoration: InputDecoration(
                      //       //         // hintText: '99135 01269',
                      //       //         fillColor: Colors.transparent,
                      //       //         filled: true,
                      //       //         hintStyle: appTextStyle(
                      //       //             fontSize: 15,
                      //       //             fontWeight: FontWeight.w600,
                      //       //             color: ColorRes.black),
                      //       //         border: InputBorder.none),
                      //       //   ),
                      //       // ),
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          Strings.city,
                          style: appTextStyle(
                            color: ColorRes.black.withOpacity(0.6),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        height: 51,
                        width: 339,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: ColorRes.containerColor),
                        ),
                        child: Text(
                          args['city'],
                          style: const TextStyle(
                              color: ColorRes.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                      // commonTextFormField(
                      //   controller: controller.cityController,
                      //   color: ColorRes.containerColor,
                      //   textDecoration: const InputDecoration(
                      //       hintText: 'Surat',
                      //       hintStyle: TextStyle(color: Colors.black),
                      //       contentPadding: EdgeInsets.all(15),
                      //       border: InputBorder.none),
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          Strings.state,
                          style: appTextStyle(
                            color: ColorRes.black.withOpacity(0.6),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        height: 51,
                        width: 339,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: ColorRes.containerColor),
                        ),
                        child: Text(
                          args['state'],
                          style: const TextStyle(
                              color: ColorRes.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          Strings.country,
                          style: appTextStyle(
                            color: ColorRes.black.withOpacity(0.6),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        height: 51,
                        width: 339,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: ColorRes.containerColor),
                        ),
                        child: Text(
                          args['country'],
                          style: const TextStyle(
                              color: ColorRes.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),

                      const SizedBox(height: 25),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 50,
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              colors: [
                                ColorRes.logoColor,
                                ColorRes.containerColor,
                              ],
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.arrow_back,
                                  color: ColorRes.white,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  Strings.back,
                                  style: appTextStyle(
                                      color: ColorRes.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

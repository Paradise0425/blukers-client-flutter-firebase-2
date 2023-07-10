import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';

class UpdateJobScreen extends StatelessWidget {
  const UpdateJobScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.backgroundColor,
      body: Column(children: [
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
              Strings.updateVacancies,
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
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 44,
              width: 164,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: ColorRes.containerColor),
              ),
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Text(
                  textAlign: TextAlign.center,
                  Strings.jobDetails,
                  style: appTextStyle(
                      color: ColorRes.containerColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (con) => UpdateVacanciesRequirementsScreen()));
              },
              child: Container(
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
                  child: Center(
                    child: Text(
                      Strings.requirements,
                      style: appTextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: ColorRes.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

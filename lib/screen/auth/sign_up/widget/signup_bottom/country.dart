import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/screen/auth/sign_up/sign_up_controller.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';

Widget countryCodePicker(BuildContext context, {double? padding}) {
  SignUpController phoneController = Get.put(SignUpController());
  return InkWell(
    onTap: () => phoneController.onCountryTap(context),
    child: SizedBox(
      height: 20,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(padding ?? 7.0),
            child: Text(phoneController.countryModel.flagEmoji),
          ),
          const SizedBox(width: 5),
          Text(
            "+${phoneController.countryModel.phoneCode}",
            style: const TextStyle(color: ColorRes.black),
          ),
          SizedBox(width: Get.width * 0.02),
          // Icon(Icons.arrow_drop_down_rounded),
          Image.asset(AssetRes.dropDown, height: 4),
          SizedBox(width: Get.width * 0.020),
        ],
      ),
    ),
  );
}

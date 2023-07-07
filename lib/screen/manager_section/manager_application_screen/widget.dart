import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/common_loader.dart';
import 'package:blukers_client_app/screen/job_recommendation_screen/job_recommendation_controller.dart';
import 'package:blukers_client_app/utils/app_res.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';

Widget application(Stream stream) {
  /* final ManagerApplicationScreenController controller =
      ManagerApplicationScreenController();*/
  final jrController = Get.put(JobRecommendationController());

  return StreamBuilder(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        jrController.documents = snapshot.data.docs;

        if (jrController.searchText.value.isNotEmpty) {
          jrController.documents = jrController.documents.where((element) {
            //print(element.get('Position'));
            return element
                .get('Position')
                .toString()
                .toLowerCase()
                .contains(jrController.searchText.value.toLowerCase());
          }).toList();
        }

        return snapshot.hasData
            ? Expanded(
                child: SizedBox(
                  height: Get.height * 0.65,
                  child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: snapshot.data.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => Get.toNamed(
                              AppRes.managerApplicationDetailScreen,
                              arguments: {
                                "docs": snapshot.data!.docs[index],
                                "DocId": index
                              }),
                          child: Container(
                            height: 92,
                            width: Get.width,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 4),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                border:
                                    Border.all(color: const Color(0xffF3ECFF)),
                                color: ColorRes.white),
                            child: Row(
                              children: [
                                Image.asset(AssetRes.airBnbLogo),
                                const SizedBox(width: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data!.docs[index]["Position"],
                                      style: appTextStyle(
                                          color: ColorRes.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                        snapshot.data!.docs[index]
                                            ["CompanyName"],
                                        style: appTextStyle(
                                            color: ColorRes.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400)),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text(
                                          snapshot.data!.docs[index]
                                              ["location"],
                                          style: appTextStyle(
                                              color: ColorRes.black,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(snapshot.data!.docs[index]["type"],
                                            style: appTextStyle(
                                                color: ColorRes.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400)),
                                      ],
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 20,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: snapshot.data!.docs[index]
                                                    ["Status"] ==
                                                "Active"
                                            ? ColorRes.lightGreen
                                            : ColorRes.invalidColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        snapshot.data!.docs[index]["Status"],
                                        style: appTextStyle(
                                            color: snapshot.data!.docs[index]
                                                        ["Status"] ==
                                                    "Active"
                                                ? ColorRes.darkGreen
                                                : ColorRes.starColor,
                                            fontSize: 12),
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      snapshot.data!.docs[index]["salary"],
                                      style: appTextStyle(
                                          fontSize: 16,
                                          color: ColorRes.containerColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10)
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              )
            : const Center(
                child: CommonLoader(),
              );
      });
}

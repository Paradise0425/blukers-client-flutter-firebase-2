import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/string.dart';

class TipsForYouScreen extends StatelessWidget {
  const TipsForYouScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorRes.backgroundColor,
        body: Column(
          children: [
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
                      Strings.tipsForYou,
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
              height: Get.height - 145,
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 18),
                        height: 176,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          gradient: const LinearGradient(colors: [
                            ColorRes.gradientColor,
                            ColorRes.containerColor,
                          ]),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(6, 6),
                                color: ColorRes.containerColor.withOpacity(0.2),
                                spreadRadius: 0,
                                blurRadius: 10),
                            BoxShadow(
                                offset: const Offset(0, 7),
                                color: ColorRes.containerColor.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 20),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 20),
                              width: Get.width - 180,
                              height: 180,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(Strings.howToFindAPerfectJob,
                                      style: appTextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17,
                                          color: ColorRes.white)),
                                  const SizedBox(height: 10),
                                  const Divider(
                                    height: 10,
                                    color: ColorRes.white,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Sarah Bolinas',
                                    style: appTextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: ColorRes.white),
                                  ),
                                  Text(
                                    'Head of Human Capital at Facebook',
                                    style: appTextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w500,
                                        color: ColorRes.white),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Image.asset(AssetRes.girlImage, height: 175),
                            const SizedBox(width: 20)
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(18),
                        child: Text(
                          'How to find a perfect job for you',
                          style: appTextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: ColorRes.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          'Lorem ipsum dolor sit amet,consecrated advising elite,sed do emus temper incididunt ut labore et dolore magna aliqua.Urna id volutpat lacus laoreet non curabitur gravida arcu.Amet nisl purus in mollis nunc sed id.Elementum curabitur vitae nunc sed.A pellentesque sit amet porttitor eget.Ac turpis egestas integer eget aliquet nibh.Nibh praesent tristique magna sit amet purus gravida.Sagittis nisl rhoncus mattis rhoncus urna neque viverra.Volutpat sed cras ornare arcu dui vivamus arcu felis bibendum.',
                          style: appTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: ColorRes.black.withOpacity(0.5)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                        ),
                        child: Text(
                          "Sagittis vitae et leo dais ut diam.Et praetor praetor mass mass.Faucibus et molestie ac feugiat.Ac feugiat sed lectus vestibulum.Sagittis eu volutpat odio facilisis. Venenatis urna cursus eget nunc scelerisque viverra mauris.",
                          style: appTextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: ColorRes.black.withOpacity(0.5)),
                        ),
                      )
                    ]),
              ),
            ),
          ],
        ));
  }
}

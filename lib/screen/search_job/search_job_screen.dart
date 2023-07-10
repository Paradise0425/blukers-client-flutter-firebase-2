import 'package:advanced_search/advanced_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blukers_client_app/common/widgets/back_button.dart';
import 'package:blukers_client_app/screen/search_job/search_job_controller.dart';
import 'package:blukers_client_app/service/pref_services.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/asset_res.dart';
import 'package:blukers_client_app/utils/color_res.dart';
import 'package:blukers_client_app/utils/pref_keys.dart';
import 'package:blukers_client_app/utils/string.dart';

// ignore: must_be_immutable
class SearchJobScreen extends StatelessWidget {
  SearchJobScreen({Key? key}) : super(key: key);
  SearchJobController controller = Get.put(SearchJobController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      Strings.searchJobs,
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
            GetBuilder<SearchJobController>(
                id: "popup",
                builder: (con) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 18.0, left: 18, right: 18, bottom: 8),
                        child: AdvancedSearch(
                          clearSearchEnabled: true,
                          singleItemHeight: 40,
                          hintText: 'Enter designation, companies',
                          hintTextColor: Colors.black.withOpacity(0.5),
                          autoListing: true,
                          unSelectedTextColor: Colors.black.withOpacity(0.5),
                          maxElementsToDisplay: 10,
                          onItemTap: (int index, String value) {
                            controller.skills = value;
                          },
                          searchItems:
                              PrefService.getList(PrefKeys.allDesignation),
                        ),
                      ),
                      (controller.skillError != "")
                          ? Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: SizedBox(
                                child: Text(
                                  controller.skillError,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.red),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 18.0, left: 18, right: 18),
                        child: AdvancedSearch(
                          clearSearchEnabled: true,
                          singleItemHeight: 40,
                          hintText: 'Enter location',
                          hintTextColor: Colors.black.withOpacity(0.5),
                          autoListing: true,
                          maxElementsToDisplay: 10,
                          onItemTap: (int index, String value) {
                            controller.location = value;
                          },
                          searchItems:
                              PrefService.getList(PrefKeys.allCountryData),
                        ),
                      ),
                      (controller.locationError != "")
                          ? Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: SizedBox(
                                child: Text(
                                  controller.locationError,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.red),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  );
                }),
            InkWell(
              onTap: controller.searchJob,
              child: Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 15),
                  height: 36,
                  width: 119,
                  decoration: BoxDecoration(
                    color: ColorRes.containerColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      Strings.searchJobs,
                      style: const TextStyle(
                          color: ColorRes.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              height: 10,
              color: ColorRes.containerColor.withOpacity(0.2),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                Strings.yourMostRecentSearches,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: ColorRes.black,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Container(
                height: 67,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: ColorRes.white,
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        AssetRes.search,
                        height: 15,
                        width: 15,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Supervisor,Gurgaon/Guru...",
                            style: GoogleFonts.montserrat(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: ColorRes.black),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            "2 new",
                            style: GoogleFonts.montserrat(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: ColorRes.containerColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

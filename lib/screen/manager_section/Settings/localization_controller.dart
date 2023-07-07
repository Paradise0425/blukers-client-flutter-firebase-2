import 'package:get/get.dart';
import 'package:blukers_client_app/localization/localization_file.dart';
import 'package:blukers_client_app/screen/manager_section/dashboard/manager_dashboard_screen.dart';
import 'package:blukers_client_app/utils/string.dart';

class LocalizationControllerM extends GetxController implements GetxService {
  RxList<String> language = [
    Strings.english,
    Strings.spanish,
    Strings.hindi,
    Strings.arabic,
  ].obs;
  RxList<RxBool> selectedLanguage =
      [false.obs, true.obs, false.obs, true.obs].obs;

  void onSelectLang(int index) {
    if (index == 0) {
      selectedLanguage.value = [];
      for (int i = 0; i <= language.length; i++) {
        if (i == index) {
          selectedLanguage.add(false.obs);
        } else {
          selectedLanguage.add(true.obs);
        }
      }

      LocalizationService().changeLocale("English");
      Get.offAll(ManagerDashBoardScreen());
    } else if (index == 1) {
      selectedLanguage.value = [];
      for (int i = 0; i <= language.length; i++) {
        if (i == index) {
          selectedLanguage.add(false.obs);
        } else {
          selectedLanguage.add(true.obs);
        }
      }

      LocalizationService().changeLocale("Spanish");
      Get.offAll(ManagerDashBoardScreen());
    } else if (index == 2) {
      selectedLanguage.value = [];
      for (int i = 0; i <= language.length; i++) {
        if (i == index) {
          selectedLanguage.add(false.obs);
        } else {
          selectedLanguage.add(true.obs);
        }
      }

      LocalizationService().changeLocale("hindi");
      Get.offAll(ManagerDashBoardScreen());
    } else if (index == 3) {
      selectedLanguage.value = [];
      for (int i = 0; i <= language.length; i++) {
        if (i == index) {
          selectedLanguage.add(false.obs);
        } else {
          selectedLanguage.add(true.obs);
        }
      }

      LocalizationService().changeLocale("arabic");
      Get.offAll(ManagerDashBoardScreen());
    }
  }
}

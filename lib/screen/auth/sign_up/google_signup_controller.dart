import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/screen/dashboard/dashboard_screen.dart';
import 'package:blukers_client_app/service/pref_services.dart';
import 'package:blukers_client_app/utils/pref_keys.dart';
import 'package:blukers_client_app/utils/string.dart';

class GoogleSignupController extends GetxController {
  final String email;
  final String firstname;
  final String lastname;
  final String uid;
  GoogleSignupController({
    required this.uid,
    required this.email,
    required this.firstname,
    required this.lastname,
  });
  @override
  void onInit() {
    if (kDebugMode) {
      print("********************************");
    }

    emailController.text = email;
    firstnameController.text = firstname;
    lastnameController.text = lastname;
    super.onInit();
  }

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController occupationController = TextEditingController();

  RxBool loading = false.obs;
  String emailError = "";
  String phoneError = "";
  String firstError = "";
  String lastError = "";
  String cityError = "";
  String stateError = "";
  String countryError = "";
  String occupationError = "";
  bool show = true;
  bool rememberMe = false;

  void onRememberMeChange(bool? value) {
    if (value != null) {
      rememberMe = value;
      update(['remember_me']);
    }
  }

  chang() {
    debugPrint("SHOW $show");
    show = !show;
    update(['showPassword']);
  }

  Country countryModel = Country.from(json: {
    "e164_cc": "1",
    "iso2_cc": "CA",
    "e164_sc": 0,
    "geographic": true,
    "level": 2,
    "name": "Canada",
    "example": "2042345678",
    "display_name": "Canada (CA) [+1]",
    "full_example_with_plus_sign": "+12042345678",
    "display_name_no_e164_cc": "Canada (CA)",
    "e164_key": "1-CA-0"
  });

  void countrySelect(context) {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        countryModel = country;
        update(['phone_filed']);
      },
    );
  }

  void onCountryTap(BuildContext context) {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        countryModel = country;
        update(['phone_filed']);
      },
    );
  }

  bool buttonColor = false;

  void onChanged(String value) {
    update(["dark"]);
  }

  static FirebaseFirestore fireStore = FirebaseFirestore.instance;

  emailValidation() {
    if (emailController.text.trim() == "") {
      emailError = 'pleaseEnterEmail'.tr;
    } else {
      if (RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(emailController.text)) {
        emailError = '';
      } else {
        emailError = 'invalidEmail'.tr;
      }
    }
  }

  firstNameValidation() {
    if (firstnameController.text.trim() == "") {
      firstError = "pleaseEnterFirstname".tr;
    } else {
      firstError = "";
    }
  }

  lastNameValidation() {
    if (lastnameController.text.trim() == "") {
      lastError = "pleaseEnterLastname".tr;
    } else {
      lastError = "";
    }
  }

  cityNameValidation() {
    if (cityController.text.trim() == "") {
      cityError = "pleaseEnterCity".tr;
    } else {
      cityError = "";
    }
  }

  stateNameValidation() {
    if (stateController.text.trim() == "") {
      stateError = 'Please enter State';
    } else {
      stateError = "";
    }
  }

  countryNameValidation() {
    if (cityController.text.trim() == "") {
      countryError = 'Please enter Country';
    } else {
      countryError = "";
    }
  }

  occupationNameValidation() {
    if (occupationController.text.trim() == "") {
      occupationError = 'Please enter Country';
    } else {
      occupationError = "";
    }
  }

  phoneValidation() {
    if (phoneController.text.trim() == "") {
      phoneError = 'Please enter phoneNumber';
    } else {
      if (phoneController.text.length == 10) {
        phoneError = "";
      } else {
        phoneError = "Invalid phone number";
      }
      // if (RegExp(r"^\+?0[0-9]{10}$").hasMatch(phoneController.text)) {
      //     phoneError = "";
      // } else {
      //   phoneError = "Invalid PhoneNumber";
      // }
    }
    update(["showPhoneNumber"]);
  }

  bool validator() {
    emailValidation();
    phoneValidation();
    firstNameValidation();
    lastNameValidation();
    cityNameValidation();
    stateNameValidation();
    countryNameValidation();
    occupationNameValidation();
    if (emailError == "" &&
        phoneError == "" &&
        firstError == "" &&
        lastError == "" &&
        cityError == "" &&
        stateError == "" &&
        countryError == "" &&
        occupationError == "") {
      return true;
    } else {
      return false;
    }
  }

  addDataInFirebase(
      {required String userUid, required Map<String, dynamic> map}) async {
    await fireStore
        .collection("Auth")
        .doc("User")
        .collection("register")
        .doc(userUid)
        .set(map)
        .catchError((e) {
      if (kDebugMode) {
        // ignore: prefer_interpolation_to_compose_strings
        print('...error...' + e);
      }
    });
  }

  onSignUpBtnTap() async {
    Map<String, dynamic> map2 = {
      "fullName": "${firstnameController.text} ${lastnameController.text}",
      "Email": emailController.text,
      "Phone": phoneController.text,
      "Occupation": occupationController.text,
      "City": cityController.text,
      "State": stateController.text,
      "Country": countryController.text,
      "deviceTokenU": PrefService.getString(PrefKeys.deviceToken),
    };

    // singUp(emailController.text, passwordController.text);

    if (kDebugMode) {
      print("GO TO HOME PAGE");
    }

    await addDataInFirebase(userUid: uid, map: map2);

    PrefService.setValue(PrefKeys.fullName,
        "${firstnameController.text}                ${lastnameController.text}");
    PrefService.setValue(PrefKeys.email, emailController.text);
    PrefService.setValue(PrefKeys.phoneNumber, phoneController.text);
    PrefService.setValue(PrefKeys.city, cityController.text);
    PrefService.setValue(PrefKeys.state, stateController.text);
    PrefService.setValue(PrefKeys.country, countryController.text);
    PrefService.setValue(PrefKeys.occupation, occupationController.text);
    PrefService.setValue(PrefKeys.userId, uid);
    PrefService.setValue(PrefKeys.rol, "User");
    Get.offAll(() => DashBoardScreen());
    update(["showEmail"]);
    update(["showLastname"]);
    update(["showFirstname"]);
    update(["showPhoneNumber"]);
    update(["loginForm"]);
    update(["showPassword"]);
    update(["showOccupation"]);
    update(["showCity"]);
    update(["showState"]);
    update(["showCountry"]);
    update(['dark']);
  }

  String dropDownValue = 'India';
  var items = [
    Strings.india,
    Strings.unitedStates,
    Strings.unitedKingdom,
    Strings.europe,
    Strings.cuba,
    Strings.havana,
    Strings.cyprus,
    Strings.nicosia,
    Strings.czech,
    Strings.republic,
    Strings.prague,
  ];
  changeDropdwon({required String val}) {
    dropDownValue = val;
    countryController.text = dropDownValue;

    update(["dropdown"]);
  }
}

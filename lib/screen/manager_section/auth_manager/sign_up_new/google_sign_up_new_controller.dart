import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/screen/organization_profile_screen/organization_profile_screen.dart';
import 'package:blukers_client_app/service/pref_services.dart';
import 'package:blukers_client_app/utils/pref_keys.dart';

class GoogleSignUpControllerM extends GetxController {
  final String email;
  final String firstname;
  final String lastname;
  final String uid;
  GoogleSignUpControllerM({
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

  RxBool loading = false.obs;
  String emailError = "";
  String phoneError = "";
  String firstError = "";
  String lastError = "";
  String cityError = "";
  String stateError = "";
  String countryError = "";
  bool show = true;
  bool rememberMe = false;
  void onRememberMeChange(bool? value) {
    if (value != null) {
      rememberMe = value;
      update(['remember_me']);
    }
  }

  void onChanged(String value) {
    update(["dark"]);
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

  static FirebaseFirestore fireStore = FirebaseFirestore.instance;

  emailValidation() {
    if (emailController.text.trim() == "") {
      emailError = 'pleaseEnterEmail';
    } else {
      if (RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(emailController.text)) {
        emailError = '';
      } else {
        emailError = "Invalid email";
      }
    }
  }

  firstNameValidation() {
    if (firstnameController.text.trim() == "") {
      firstError = 'Please Enter Firstname';
    } else {
      firstError = "";
    }
  }

  lastNameValidation() {
    if (lastnameController.text.trim() == "") {
      lastError = 'Please Enter Lastname';
    } else {
      lastError = "";
    }
  }

  cityNameValidation() {
    if (cityController.text.trim() == "") {
      cityError = 'Please Enter city';
    } else {
      cityError = "";
    }
  }

  stateNameValidation() {
    if (stateController.text.trim() == "") {
      stateError = 'Please Enter State';
    } else {
      stateError = "";
    }
  }

  countryNameValidation() {
    if (cityController.text.trim() == "") {
      countryError = 'Please Enter Country';
    } else {
      countryError = "";
    }
  }

  phoneValidation() {
    if (phoneController.text.trim() == "") {
      phoneError = 'Please Enter phoneNumber';
    } else {
      if (phoneController.text.length == 10) {
        phoneError = "";
      } else {
        phoneError = "Invalid Phone Number";
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
    if (emailError == "" &&
        phoneError == "" &&
        firstError == "" &&
        lastError == "" &&
        cityError == "" &&
        stateError == "" &&
        countryError == "") {
      return true;
    } else {
      return false;
    }
  }

  addDataInFirebase(
      {required String userUid, required Map<String, dynamic> map}) async {
    await fireStore
        .collection("Auth")
        .doc("Manager")
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
      "fullName": "${firstnameController.text}    ${lastnameController.text}",
      "Email": emailController.text,
      "Phone": phoneController.text,
      "City": cityController.text,
      "State": stateController.text,
      "Country": countryController.text,
      "TotalPost": 0,
      "deviceTokenM": PrefService.getString(PrefKeys.deviceToken),
    };

    if (kDebugMode) {
      print("GO TO HOME PAGE");
    }
    await addDataInFirebase(userUid: uid, map: map2);
    PrefService.setValue(PrefKeys.userId, uid);
    PrefService.setValue(PrefKeys.rol, "Manager");
    Get.offAll(() => const OrganizationProfileScreen());
    update(["showEmail"]);
    update(["showLastname"]);
    update(["showFirstname"]);
    update(["showPhoneNumber"]);
    update(["loginForm"]);
    update(["showCity"]);
    update(["showState"]);
    update(["showCountry"]);
    update(['dark']);
  }

  String dropDownValue = 'India';
  var items = [
    'India',
    'United States',
    'Europe',
    'china',
    'United Kingdom',
    " Cuba",
    "	Havana",
    "Cyprus",
    "Nicosia",
    "Czech ",
    "Republic",
    "Prague",
  ];
  changeDropdwon({required String val}) {
    dropDownValue = val;
    countryController.text = dropDownValue;

    update(["dropdown"]);
  }
}

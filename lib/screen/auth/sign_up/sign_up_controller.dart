// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:blukers_client_app/screen/auth/sign_up/google_signupscreen.dart';
import 'package:blukers_client_app/screen/dashboard/dashboard_screen.dart';
import 'package:blukers_client_app/service/pref_services.dart';
import 'package:blukers_client_app/utils/pref_keys.dart';
import 'package:blukers_client_app/utils/string.dart';

class SignUpController extends GetxController {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController occupationController = TextEditingController();

  RxBool loading = false.obs;
  String emailError = "";
  String pwdError = "";
  String phoneError = "";
  String firstError = "";
  String lastError = "";
  String cityError = "";
  String stateError = "";
  String countryError = "";
  String occupationError = "";
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;

  changeDropdwon({required String val}) {
    dropDownValue = val;
    countryController.text = dropDownValue;

    update(["dropdown"]);
  }

  String dropDownValue = 'India';
  var items = [
    Strings.india,
    Strings.unitedStates,
    Strings.europe,
    Strings.unitedKingdom,
    Strings.cuba,
    Strings.havana,
    Strings.cyprus,
    Strings.republic,
    Strings.prague,
  ];
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
      stateError = "pleaseEnterState".tr;
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

  occupationNameValidation() {
    if (occupationController.text.trim() == "") {
      occupationError = "pleaseEnterCountry".tr;
    } else {
      occupationError = "";
    }
  }

  phoneValidation() {
    if (phoneController.text.trim() == "") {
      phoneError = "pleaseEnterPhoneNumber".tr;
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

  passwordValidation() {
    if (passwordController.text.trim() == "") {
      pwdError = 'Please Enter Password';
    } else {
      if (passwordController.text.trim().length >= 8) {
        pwdError = '';
      } else {
        pwdError = "At Least 8 Character";
      }
    }
  }

  bool validator() {
    emailValidation();
    passwordValidation();
    phoneValidation();
    firstNameValidation();
    lastNameValidation();
    cityNameValidation();
    stateNameValidation();
    countryNameValidation();
    occupationNameValidation();
    if (emailError == "" &&
        pwdError == "" &&
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

  onSignUpBtnTap() {
    if (validator()) {
      singUp(emailController.text, passwordController.text);

      if (kDebugMode) {
        print("GO TO HOME PAGE");
      }
    }

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

  void onChanged(String value) {
    update(["dark"]);
  }

  singUp(email, password) async {
    try {
      loading.value = true;
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user?.uid != null) {
        PrefService.setValue(
            PrefKeys.userId, userCredential.user?.uid.toString());
        PrefService.setValue(PrefKeys.rol, "User");
        Map<String, dynamic> map2 = {
          "fullName": "${firstnameController.text} ${lastnameController.text}",
          "Email": emailController.text,
          "Phone": phoneController.text,
          "Occupation": occupationController.text,
          "City": cityController.text,
          "State": stateController.text,
          "Country": countryController.text,
          "imageUrl": "",
          "deviceTokenU": PrefService.getString(PrefKeys.deviceToken),
        };
        await PrefService.setValue(
            PrefKeys.email, emailController.text.toString());
        await PrefService.setValue(
            PrefKeys.occupation, occupationController.text.toString());
        await PrefService.setValue(
            PrefKeys.fullName,
            firstnameController.text.toString() +
                lastnameController.text.toString());
        await PrefService.setValue(
            PrefKeys.city, cityController.text.toString());
        await PrefService.setValue(
            PrefKeys.state, stateController.text.toString());
        await PrefService.setValue(
            PrefKeys.country, countryController.text.toString());
        await PrefService.setValue(
            PrefKeys.phoneNumber, phoneController.text.toString());

        addDataInFirebase(userUid: userCredential.user?.uid ?? "", map: map2);
      }

      loading.value = false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (kDebugMode) {
          print('The password provided is too weak.');
        }
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("Error", e.message.toString(),
            colorText: const Color(0xffDA1414));
        loading.value = false;

        if (kDebugMode) {
          print('The account already exists for that email.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      loading.value = false;
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
        .catchError((e) async {
      if (kDebugMode) {
        print('...error...' + e);
      }
    });
    loading.value = false;

    Get.off(() => DashBoardScreen());
    firstnameController.text = "";
    lastnameController.text = "";
    emailController.text = "";
    phoneController.text = "";
    passwordController.text = "";
    cityController.text = "";
    stateController.text = "";
    countryController.text = "";
    occupationController.text = "";

    if (kDebugMode) {
      print("*************************** Success");
    }
  }

  bool show = true;
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

  chang() {
    debugPrint("SHOW $show");
    show = !show;
    update(['showPassword']);
  }

  bool rememberMe = false;

  void onRememberMeChange(bool? value) {
    if (value != null) {
      rememberMe = value;
      update(['remember_me']);
    }
  }

  bool buttonColor = false;

  button() {
    if (emailController.text != '' && passwordController.text != '') {
      buttonColor = true;
      update(['color']);
    } else {
      buttonColor = false;
      update(['color']);
    }
    update();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  void signWithGoogle() async {
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.signOut();
    }
    final GoogleSignInAccount? account = await googleSignIn.signIn();
    if (await googleSignIn.isSignedIn()) {
      loading.value = true;
    }
    final GoogleSignInAuthentication authentication =
        await account!.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      idToken: authentication.idToken,
      accessToken: authentication.accessToken,
    );
    final UserCredential authResult =
        await auth.signInWithCredential(credential);
    final User? user = authResult.user;

    if (kDebugMode) {
      print(user!.email);
    }

    if (kDebugMode) {
      print(user?.uid);
    }

    if (kDebugMode) {
      print(user?.displayName);
    }

    if (user?.uid != null && user?.uid != "") {
      bool isUser = false;
      await fireStore
          .collection("Auth")
          .doc("User")
          .collection("register")
          .get()
          .then((value) async {
        if (value.docs.length.isEqual(0)) {
          loading.value = true;
          isUser = false;
          Get.snackbar(
              "Error", "Please create account,\n your email is not registered",
              colorText: const Color(0xffDA1414));
        } else {
          for (int i = 0; i < value.docs.length; i++) {
            if (kDebugMode) {
              print("${value.docs[i]["Email"]}=||||||++++++++++");
            }

            if (value.docs[i]["Email"] == user!.email &&
                value.docs[i]["Email"] != "") {
              isUser = true;
              Get.snackbar("Error", "This email is already registered",
                  colorText: const Color(0xffDA1414));

              if (kDebugMode) {
                print("$isUser====]]]]]");
              }

              break;
            } else {
              isUser = false;

              if (kDebugMode) {
                print("$isUser====]]]]]");
              }
            }
          }

          if (isUser == false) {
            String firstNm = user!.displayName.toString().split(" ").first;
            String lastNm = user.displayName.toString().split(" ").last;
            Get.to(
              GoogleSignupScreen(
                uid: user.uid.toString(),
                email: user.email.toString(),
                firstName: firstNm,
                lastName: lastNm,
              ),
            );
          } else {
            if (await googleSignIn.isSignedIn()) {
              await googleSignIn.signOut();
            }
            Get.snackbar("Error", "This email is already registered",
                colorText: const Color(0xffDA1414));
            loading.value = false;
          }
          loading.value = false;
        }

        if (kDebugMode) {
          print("${value.isBlank}=|=|=|");
        }

        if (kDebugMode) {
          print("${value.docs.length}=|=|=|");
        }
      });

      // Get.offAll(() => DashBoardScreen());
      loading.value == false;
      // loader false
    } else {
      loading.value == false;
    }
    loading.value == false;
  }

  void faceBookSignIn() async {
    try {
      loading.value = true;
      final LoginResult loginResult = await FacebookAuth.instance
          .login(permissions: ["email", "public_profile"]);

      if (kDebugMode) {
        print(loginResult);
      }

      await FacebookAuth.instance.getUserData().then((userData) {
        if (kDebugMode) {
          print(userData);
        }
      });
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(
        loginResult.accessToken!.token,
      );

      if (kDebugMode) {
        print(facebookAuthCredential);
      }

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);

      if (kDebugMode) {
        print(userCredential);
      }

      if (userCredential.user?.uid != null && userCredential.user?.uid != "") {
        Get.offAll(() => DashBoardScreen());
        loading.value == false;
        // loader false
      } else {
        loading.value == false;
      }

      loading.value = false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      loading.value = false;
    }
  }
}

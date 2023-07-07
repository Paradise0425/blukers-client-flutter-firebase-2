import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:blukers_client_app/screen/dashboard/dashboard_screen.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:blukers_client_app/service/pref_services.dart';
import 'package:blukers_client_app/utils/pref_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreenController extends GetxController {
  RxBool loading = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  bool isUser = false;
  String emailError = "";
  String pwdError = "";
  bool rememberMe = false;

  getRememberEmailDataUser() {
    if (PrefService.getString(PrefKeys.emailRememberUser) != "") {
      emailController.text = PrefService.getString(PrefKeys.emailRememberUser);
      passwordController.text =
          PrefService.getString(PrefKeys.passwordRememberUser);
    }
  }

  void loadUserEmailPassword() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString("email") ?? "";
      var password = prefs.getString("password") ?? "";
      var remeberMe = prefs.getBool("remember_me") ?? false;

      if (kDebugMode) {
        print(remeberMe);
      }

      if (kDebugMode) {
        print(email);
      }

      if (kDebugMode) {
        print(password);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  emailValidation() {
    if (emailController.text.trim() == "") {
      emailError = 'pleaseEnterEmail'.tr;
    } else {
      if (RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(emailController.text)) {
        emailError = '';
      } else {
        emailError = 'invalidEmail';
      }
    }
    update(["showEmail"]);
  }

  passwordValidation() {
    if (passwordController.text.trim() == "") {
      pwdError = 'Please enter Password';
    } else {
      if (passwordController.text.trim().length >= 8) {
        pwdError = '';
      } else {
        pwdError = "At least 8 character";
      }
    }
    update(["showPassword"]);
  }

  void onChanged(String value) {
    update(["colorChange"]);
  }

  bool validator() {
    emailValidation();
    passwordValidation();
    if (emailError == "" && pwdError == "") {
      return true;
    } else {
      return false;
    }
  }

  void signInWithEmailAndPassword(
      {required String email, required String password}) async {
    loading.value = true;
    await fireStore
        .collection("Auth")
        .doc("User")
        .collection("register")
        .get()
        .then((value) async {
      if (value.docs.length.isEqual(0)) {
        loading.value = true;
        Get.snackbar(
            "Error", "Please create account,\n your email is not registered",
            colorText: const Color(0xffDA1414));
      } else {
        for (int i = 0; i < value.docs.length; i++) {
          if (kDebugMode) {
            print("${value.docs[i]["Email"]}=||||||++++++++++");
          }

          if (value.docs[i]["Email"] == email && value.docs[i]["Email"] != "") {
            isUser = true;
            PrefService.setValue(PrefKeys.rol, "User");

            if (kDebugMode) {
              print("$isUser====]]]]]");
            }

            PrefService.setValue(PrefKeys.userId, value.docs[i].id);
            PrefService.setValue(PrefKeys.fullName, value.docs[i]["fullName"]);
            PrefService.setValue(PrefKeys.email, value.docs[i]["Email"]);
            PrefService.setValue(PrefKeys.phoneNumber, value.docs[i]["Phone"]);
            PrefService.setValue(PrefKeys.city, value.docs[i]["City"]);
            PrefService.setValue(PrefKeys.state, value.docs[i]["State"]);
            PrefService.setValue(PrefKeys.country, value.docs[i]["Country"]);
            PrefService.setValue(
                PrefKeys.occupation, value.docs[i]["Occupation"]);

            break;
          } else {
            isUser = false;

            if (kDebugMode) {
              print("$isUser====]]]]]");
            }
          }
        }

        if (isUser == true) {
          try {
            loading.value = true;
            UserCredential credential = await auth.signInWithEmailAndPassword(
                email: email, password: password);

            if (kDebugMode) {
              print(credential);
            }

            if (credential.user!.email.toString() == email) {
              PrefService.setValue(
                  PrefKeys.userId, credential.user!.uid.toString());
              Get.off(() => DashBoardScreen());
              emailController.text = "";
              passwordController.text = "";
            }
          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
              Get.snackbar("Error", "Wrong user",
                  colorText: const Color(0xffDA1414));
              loading.value = false;

              if (kDebugMode) {
                print('No user found for that email.');
              }
            } else if (e.code == 'wrong-password') {
              Get.snackbar("Error", "Wrong password",
                  colorText: const Color(0xffDA1414));
              loading.value = false;

              if (kDebugMode) {
                print('Wrong password provided for that user.');
              }
            }

            if (kDebugMode) {
              print(e.code);
            }
            Get.snackbar("Error", e.code, colorText: const Color(0xffDA1414));
            loading.value = false;
          }
        } else {
          Get.snackbar(
              "Error", "Please create account,\n your email is not registered",
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
  }

  onLoginBtnTap({String? email, String? password}) async {
    if (rememberMe == true) {
      await PrefService.setValue(
          PrefKeys.emailRememberUser, emailController.text);
      await PrefService.setValue(
          PrefKeys.passwordRememberUser, passwordController.text);
    }
    if (validator()) {
      loading.value = true;
      signInWithEmailAndPassword(password: password!, email: email!);
      loading.value = true;

      if (kDebugMode) {
        print("GO TO HOME PAGE");
      }
    }
  }

  bool show = true;

  chang() {
    debugPrint("SHOW $show");
    show = !show;
    update(['showPassword']);
  }

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
      loading.value = true;
      await fireStore
          .collection("Auth")
          .doc("User")
          .collection("register")
          .get()
          .then((value) async {
        if (value.docs.length.isEqual(0)) {
          loading.value = true;
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
              PrefService.setValue(PrefKeys.rol, "User");
              PrefService.setValue(PrefKeys.accessToken, user.uid);
              PrefService.setValue(PrefKeys.fullName, user.displayName);
              PrefService.setValue(PrefKeys.userId, user.uid);

              Get.offAll(() => DashBoardScreen());
              loading.value == false;

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
        }

        if (isUser == false) {
          Get.snackbar(
              "Error", "Please create account,\n your email is not registered",
              colorText: const Color(0xffDA1414));
          if (await googleSignIn.isSignedIn()) {
            await googleSignIn.signOut();
          }
        }
        loading.value = false;

        if (kDebugMode) {
          print("${value.isBlank}=|=|=|");
        }

        if (kDebugMode) {
          print("${value.docs.length}=|=|=|");
        }
      });
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
      //flutterToast(Strings.faceBookSignInSuccess);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      loading.value = false;
    }
  }
}

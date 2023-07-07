import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:blukers_client_app/screen/manager_section/dashboard/manager_dashboard_screen.dart';
import 'package:blukers_client_app/screen/organization_profile_screen/organization_profile_screen.dart';
import 'package:blukers_client_app/service/pref_services.dart';
import 'package:blukers_client_app/utils/pref_keys.dart';

class SignInScreenControllerM extends GetxController {
  RxBool loading = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  bool isManager = false;
  String emailError = "";
  String pwdError = "";
  @override
  // ignore: unnecessary_overrides
  void onInit() {
    super.onInit();
  }

  getRememberEmailDataManger() {
    if (PrefService.getString(PrefKeys.emailRememberManager) != "") {
      emailController.text =
          PrefService.getString(PrefKeys.emailRememberManager);
      passwordController.text =
          PrefService.getString(PrefKeys.passwordRememberManager);
    }
  }

  void signInWithEmailAndPassword(
      {required String email, required String password}) async {
    loading.value = true;

    await fireStore
        .collection("Auth")
        .doc("Manager")
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
            isManager = true;
            PrefService.setValue(PrefKeys.rol, "Manager");
            PrefService.setValue(
                PrefKeys.totalPost, value.docs[i]["TotalPost"]);
            PrefService.setValue(PrefKeys.company, value.docs[i]["company"]);
            PrefService.setValue(PrefKeys.userId, value.docs[i].id);

            await fireStore
                .collection("Auth")
                .doc("Manager")
                .collection("register")
                .doc(value.docs[i].id)
                .collection("company")
                .get()
                .then((value2) {
              for (int j = 0; j < value2.docs.length; j++) {
                PrefService.setValue(
                    PrefKeys.companyName, value2.docs[j]['name']);
              }
            });

            if (kDebugMode) {
              print("$isManager====]]]]]");
            }

            break;
          } else {
            isManager = false;

            if (kDebugMode) {
              print("$isManager====]]]]]");
            }
          }
        }

        if (isManager == true) {
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
              Get.off(() => PrefService.getBool(PrefKeys.company)
                  ? ManagerDashBoardScreen()
                  : const OrganizationProfileScreen());

              emailController.text = "";
              passwordController.text = "";
              update(["loginForm", "showEmail", "pwdError"]);
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

  void onChanged(String value) {
    update(["colorChange"]);
  }

  emailValidation() {
    if (emailController.text.trim() == "") {
      emailError = 'Please enter email';
    } else {
      if (RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(emailController.text)) {
        // return 'Enter  valid Email';
        emailError = '';
      } else {
        emailError = "Invalid email";
      }
    }
  }

  passwordValidation() {
    if (passwordController.text.trim() == "") {
      pwdError = 'Please enter password';
    } else {
      if (passwordController.text.trim().length >= 8) {
        pwdError = '';
      } else {
        pwdError = "At least 8 character";
      }
    }
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

  onLoginBtnTap() async {
    if (rememberMe == true) {
      await PrefService.setValue(
          PrefKeys.emailRememberManager, emailController.text);
      await PrefService.setValue(
          PrefKeys.passwordRememberManager, passwordController.text);
    }
    if (validator()) {
      signInWithEmailAndPassword(
          password: passwordController.text.trim(),
          email: emailController.text.trim());

      if (kDebugMode) {
        print("GO TO HOME PAGE");
      }
    }
    update(["loginForm", "showEmail", "pwdError"]);
  }

  bool show = true;

  chang() {
    debugPrint("SHOW $show");
    show = !show;
    update(['showPassword']);
  }

  bool rememberMe = false;

  Future<void> onRememberMeChange(bool? value) async {
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
          .doc("Manager")
          .collection("register")
          .get()
          .then((value) async {
        // ignore: unnecessary_null_comparison
        if (value == null) {
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
              isManager = false;
              Get.snackbar("Error",
                  "Please create account,\n your email is not registered",
                  colorText: const Color(0xffDA1414));
              if (await googleSignIn.isSignedIn()) {
                await googleSignIn.signOut();
              }
              loading.value = false;

              if (kDebugMode) {
                print("$isManager====]]]]]");
              }
            } else {
              isManager = true;
              PrefService.setValue(PrefKeys.rol, "Manager");
              PrefService.setValue(
                  PrefKeys.totalPost, value.docs[i]["TotalPost"]);
              PrefService.setValue(PrefKeys.company, value.docs[i]["company"]);
              PrefService.setValue(PrefKeys.userId, user.uid);
              Get.off(() => PrefService.getBool(PrefKeys.company)
                  ? ManagerDashBoardScreen()
                  : const OrganizationProfileScreen());

              if (kDebugMode) {
                print("$isManager====]]]]]");
              }

              break;
            }
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

      PrefService.setValue(PrefKeys.userId, user?.uid.toString());

      loading.value == false;
      // loader false
    } else {
      loading.value == false;
    }

    loading.value == false;
    //flutterToast(Strings.googleSignInSuccess);
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
        Get.offAll(() => const OrganizationProfileScreen());
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

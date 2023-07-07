import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:blukers_client_app/screen/manager_section/Profile/edit_profile/edit_profile_screen.dart';
import 'package:blukers_client_app/service/pref_services.dart';
import 'package:blukers_client_app/utils/app_res.dart';
import 'package:blukers_client_app/utils/pref_keys.dart';
import 'package:blukers_client_app/utils/string.dart';

class ProfileController extends GetxController implements GetxService {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyEmailController = TextEditingController();
  TextEditingController companyAddressController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;
  RxBool isNameValidate = false.obs;
  RxBool isEmailValidate = false.obs;
  RxBool isAddressValidate = false.obs;
  RxBool isCountryValidate = false.obs;
  RxBool isDateController = false.obs;
  RxBool isLod = false.obs;
  // RxString fbImageUrlM = "".obs;

  DateTime? startTime;
  ImagePicker picker = ImagePicker();
  File? image;
  String url = '';
  Future<void> onDatePickerTap(context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            primarySwatch: Colors.blue,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      if (kDebugMode) {
        startTime = picked;
      }
      if (kDebugMode) {
        print("START TIME : $startTime");
      }
      dateController.text =
          "${picked.toLocal().month}/${picked.toLocal().day}/${picked.toLocal().year}";
      update();
    }
  }

  init() {
    isLod.value = true;
    final docRef = fireStore
        .collection("Auth")
        .doc("Manager")
        .collection("register")
        .doc(PrefService.getString(PrefKeys.userId))
        .collection("company")
        .doc("details");
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        companyNameController.text = data["name"];
        companyEmailController.text = data["email"];
        companyAddressController.text = data["address"];
        dateController.text = data["date"];
        countryController.text = data["country"];

        image = File(PrefService.getString(PrefKeys.imageManager));
        update();

        imagePicker();
        isLod.value = false;
      },
      onError: (e) {
        Get.snackbar("Error getting document:", "$e",
            colorText: const Color(0xffDA1414));
        if (kDebugMode) {
          print("Error getting document: $e");
        }
      },
    );
  }

  onTapEdit() {
    if (kDebugMode) {
      print("GO TO Edit Profile");
    }
    Get.to(EditProfileScreen());
  }

  changeDropdwon({required String val}) {
    dropDownValue = val;
    countryController.text = dropDownValue;

    update(["dropdown"]);
  }

  onTapSubmit() async {
    validate();
    if (isNameValidate.value == false &&
        isEmailValidate.value == false &&
        isAddressValidate.value == false &&
        isCountryValidate.value == false &&
        isDateController.value == false) {
      String uid = PrefService.getString(PrefKeys.userId);
      Map<String, dynamic> map = {
        "email": companyEmailController.text.trim(),
        "name": companyNameController.text.trim(),
        "date": dateController.text.trim(),
        "country": countryController.text.trim(),
        "address": companyAddressController.text.trim(),
        "imageUrl": url,
      };
      /*    PrefService.setValue(
        PrefKeys.imageManager,
        url,
      );*/
/*
      Map<String, dynamic> map2 = {
        "CompanyName": companyNameController.text.trim().toString()
      };*/
      await fireStore
          .collection("Auth")
          .doc("Manager")
          .collection("register")
          .doc(uid)
          .collection("company")
          .doc("details")
          .update(map);

      await fireStore
          .collection("allPost")
          .where("Id", isEqualTo: uid)
          .get()
          .then((QuerySnapshot snapshot) {
        // ignore: avoid_function_literals_in_foreach_calls
        snapshot.docs.forEach((element) async {
          await fireStore.collection("allPost").doc(element.id).update(
              {"CompanyName": companyNameController.text.trim().toString()});
        });
      });

      if (kDebugMode) {
        print("GO TO HOME PAGE");
      }
      init();
      Get.back();
      // Get.to(ManagerDashBoardScreen());
    }
  }

  validate() {
    if (companyNameController.text.isEmpty) {
      isNameValidate.value = true;
    } else {
      isNameValidate.value = false;
    }
    if (companyEmailController.text.isEmpty ||
        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(companyEmailController.text)) {
      isEmailValidate.value = true;
    } else {
      isEmailValidate.value = false;
    }
    if (companyAddressController.text.isEmpty) {
      isAddressValidate.value = true;
    } else {
      isAddressValidate.value = false;
    }
    if (countryController.text.isEmpty) {
      isCountryValidate.value = true;
    } else {
      isCountryValidate.value = false;
    }
    if (dateController.text.isEmpty) {
      isDateController.value = true;
    } else {
      isDateController.value = false;
    }
  }

  validateAndSubmit() {
    Get.toNamed(AppRes.managerDashboardScreen);
/*    if (companyNameController.text.isEmpty) {
      isNameValidate.value = true;
    } else {
      isNameValidate.value = false;
    }
    if (companyEmailController.text.isEmpty ||
        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(companyEmailController.text)) {
      isEmailValidate.value = true;
    } else {
      isEmailValidate.value = false;
    }
    if (companyAddressController.text.isEmpty) {
      isAddressValidate.value = true;
    } else {
      isAddressValidate.value = false;
    }*/
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
    Strings.nicosia,
    Strings.czech,
    Strings.republic,
    Strings.prague,
  ];
  onTapImage() async {
    XFile? img = await picker.pickImage(source: ImageSource.camera);
    String path = img!.path;
    image = File(path);
    /* await getUrl();
    uploadImage();*/
    Get.back();
    imagePicker();
  }

  /* getUrl() {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("image1" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(image!);

    uploadTask.then((res) async {
      isLod.value = true;
      url = await res.ref.getDownloadURL();
      isLod.value = false;
      if (kDebugMode) {
        print("url $url");
      }
      update();
    });
  }

  Future<String?> uploadImage({File? flow, String? path}) async {
    final firebaseStorage = FirebaseStorage.instance;
    // final imagePicker = ImagePicker();
    // PickedFile? image;
    String? imageUrl;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;
    if (kDebugMode) {
      print(permissionStatus);
    }

    if (permissionStatus.isGranted) {
      if (flow != null) {
        //  File(image.path);
        //Upload to Firebase
        var snapshot =
            firebaseStorage.ref().child(path!).putFile(flow).snapshot;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        // setState(() {
        imageUrl = downloadUrl;
        if (kDebugMode) {
          print(imageUrl);
        }
        return imageUrl;
        // });
      } else {
        if (kDebugMode) {
          print('No Image Path Received');
        }
        return '';
      }
    } else {
      if (kDebugMode) {
        print('Permission not granted. Try Again with permission access');
      }
      return '';
    }
  }*/

  onTapGallery1() async {
    XFile? gallery = await picker.pickImage(source: ImageSource.gallery);
    String path = gallery!.path;
    image = File(path);
    /* await getUrl();
    await uploadImage();*/
    Get.back();
    imagePicker();
  }

  imagePicker() {
    update(['gallery']);
    update(['onTap']);
    update(['image']);
    update();
  }

  void onChanged(String value) {
    update(["colorChange"]);
  }
}

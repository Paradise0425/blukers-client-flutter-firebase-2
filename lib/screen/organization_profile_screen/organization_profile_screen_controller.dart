import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:blukers_client_app/screen/manager_section/dashboard/manager_dashboard_screen.dart';
import 'package:blukers_client_app/service/pref_services.dart';
import 'package:blukers_client_app/utils/pref_keys.dart';
import 'package:permission_handler/permission_handler.dart';

class OrganizationProfileScreenController extends GetxController
    implements GetxService {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyEmailController = TextEditingController();
  TextEditingController companyAddressController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  RxBool isNameValidate = false.obs;
  RxBool isEmailValidate = false.obs;
  RxBool isAddressValidate = false.obs;
  RxBool isCountryValidate = false.obs;
  RxBool isDateValidate = false.obs;
  RxBool isPositionValidate = false.obs;
  RxBool isSalaryValidate = false.obs;
  RxBool isLocationValidate = false.obs;
  RxBool isTypeValidate = false.obs;
  RxBool isStatusValidate = false.obs;
  RxBool isLod = false.obs;
  RxString fbImageUrlM = "".obs;
  DateTime? startTime;
  ImagePicker picker = ImagePicker();
  File? image;
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;

  @override
  /*void onInit() {
    // TODO: implement onInit
    // getFbImgUrlM();
    super.onInit();
  }*/
  /*getFbImgUrlM() async {
    fbImageUrlM.value = await PrefService.getString(PrefKeys.imageIdM);
    if (kDebugMode) {
      print("fbIMGURL  $fbImageUrlM");
    }
  }*/

  // ignore: override_on_non_overriding_member
  void onChanged(String value) {
    update(["colorChange"]);
    update(["Organization"]);
  }

  RxBool conLoader = false.obs;
  onConfirmTap() async {
    conLoader.value = true;
    String uid = PrefService.getString(PrefKeys.userId);
    Map<String, dynamic> map = {
      "email": companyEmailController.text.trim(),
      "name": companyNameController.text.trim(),
      "date": dateController.text.trim(),
      "country": countryController.text.trim(),
      "address": companyAddressController.text.trim(),
      "imageUrl": url,
      "deviceToken": PrefService.getString(PrefKeys.deviceToken),
    };
    PrefService.setValue(
      PrefKeys.imageManager,
      url,
    );
    validate();
    if (isNameValidate.value == false &&
        isEmailValidate.value == false &&
        isAddressValidate.value == false &&
        isCountryValidate.value == false &&
        isDateValidate.value == false) {
      await fireStore
          .collection("Auth")
          .doc("Manager")
          .collection("register")
          .doc(uid)
          .update({
        "company": true,
      });
      PrefService.setValue(PrefKeys.company, true);
      await fireStore
          .collection("Auth")
          .doc("Manager")
          .collection("register")
          .doc(uid)
          .collection("company")
          .doc("details")
          .set(map)
          .then((value) {
        PrefService.setValue(
            PrefKeys.companyName, companyNameController.text.toString());
        Get.off(ManagerDashBoardScreen());
        conLoader.value = false;
      });
    }
    PrefService.setValue(
        PrefKeys.companyName, companyNameController.text.toString());
  }

  String url = "";
  getUrl() {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("image1${DateTime.now()}");
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

  addImg({required String img}) async {
    final storage = FirebaseStorage.instance;

    // if (imagePath != null) {
    //   var snapshot =
    //       await storage.ref().child('images/imageName').putFile(imagePath!);
    //   var downloadUrl = await snapshot.ref.getDownloadURL();
    //   await FirebaseFirestore.instance
    //       .collection("User")
    //       .doc("profile")
    //       .collection("Profile")
    //       .doc("profilePic")
    //       .set({"url": downloadUrl, "name": "ProfilePic"});
    // } else {
    //   print("no path received");
    // }

    String imageName =
        img.substring(img.lastIndexOf("/") + 1, img.lastIndexOf("."));

    String path = img.substring(img.indexOf("/") + 1, img.lastIndexOf("/"));

    final Directory systemTempDir = Directory.systemTemp;
    final byteData = await rootBundle.load(img);
    final file = File('${systemTempDir.path}/$imageName.jpg');

    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    TaskSnapshot taskSnapshot =
        await storage.ref('$path/$imageName').putFile(file);
    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    await FirebaseFirestore.instance
        .collection(path)
        .add({"url": downloadUrl, "name": imageName});
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
      isDateValidate.value = true;
    } else {
      isDateValidate.value = false;
    }
  }

  Future<void> onDatePickerTap(context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      firstDate: DateTime(1900),
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
      startTime = picked;
      if (kDebugMode) {
        print("START TIME : $startTime");
      }
      dateController.text =
          "${picked.toLocal().month}/${picked.toLocal().day}/${picked.toLocal().year}";
      update();
    }
  }

  changeDropdwon({required String val}) {
    dropDownValue = val;
    countryController.text = dropDownValue;

    update(["dropdown"]);
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

  onTapGallery1() async {
    //filepath.value = file.name.toString();
    XFile? gallery = await picker.pickImage(source: ImageSource.gallery);
    String path = gallery!.path;
    image = File(path);
    getUrl();
    uploadImage();
    imagePicker();
  }

  imagePicker() {
    update(['image']);
    update();
  }
}

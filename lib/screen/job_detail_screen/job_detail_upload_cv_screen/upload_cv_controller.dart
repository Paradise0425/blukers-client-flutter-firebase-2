import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/service/pref_services.dart';
import 'package:blukers_client_app/utils/app_res.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:blukers_client_app/utils/pref_keys.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
List<Map<String, dynamic>> companyList = [];
bool abc = false;

class JobDetailsUploadCvController extends GetxController {
  RefreshController refreshController = RefreshController();

  init() async {
    companyList = [];

    await firestore.collection("Apply").get().then((value) {
      // ignore: avoid_function_literals_in_foreach_calls
      value.docs.forEach((element) {
        if (element['uid'] == PrefService.getString(PrefKeys.userId)) {
          for (int y = 0; y < element['companyName'].length; y++) {
            companyList.add({
              "companyName": element['companyName'][y]["companyname"],
              "position": element['companyName'][y]["position"]
            });
          }
        }
      });
    });
    if (kDebugMode) {
      print(companyList);
    }
    refreshController.refreshCompleted();
    update(["searchChat"]);
  }

  String? pdfUrl;
  double filesize = 0;

  onTapApply({var args}) {
    abc = false;
    for (int i = 0; i < companyList.length; i++) {
      if (companyList[i]['companyame'] == args['CompanyName'] &&
          companyList[i]['position'] == args['Position']) {
        abc = true;
      }
    }

    if (!abc) {
      companyList.add(
          {"companyname": args['CompanyName'], "position": args['Position']});
    }

    List<Map<String, dynamic>> companyNameList =
        List.generate(companyList.length, (index) {
      return companyList[index];
    });

    if (kDebugMode) {
      print(companyNameList.runtimeType);
    }

    firestore
        .collection("Apply")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'apply': true,
      'companyName': companyNameList,
      'userName': PrefService.getString(PrefKeys.fullName),
      'email': PrefService.getString(PrefKeys.email),
      'phone': PrefService.getString(PrefKeys.phoneNumber),
      'city': PrefService.getString(PrefKeys.city),
      'state': PrefService.getString(PrefKeys.state),
      'country': PrefService.getString(PrefKeys.country),
      'Occupation': PrefService.getString(PrefKeys.occupation),
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'resumeUrl': pdfUrl,
      'fileName': filepath.value,
      'fileSize': filesize,
      'salary': args['salary'],
      'location': args['location'],
      'type': args['type'],
      "deviceToken": PrefService.getString(PrefKeys.deviceToken),
    });

    Get.toNamed(AppRes.jobDetailSuccessOrFailed, arguments: [
      {"doc": args},
      {"error": false, "filename": filepath},
    ]);

    filepath.value = "";
  }

  RxString filepath = "".obs;
  RxInt? fileSize;
  RxBool isPdfUploadError = false.obs;
  bool uploadingMedia = false;

  applyResume() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: [
        'pdf',
        /* 'xlsx',
        'xlsm',
        'xls',
        'ppt',
        'pptx',
        'doc',
        'docx',
        'txt',
        'text',
        'rtf',
        'zip',*/
      ],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      // List<PlatformFile> fileList = result.files;

      debugPrint("FILES : $file");
      filepath.value = file.name.toString();
      final kb = file.size / 1024;
      final kbVal = kb.ceil().toInt();
      final mb = kb / 1024;
      fileSize?.value = kbVal;
      filesize = mb;

      if (kDebugMode) {
        print(filesize);
      }

      debugPrint("filepath $filepath FileSize ${fileSize?.value}  $kbVal");
      {
        PlatformFile file = result.files.first;
        // List<PlatformFile> fileList = result.files;

        debugPrint("FILES : $file");
        filepath.value = file.name.toString();
        fileSize?.value = file.size.ceil().toInt();
        isPdfUploadError.value = false;

        debugPrint("filepath $filepath FileSize $fileSize");
      }

      final File fileForFirebase = File(file.path!);

      uploadImage(file: fileForFirebase, path: "files/${file.name}");
    } else {
      // User canceled the picker

      isPdfUploadError.value = true;
    }
  }

  Future<String?> uploadImage({
    File? file,
    String? path,
  }) async {
    final firebaseStorage = FirebaseStorage.instance;

    if (file != null) {
      firebaseStorage.ref().child(path!).putFile(file).snapshot;

      //pdfUrl = file.path;

      // PDF url :

      dynamic storageRef =
          FirebaseStorage.instance.ref().child(path).getDownloadURL();
      storageRef.then((result) {
        pdfUrl = result;

        if (kDebugMode) {
          print("result is $result");
        }
      });
    } else {
      if (kDebugMode) {
        print('No Image Path Received');
      }

      return '';
    }
    return null;
  }
}

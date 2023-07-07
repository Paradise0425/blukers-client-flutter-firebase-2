import 'package:country_picker/country_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SeeDetailsController extends GetxController implements GetxService {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  RxString filepath = "".obs;
  RxInt? fileSize;
  RxBool isPdfUploadError = false.obs;
  bool uploadingMedia = false;

  applyResume1() async {
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
      //final mb = kb / 1024;
      fileSize?.value = kbVal;

      debugPrint("filepath $filepath FileSize ${fileSize?.value}  $kbVal");
      {
        PlatformFile file = result.files.first;
        // List<PlatformFile> fileList = result.files;

        debugPrint("FILES : $file");
        filepath.value = file.name.toString();
        fileSize?.value = file.size;
        isPdfUploadError.value = false;

        debugPrint("filepath $filepath FileSize $fileSize");

        /*      fileList.forEach((file) async {
          if (file.size > 67108864) {
            // showErrorToast("canNotUpload".tr);
            if (file == fileList.last) {
              uploadingMedia = false;
              // notifyListeners();
            }
          } else {
            debugPrint("FILES : "+fileList.toString());
            // String? imageUrl = await storageService.uploadDocument(
            //     File(file.path!), roomId!);
            //
            // await getUploadPath(file.name, "document").then((filePath) async {
            //   await File(filePath!).create(recursive: true);
            //   await File(filePath)
            //       .writeAsBytes(await File(file.path!).readAsBytes())
            //       .then((value) {
            //     if (file == fileList.last) {
            //       uploadingMedia = false;
            //       notifyListeners();
            //     }
            //   });
            //   return filePath;
            // }
            //
            // );
          }
        });*/

      }
      /*      fileList.forEach((file) async {
          if (file.size > 67108864) {
            // showErrorToast("canNotUpload".tr);
            if (file == fileList.last) {
              uploadingMedia = false;
              // notifyListeners();
            }
          } else {
            debugPrint("FILES : "+fileList.toString());
            // String? imageUrl = await storageService.uploadDocument(
            //     File(file.path!), roomId!);
            //
            // await getUploadPath(file.name, "document").then((filePath) async {
            //   await File(filePath!).create(recursive: true);
            //   await File(filePath)
            //       .writeAsBytes(await File(file.path!).readAsBytes())
            //       .then((value) {
            //     if (file == fileList.last) {
            //       uploadingMedia = false;
            //       notifyListeners();
            //     }
            //   });
            //   return filePath;
            // }
            //
            // );
          }
        });*/

    } else {
      // User canceled the picker

      isPdfUploadError.value = true;
    }
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
}

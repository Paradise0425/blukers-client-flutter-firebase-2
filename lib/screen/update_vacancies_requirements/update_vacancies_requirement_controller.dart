import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/screen/manager_section/dashboard/manager_dashboard_screen.dart';

class UpdateVacanciesRequirementController extends GetxController {
  final args = Get.arguments;

  List requirments = [];
  RxBool isJobDetails = true.obs;

  ontap() {
    isJobDetails.value = false;
    update();
  }

  bool editValues = false;
  List<bool> moreOption = [];

  void onTapMore(int index) {
    if (moreOption[index] == false) {
      moreOption[index] = true;
    } else {
      moreOption[index] = false;
    }
    update(['more']);
  }

  editOnTap() {
    if (editValues == false) {
      editValues = true;
    } else {
      editValues = false;
    }
    update(["editValues"]);
  }

  RxBool text = false.obs;
  RxBool add = true.obs;
  String? onchangeValues;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initState(args);
  }

  TextEditingController positionController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController requirementController = TextEditingController();
  List requirmentList = [];
  List<TextEditingController> addRequirementsList = [];

  RxBool isPositionValidate = false.obs;
  RxBool isSalaryValidate = false.obs;
  RxBool isLocationValidate = false.obs;
  RxBool isTypeValidate = false.obs;
  RxBool isStatusValidate = false.obs;

  onUpdateVacancyTap() async {
    validate();
    if (isPositionValidate.value == false &&
        isSalaryValidate.value == false &&
        isLocationValidate.value == false &&
        isTypeValidate.value == false &&
        isStatusValidate.value == false) {
      if (kDebugMode) {
        print("GO TO HOME PAGE");
      }

      Map<String, dynamic> map = {
        "Position": positionController.text.trim(),
        "salary": salaryController.text.trim(),
        "location": locationController.text.trim(),
        "type": typeController.text.trim(),
        "Status": statusController.text.trim(),
        "BookMarkUserList": [],
      };

      FirebaseFirestore.instance
          .collection("allPost")
          .doc(args['docs'].id.toString())
          .update(map);

      Get.back();
    }
  }

  onTapNewRequirement() {
    if (addRequirementsList.isEmpty) {
      addRequirementsList.add(TextEditingController());
    } else if (addRequirementsList.isNotEmpty) {
      Get.snackbar("Error", "Please Fill Up Filed", colorText: Colors.red);
    }
    text.value = true;
    update(["more"]);
    update();
  }

  initState(dynamic data) async {
    positionController.text = data['docs']["Position"];
    salaryController.text = data['docs']["salary"];
    locationController.text = data['docs']["location"];
    typeController.text = data['docs']["type"];
    statusController.text = data['docs']["Status"];
    requirmentList = data['docs']['RequirementsList'];
    DocumentSnapshot document = await FirebaseFirestore.instance
        .collection("allPost")
        .doc(args['docs'].id.toString())
        .get();
    var ref = document.data();
    if (kDebugMode) {
      print(ref);
    }
    moreOption = List.filled(data['docs']['RequirementsList'].length, false);
    update(["more"]);
  }

  deleteNewRequirement(int index) async {
    requirmentList.removeAt(index);
    Map<String, dynamic> map = {
      "RequirementsList": requirmentList,
    };

    FirebaseFirestore.instance
        .collection("allPost")
        .doc(args['docs'].id.toString())
        .update(map);
    update(["more"]);
  }

  RxBool loader = false.obs;

  onTapRequirements(BuildContext context) async {
    loader.value = true;

    /* List<String> requirementsList1 = List.generate(
        addRequirementsList.length, (index) => addRequirementsList[index].text);
    print(requirementsList1);
    requirementList=requirementsList1;
    print(requirementList);*/
    if (kDebugMode) {
      print(onchangeValues);
    }
    // Map<String, dynamic> map = {
    //   "RequirementsList": requirmentList,
    // };

    await FirebaseFirestore.instance
        .collection("allPost")
        .doc(args['docs'].id.toString())
        .update({"RequirementsList": requirmentList});
    update(["update"]);
    loader.value = false;
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return ManagerDashBoardScreen();
      },
    ));
  }

  validate() {
    if (positionController.text.isEmpty) {
      isPositionValidate.value = true;
    } else {
      isPositionValidate.value = false;
    }
    if (salaryController.text.isEmpty) {
      isSalaryValidate.value = true;
    } else {
      isSalaryValidate.value = false;
    }
    if (locationController.text.isEmpty) {
      isLocationValidate.value = true;
    } else {
      isLocationValidate.value = false;
    }

    if (typeController.text.isEmpty) {
      isTypeValidate.value = true;
    } else {
      isTypeValidate.value = false;
    }
    if (statusController.text.isEmpty) {
      isStatusValidate.value = true;
    } else {
      isStatusValidate.value = false;
    }
  }

  RxString dropDownValueLocation = "".obs;

  changeDropdwon({required String val}) {
    dropDownValue = val;
    locationController.text = dropDownValue;

    update(["dropdown"]);
  }

  String dropDownValue = 'India';
  var items1 = [
    "india".tr,
    "unitedStates".tr,
    "europe".tr,
    "unitedKingdom".tr,
    "cuba".tr,
    "havana".tr,
    "cyprus".tr,
    "nicosia".tr,
    "czech".tr,
    "republic".tr,
    "prague".tr,
  ];

  changeDropwonType({required String val}) {
    dropDownValueType = val;
    typeController.text = dropDownValueType;

    update(["dropdown"]);
  }

  String dropDownValueType = "partTime".tr;

  var items = [
    "partTime".tr,
    "freelancer".tr,
    "remote".tr,
    "fullTime".tr,
  ];

  changeDropdwonStatus({required String val}) {
    dropDownValueStatus = val;
    statusController.text = dropDownValueStatus;

    update(["dropdown"]);
  }

  String dropDownValueStatus = 'Active';
  var items2 = [
    "active".tr,
    "inactive".tr,
  ];
}

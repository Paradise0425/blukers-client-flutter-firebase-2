import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class UpdateJobController extends GetxController implements GetxService {
  TextEditingController positionController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  RxBool isPositionValidate = false.obs;
  RxBool isSalaryValidate = false.obs;
  RxBool isLocationValidate = false.obs;
  RxBool isTypeValidate = false.obs;
  RxBool isStatusValidate = false.obs;
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
    if (dropDownValueLocation.value.isEmpty ||
        dropDownValueLocation.value == "") {
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

  onChangeLocation(String val) {
    dropDownValueLocation.value = val;
  }

  var items = [
    'India',
    'United States',
    'Europe',
    'china',
    'United Kingdom',
  ];
  String? dropDownValueType;

  var items1 = [
    'Part Time',
    'Full Time',
  ];
  String? dropDownValueStatus;
  var items2 = [
    'Active'
        'Inactive'
  ];
}

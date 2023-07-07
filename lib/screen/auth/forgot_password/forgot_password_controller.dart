import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ForgotPasswordController extends GetxController {

  bool isSelected = false;
 bool isselectedemail = false;
  mobileUpdate() {
    debugPrint("isselected $isSelected");
    if   (isselectedemail ==true){
      isselectedemail = false;
    }
    isSelected = !isSelected;
    update(['SMS']);
  }

  emailUpdate() {
    debugPrint("isselectedemail $isselectedemail");
    if   (isSelected ==true){
      isSelected = false;
    }
    isselectedemail = !isselectedemail;
    update(['SMS']);
  }
}

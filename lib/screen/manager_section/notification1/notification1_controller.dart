import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class Notification1Controller extends GetxController implements GetxService {
  RxInt selectedJobs = 0.obs;
  onTapJobs(int index) {
    selectedJobs.value = index;
    //update(["hList"]);
  }

}

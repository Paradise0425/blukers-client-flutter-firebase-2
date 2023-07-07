import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ApplicantsDetailsController extends GetxController
    implements GetxService {
  List list = ["accepted".tr, "rejected".tr, "scheduleInterview".tr, "sent".tr];
  String? selectedValue;
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime? selectedDate = DateTime.now();
  String? showTime;
  String? showDate;
  String? status;
  String? massage;
  var inputFormat = DateFormat('dd/MM/yyyy');
  TextEditingController msgController = TextEditingController();

  onChangeStatus(String value) {
    selectedValue = value;
    update(['drop']);
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate!,
        firstDate: DateTime.now(),
        lastDate: DateTime(2025));
    if (picked != null) {
      selectedDate = picked;
      showDate = getFormatDate(picked);

      update(['drop']);
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now()

            //selectedTime,
            );
    if (picked != null) {
      String selTime = '${picked.hour}:${picked.minute}:00';
      //  initialTime: const TimeOfDay(hour: 10, minute: 47);

      showTime = DateFormat.jm().format(DateFormat("hh:mm:ss").parse(selTime));
      selectedTime = picked;

      update(['drop']);
    }
  }

  getFormatDate(date) {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(date.toString());
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(inputDate);
  }

  /*List<Map<String, dynamic>> statusList = [];
  bool abc = false;*/

  /*onTapOk({var args}) {
    abc = false;
    for (int i = 0; i < statusList.length; i++) {
      if (statusList[i]['status'] == args['status'] &&
          statusList[i]['position'] == args['Position']) {
        abc = true;
      }
    }

    if (!abc) {
      statusList.add({"status": args['status'], "position": args['Position']});
    }

    List<Map<String, dynamic>> companyNameList =
        List.generate(statusList.length, (index) {
      return statusList[index];
    });

    if (kDebugMode) {
      print(companyNameList.runtimeType);
    }
  }*/
}

import 'package:get/get.dart';

class AddRequirementController extends GetxController implements GetxService {
  RxBool read = false.obs;
  RxBool text = false.obs;
  RxBool loader = false.obs;
  RxList requirements = [
    "Experienced in Figma or Sketch.",
    "Able to work in large or small team.",
    "At least 1 year of working experience in agency freelance, or start-up.",
    "Able to keep up with the latest trends.",
    "Have relevant experience for at least 3 years."
  ].obs;
}

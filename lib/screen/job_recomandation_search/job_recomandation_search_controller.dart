import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class JobRecomandationSearchController extends GetxController{

  String totalLength='';

  totalJobs()async{
  var data =await   FirebaseFirestore.instance.collection("allPost").get();
  totalLength = data.docs.length.toString();
  update(['length']);
  }
}
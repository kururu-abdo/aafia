import 'dart:developer';

import 'package:aafia/data/models/base/api_helper.dart';
import 'package:aafia/data/models/response/blood_transfer_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class BloodDataController extends GetxController {


ApiHelper helper =ApiHelper();
var  isLoading=false;

List<BloodTransferResponse > reciverRequests=  <BloodTransferResponse >[];
List<BloodTransferResponse > dontationRequests=  <BloodTransferResponse >[];


init(){
    
  }
getDontationRequests()async{
  try {
    var result=await    helper.getAllBloodTransferRequest();

    if (result.data.length>0) {
       List<BloodTransferResponse>  requests =  result.data as List<BloodTransferResponse> ;
      return  requests.where((element) => element.transfareType=='volunteer').toList();
    } else {
      return [];
    }

  } catch (e) {
  }
}

getBloodRequests()async{
  try {
    var result=await    helper.getAllBloodTransferRequest();

    if (result.data.length>0) {
       List<BloodTransferResponse>  requests =  result.data as List<BloodTransferResponse> ;
      return  requests.where((element) => element.transfareType=='receiver').toList();
    } else {
      return [];
    }

  } catch (e) {
  }
}
getRequests()async{
  isLoading=true;
  update();
try {
  helper.getAllBloodTransferRequest()
  .then((result) {
if (result!=null) {
if (result.data!=null) {
  
if (result.data.length>0) {
  List<BloodTransferResponse>  requests =  result.data as List<BloodTransferResponse> ;

  reciverRequests.clear();
reciverRequests.addAll(
  requests.where((element) => element.transfareType=='receiver')
);
dontationRequests.clear();
dontationRequests.addAll(
  requests.where((element) => element.transfareType=='volunteer')
);
update();

}


} else {

  isLoading=false;
  update();
}}
else{
  isLoading=false;
  update();
  Get.snackbar('Error', result.message,backgroundColor: Colors.red);
}
  isLoading=false;
  update();

  });
} catch (e) {
  log(e.toString());

  Get.showSnackbar(GetSnackBar(
    backgroundColor: Colors.red,
  
message:e.toString()
  ));
}
}










}
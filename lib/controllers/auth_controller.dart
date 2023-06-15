import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:aafia/data/models/base/api_helper.dart';
import 'package:aafia/data/models/response/current_user.dart';
import 'package:aafia/pages/home.dart';
import 'package:aafia/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:aafia/utils/global.dart' as global;
import 'package:place_picker/place_picker.dart';

// var authController= Get.put(AuthController());
class AuthController extends GetxController {

ApiHelper helper =ApiHelper();
var  isForgetPasswordLoading=false.obs;

TextEditingController  newPasswordController =TextEditingController();
TextEditingController  confirmPasswordController =TextEditingController();
var  formKey =GlobalKey<FormState>();

TextEditingController  locationController =TextEditingController();
TextEditingController  birthDate =TextEditingController();
TextEditingController  imagePathController =TextEditingController();

var isLoading=false;

var isNewPasswordVisible=false.obs;
var isConfirmPasswordVisible=false.obs;
TextEditingController  nameController =TextEditingController();
double? lat;
double?  lng;
List<String> _bloodTypes =[
  
'O-' ,'O+' ,'B+' ,'A+' ,'A-' ,'AB-' ,'AB+'
];
File? pSelectedImage;
updateImage(File? image){
  pSelectedImage=image;
  update();
}
initUserData()async{
nameController.text=global.currentUser!.name!;
birthDate.text=global.currentUser!.birthdate!;
bloodType=global.currentUser!.bloodtype!;
lat=double.parse(global.currentUser!.latitude.toString());
lng=double.parse(global.currentUser!.longitude.toString());
// locationController.text='${lat},${lng}';
List<Placemark> placemarks = await placemarkFromCoordinates(lat!, lng!);
        
        
                        locationController.text =  "${placemarks.first.country} ,  ${placemarks.first.locality}  ,   ${placemarks.first.name}";


imagePathController.text=global.currentUser!.image??'';
log('IMAGE  '+ global.currentUser!.image.toString());
update();
}

String? bloodType;
updateBlood(blood){
bloodType=blood;
update();
}
updateLatLng(lat ,lng){
  this.lat=lat;
  this.lng=lng;
  update();
}
var   otp=''.obs;
forgotPassword()async{

  
}


updateUserDeviceToken(String uid ,  String token)async{
  try {
    await helper.updateFirebaseToken(uid, token);
  } catch (e) {
  }
}
updateUserData()async{
  try {
    isLoading=true;
    update();
var result= await helper.updateUserData(global.currentUser!.id.toString(), nameController.text.trim(), 
bloodType,
pSelectedImage!=null?

 pSelectedImage!.path.trim():null, birthDate.text.trim(),
  LatLng(lat!, lng!)
  
  );
log(nameController.text);
  if (result.data!=null) {
       CurrentUser _currentUser = new CurrentUser();
               CurrentUser user = result.data;


                      try {

              //  global.currentUser=  user;
               user.token= global.currentUser!.token;
               log(user.toJson().toString());
               update();
    global.sp!.setString(
                  'currentUser', json.encode(user.toJson()));

                  global.sp!.setString(global.token, user.token!);

                  global.currentUser =user;
                  userValue.value =  global.currentUser!;
       } catch (e) {
         log(e.toString());
       }

       Get.snackbar(
         ''
         , 'Data updated successfully' ,backgroundColor: Colors.green);
                              //  ToastUtils.showCustomToast(context, "Your account verified");

  } else {
      Get.snackbar(
         ''
         , result.message.toString() ,backgroundColor: Colors.red);
  }
 isLoading=false;
    update();
   
  } catch (e) {
     isLoading=false;
    update();
    print(e); 
      Get.snackbar(
         ''
         , e.toString() ,backgroundColor: Colors.red);
  }
}
updateUserToken()async{
  try {
     
  } catch (e) {
    print(e); 
  }
}


changePassword()async{
  
}







}
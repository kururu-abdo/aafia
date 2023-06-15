
import 'package:aafia/businessLogic/dio_result.dart';
import 'package:aafia/data/models/response/blood_transfer_response.dart';
import 'package:aafia/data/models/response/blood_transfre_request.dart';
import 'package:aafia/data/models/response/configModel.dart';
import 'package:aafia/data/models/response/current_user.dart';
import 'package:aafia/data/models/response/driver_model.dart';
import 'package:aafia/data/models/response/drug_request_reply.dart';
import 'package:aafia/data/models/response/drug_request_reply_response.dart';
import 'package:aafia/data/models/response/drug_response.dart';
import 'package:aafia/data/models/response/hospital_model.dart';
import 'package:aafia/data/models/response/new_drug_request.dart';
import 'package:aafia/data/models/response/new_user.dart';
import 'package:aafia/pages/login_page.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;
import 'package:http/http.dart' as http;
import 'package:place_picker/place_picker.dart';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import '../../../utils/global.dart' as global;
class ApiHelper {
  

  String? url;


  Future<dynamic> login(String userPhone, String? password) async {
    try {
      Response response;
      var dio = Dio(BaseOptions(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
      var formData =
          FormData.fromMap({'phone': userPhone, "password": password});
      response = await dio.post('${global.url}login',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;

      if (response.statusCode == 200 || response.statusCode == 201 || 
      response.statusCode == 202
      // &&
      //     response.data['status'].toString() == '1'
          
          ) {
        recordList =
        
        CurrentUser.fromJson(response.data);
             log(response.data.toString());

      } else {
 log(response.statusCode.toString());
        recordList = null;
      }

      // return recordList;

   return   getDioResult(response, recordList);
    }  on DioError catch(e){
    return   DioResult.withError(getErrorMessage(e) ,data: null);
    }
    catch (e) {
      log(e.toString());
      print("Exception - login(): " + e.toString());
   return      DioResult.withError(e.toString() , data: null);

    }
  }


Future<dynamic> signUp(NewUser user) async {
    try {
      Response response;
      var dio = Dio(BaseOptions(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));

      var formData = FormData.fromMap({
        'name': user.name,
        // 'user_email': 'A@xzuzzc.com',
        'phone': user.phone,
        'email':user.email,
        'password': user.password,
        'worklocation': user.worklocation,
        'password_confirm': user.password,
        'address': user.address,
        'gender': user.gender,
        'bloodtype':user.bloodtype,
        'birthdate':user.birthdate,
        'usertype':user.usertype,

        'image': user.image != null
            ? await MultipartFile.fromFile(user.image!.toString())
            : null,
        // 'referral_code': user.referralCode != null ? user.referralCode : null,
        // 'apple_id': user.appleId != null ? user.appleId : null,
        'latitude': user.latitude,
        'longitude': user.longitude
      });
      print('-----------------SIGN UP---------------');
      response = await dio.post('${global.url}singup',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(false),
          ));
      log(response.data.toString());
      dynamic recordList;
      if (response.statusCode == 200  || response.statusCode == 201  ) {
        log('HEERE');
        recordList = CurrentUser.fromJson(response.data);
      } else {
        log('////ERROR HERE SIGN USER');
        recordList =  null;
        
        // .toString();
        
        
      }
      return getDioResult(response, recordList);
    }  on DioError catch(e){ return      DioResult.withError(e.toString() , data: null);
  DioResult.withError(getErrorMessage(e));
    }
    catch (e) {
      log(e.toString());
      print("Exception - login(): " + e.toString());
      return      DioResult.withError(e.toString() , data: null);

    }
  }


  Future<dynamic> verifyOTP(String userPhone, String? otp) async {

    log(userPhone.toString());
    try {
      Response response;
      var dio = Dio(BaseOptions(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
      var formData =
          FormData.fromMap({'phone': int.parse(userPhone),
           "otp": otp});
// log(formData.fields.first.value.runtimeType.toString());
      response = await dio.post('${global.url}verify-otp',
          data: {'phone': int.parse(userPhone),
           "otp": otp},
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic recordList;

      log(response.data.toString());
      if (response.statusCode == 202
      ||response.statusCode == 200
      // &&
      //     response.data['status'].toString() == '1'
          
          ) {
        recordList =
        
        response.data;
        log("sdfjjfds");
      } else {
        recordList = null;
      }

      return 

      getDioResult(response, recordList);
    }  on DioError catch(e){
      return      DioResult.withError(e.toString() , data: null);

    }
    catch (e) {
      log(e.toString());
      print("Exception - login(): " + e.toString());
     return      DioResult.withError(e.toString() , data: null);

    }
  }



  Future<dynamic> resendOtp(String userPhone) async {
    try {
      Response response;
      var dio = Dio(BaseOptions(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
      var formData =
          FormData.fromMap({'phone': userPhone,
     });

     //{'phone': int.parse(userPhone.trim()),},
      response = await dio.post('${global.url}resend-otp',
          data: {'phone': int.parse(userPhone.trim()),},
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;

      // log(response.data.toString());
      if (response.statusCode == 200 || response.statusCode==201
      
      // &&
      //     response.data['status'].toString() == '1'
          
          ) {
        recordList =
        
        response.data;
        log("sdfjjfds");
      } else {
        recordList = null;
      }

      return 
      getDioResult(response, recordList);
    }  on DioError catch(e){
      return      DioResult.withError(e.toString() , data: null);

    }
    catch (e) {
      log(e.toString());
      print("Exception - login(): " + e.toString());
     return      DioResult.withError(e.toString() , data: null);

    }
  }

  Future<dynamic> logout(String userPhone) async {
    try {
      Response response;
      var dio = Dio(BaseOptions(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
   
      response = await dio.post('${global.url}logout',
          // data: formData,
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;

      log(response.data.toString());
      if (response.statusCode == 200 
      
      // &&
      //     response.data['status'].toString() == '1'
          
          ) {
        recordList =
        
        response.data;
        log("sdfjjfds");
      } else {
        recordList = null;
      }

      return recordList;

      getDioResult(response, recordList);
    } on DioError catch(e){
    return      DioResult.withError(e.toString() , data: null);

    }
    catch (e) {
      log(e.toString());
      print("Exception - login(): " + e.toString());
     return      DioResult.withError(e.toString() , data: null);

    }
  }





  Future<dynamic> resetPassword(String userId ,
  
  String otp , 
  String password ,
  String passwordConfirm
  ) async {
    try {
      Response response;
      var dio = Dio(BaseOptions(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
      var formData =
          FormData.fromMap({
            
            'user_id': userId,
            'otp':otp ,
            'password':password,
            'password_confirm':passwordConfirm
     });
      response = await dio.put('${global.url}reset-password',
          data: {
            
            'user_id': userId,
            'otp':otp ,
            'password':password,
            'password_confirm':passwordConfirm
     },
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;

      log(response.data.toString());
      if (response.statusCode == 200 
      
      // &&
      //     response.data['status'].toString() == '1'
          
          ) {
        recordList =
        
        response.data;
        log("sdfjjfds");
      } 
      else if(response.statusCode==403||  response.statusCode==401){

       g. Get.offAll(()=>AuthPage());
      }
      
      
      
      
      else {
        recordList = null;
      }

      return 

      getDioResult(response, recordList);
    }  on DioError catch(e){
      return      DioResult.withError(e.toString() , data: null);

    }
    catch (e) {
      log(e.toString());
      print("Exception - login(): " + e.toString());
    return      DioResult.withError(e.toString() , data: null);

    }
  }

Future<dynamic> updtePassword(
  String oldPassword , 
  String password ,
  String passwordConfirm
  ) async {
    try {
      Response response;
      var dio = Dio(BaseOptions(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
      var formData =
          FormData.fromMap({
            
            'old_password': oldPassword.trim(),
            'new_password':password.trim(),
            'new_password_confirm':passwordConfirm.trim()
     });
      response = await dio.put('${global.url}user/update-password',
          data: {
            
            'old_password': oldPassword.trim(),
            'new_password':password.trim(),
            'new_password_confirm':passwordConfirm.trim()
     },
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic recordList;

      log(response.data.toString());
      if (response.statusCode == 200 
      
      // &&
      //     response.data['status'].toString() == '1'
          
          ) {
        recordList =
        
        response.data;
   
      } else if(response.statusCode==403||  response.statusCode==401){

       g. Get.offAll(()=>AuthPage());
      }
       else {
             log("Emptry");
        recordList = null;
      }

      return 

      getDioResult(response, recordList);
    }  on DioError catch(e){
       return      DioResult.withError(e.toString() , data: null);

    }
    catch (e) {
      log(e.toString());
      print("Exception - login(): " + e.toString());
   return      DioResult.withError(e.toString() , data: null);

    }
  }

Future<dynamic> updteUserDeviceToken(
String userId , String dviceToken
  ) async {
    try {
      Response response;
      var dio = Dio(BaseOptions(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
      var formData =
    //       FormData.fromMap({
            
    //         'old_password': oldPassword.trim(),
    //         'new_password':password.trim(),
    //         'new_password_confirm':passwordConfirm.trim()
    //  });
      response = await dio.put('${global.url}user/${userId}/token',
          data: {
            
            'device_token': dviceToken.trim(),
          
     },
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic recordList;
   log('MY UID'+   userId);
      log("MY TKEN:"+  response.data.toString());
      if (response.statusCode == 200  ||response.statusCode == 201
      
      // &&
      //     response.data['status'].toString() == '1'
          
          ) {
        recordList =
        
        response.data;  //token  3ffei3lsaaxnmgk333df
   
      } else if(response.statusCode==403||  response.statusCode==401){

       g. Get.offAll(()=>AuthPage());
      }
       else {
             log("Emptry");
        recordList = null;
      }

      return 

      getDioResult(response, recordList);
    }  on DioError catch(e){
     return      DioResult.withError(e.toString() , data: null);

    }
    catch (e) {
      log(e.toString());
      print("Exception - login(): " + e.toString());
    return      DioResult.withError(e.toString() , data: null);

    }
  }


Future<dynamic> updateUserData(
String? userId ,String? name , String? bloodType ,String? image, String? birthData,
LatLng latLng
  ) async {
    try {
      Response response;
      var dio = Dio(BaseOptions(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        
      ));
       var formData;
      if (image!=null) {
         formData =
          FormData.fromMap({
            
           'birthdate': birthData,
            'latitude':latLng.longitude,
            'longitude':latLng.longitude,
            'image':
            
             await MultipartFile.fromFile(image.toString())
            
            // File(image)
            ,


           'usertype':'client',
'name':name,'_method':'put' ,
'bloodtype':bloodType,


     });
      } else {
        formData =
          FormData.fromMap({
            
           'birthdate': birthData,
            'latitude':latLng.longitude,
            'longitude':latLng.longitude,
           

           'usertype':'client',
'name':name,'_method':'put' ,
'bloodtype':bloodType,

     });
      }
      response = await dio.post('${global.url}user/${global.currentUser!.id}/update',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic recordList;

      log(response.data.toString());
      if (response.statusCode == 200 
      || response.statusCode == 201
      // &&
      //     response.data['status'].toString() == '1'
          
          ) {
        recordList =
       CurrentUser.fromJson(response.data);
             log(response.data.toString());
   
      } else if(response.statusCode==403||  response.statusCode==401){

       g. Get.offAll(()=>AuthPage());
      }
       else {
             log("Emptry");
        recordList = null;
      }

      return 

      getDioResult(response, recordList);
    }  on DioError catch(e){
      return      DioResult.withError(e.toString() , data: null);

    }
    catch (e) {
      log(e.toString());
      print("Exception - login(): " + e.toString());
     return      DioResult.withError(e.toString() , data: null);

    }
  }


//drug
  Future<dynamic> sendDrugRequest(
    NewDrugRequest drugRequest
  ) async {
    try {
      Response response;
      var dio = Dio(BaseOptions(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,

        
      ));
      var formData =
          FormData.fromMap({
            
            'drug_name': drugRequest.drug_name,
            'latitude':drugRequest.latitude ,
            'longitude':drugRequest.longitude,
            'distance':drugRequest.distance ,
            'insurance_company': drugRequest.insuranceCompany,
            'insurance_image': drugRequest.insuranceImage != null
            ? await MultipartFile.fromFile(drugRequest.insuranceImage!.toString())
            : null,
            'image': drugRequest.image != null
            ? await MultipartFile.fromFile(drugRequest.image!.toString())
            : null,
     });
      response = await dio.post('${global.url}drugrequest',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic recordList;

      log(response.data.toString());
      if (response.statusCode == 201 ||  response.statusCode==200 
      
      // &&
      //     response.data['status'].toString() == '1'
          
          ) {
        recordList =
        DrugResponse.fromJson(response.data)
        ;
        log("sdfjjfds");
      }  else if(response.statusCode==403||  response.statusCode==401){

       g. Get.offAll(()=>AuthPage());
      }
      else {
        recordList = null;
      }

      return 

      getDioResult(response, recordList);
    }  on DioError catch(e){
     return  DioResult.withError(getErrorMessage(e) ,data: null);
    }
    catch (e) {
      log(e.toString());
      print("Exception - login(): " + e.toString());
    return  DioResult.withError(e.toString() , data: null);
    }
  }

  Future<dynamic> getDrugRequests(
  String drugRequest_id
  ) async {
    try {
      Response response;
      var dio = Dio(BaseOptions(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
    //   var formData =
    //       FormData.fromMap({
            
    //         'phone': userId,
    //         'otp':otp ,
    //         'password':password,
    //         'password_confirm':passwordConfirm
    //  });
      response = await dio.get('${global.url}drugrequest/${drugRequest_id}',
          // data: formData,
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;

      log(response.data.toString());
      if (response.statusCode == 200 
      
      // &&
      //     response.data['status'].toString() == '1'
          
          ) {
        recordList =
        
        response.data;
        log("sdfjjfds");
      } else if(response.statusCode==403||  response.statusCode==401){

       g. Get.offAll(()=>AuthPage());
      }
       else {
        recordList = null;
      }

      return 

      getDioResult(response, recordList);
    }  on DioError catch(e){
     return  DioResult.withError(getErrorMessage(e) ,data: null);
    }
    catch (e) {
      log(e.toString());
      print("Exception - login(): " + e.toString());
   return   DioResult.withError(e.toString() ,data: null);
    }
  }

  Future<dynamic> updateDrugRequest(
  String drugRequest_id ,


  drug_name ,latitude ,longitude ,image , company , insurranceImage
  ) async {
    try {
      Response response;
      var dio = Dio(BaseOptions(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
      var 
         formData; 
        log(insurranceImage.toString());

    if (image!=null && insurranceImage==null) {
      log('JUST MEDICAL');
         formData =
       FormData.fromMap(   {
            
            'drug_name': drug_name,
            'latitude':latitude ,
            'longitude':longitude,
            'distance':0,
            'image':MultipartFile.fromFile(image),
             
                   'insurance_company': company,
          
            '_method':'put'});
    }else if ( image==null && insurranceImage!=null){
      log('JUST INSURRNACE');

       formData =
       FormData.fromMap(   {
            
            'drug_name': drug_name,
            'latitude':latitude ,
            'longitude':longitude,
            'distance':0,
        'insurance_image':MultipartFile.fromFile(insurranceImage),             
                   'insurance_company': company,
          
            '_method':'put'});
    }else if( image!=null && insurranceImage!=null){
            log('BOTH');
log(image);
log(insurranceImage);

formData =
      FormData.fromMap(   {
            
            'drug_name': drug_name,
            'latitude':latitude ,
            'longitude':longitude,
            'distance':0,   'image':MultipartFile.fromFile(image),
        'insurance_image':MultipartFile.fromFile(insurranceImage),             
                   'insurance_company': company,
          
            '_method':'put'});

    }else {
  log('BOTH NULL');

    formData   =
         {
            
            'drug_name': drug_name,
            'latitude':latitude ,
            'longitude':longitude,
            'distance':0,
            
            '_method':'put'};
    
    }
     
      response = await dio.post('${global.url}drugrequest/${drugRequest_id}',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic recordList;

      log(response.data.toString());
      if (response.statusCode == 200 
      
      // &&
      //     response.data['status'].toString() == '1'
          
          ) {
        recordList =
        
       DrugResponse.fromJson(response.data);
        log("sdfjjfds");
      }  else if(response.statusCode==403||  response.statusCode==401){

       g. Get.offAll(()=>AuthPage());
      }
      else {
        recordList = null;
      }

      return

      getDioResult(response, recordList);
    }  on DioError catch(e){
     return  DioResult.withError(getErrorMessage(e) ,data: null);
    }
    catch (e) {
      log(e.toString());
      print("Exception - login(): " + e.toString());
    return  DioResult.withError(e.toString() ,data: null);
    }
  }



  Future<dynamic> deleteDrugRequest(
  String drugRequest_id
  ) async {
    try {
      Response response;
      var dio = Dio(BaseOptions(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
    //   var formData =
    //       FormData.fromMap({
            
    //         'phone': userId,
    //         'otp':otp ,
    //         'password':password,
    //         'password_confirm':passwordConfirm
    //  });
      response = await dio.delete('${global.url}drugrequest/${drugRequest_id}',
          // data: formData,
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic recordList;

      log(response.data.toString());
      if (response.statusCode == 200 
      
      // &&
      //     response.data['status'].toString() == '1'
          
          ) {
        recordList =
        
        response.data;
        log("sdfjjfds");
      } else if(response.statusCode==403||  response.statusCode==401){

       g. Get.offAll(()=>AuthPage());
      }
       else {
        recordList = null;
      }

      return 

      getDioResult(response, recordList);
    }  on DioError catch(e){
      return      DioResult.withError(e.toString() , data: null);

    }
    catch (e) {
      log(e.toString());
     return      DioResult.withError(e.toString() , data: null);

    }
  }





//blood transfer


Future<dynamic> createBloodTransferRequest(
   NewBloodTransferRquest bloodTransferRquest
  ) async {
    try {
      Response response;
      var dio = Dio(BaseOptions(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        
      ));
      log(bloodTransferRquest.toJson().toString());
      var formData =
          FormData.fromMap(bloodTransferRquest.toJson());
      response = await dio.post('${global.url}bloodtransfare',
          data: bloodTransferRquest.toJson(),
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic recordList;

      log(response.data.toString());
      if (response.statusCode == 201 ||  response.statusCode==200 
      
      // &&
      //     response.data['status'].toString() == '1'
          
          ) {
        recordList =
               BloodTransferResponse.fromJson(response.data);

        ;
        log("sdfjjfds");
      } else if(response.statusCode==403||  response.statusCode==401){

       g. Get.offAll(()=>AuthPage());
      }
       else {
        recordList = null;
      }

      return 

      getDioResult(response, recordList);
    } on DioError catch(e){
      return      DioResult.withError(e.toString() , data: null);

    }
    catch (e) {
      log(e.toString());
      print("Exception - login(): " + e.toString());
     return      DioResult.withError(e.toString() , data: null);

    }
  }


Future<dynamic> getBloodTransferRequest(
  String drugRequest_id
  ) async {
    try {
      Response response;
      var dio = Dio(BaseOptions(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
    //   var formData =
    //       FormData.fromMap({
            
    //         'phone': userId,
    //         'otp':otp ,
    //         'password':password,
    //         'password_confirm':passwordConfirm
    //  });
      response = await dio.get('${global.url}bloodtransfare/${drugRequest_id}',
          // data: formData,
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;

      log(response.data.toString());
      if (response.statusCode == 200 
      
      // &&
      //     response.data['status'].toString() == '1'
          
          ) {
        recordList =
        
        BloodTransferResponse.fromJson(response.data);
        log("sdfjjfds");
      } else {
        recordList = null;
      }

      return 

      getDioResult(response, recordList);
    }  on DioError catch(e){
      return      DioResult.withError(e.toString() , data: null);

    }
    catch (e) {
      log(e.toString());
      print("Exception - login(): " + e.toString());
    return      DioResult.withError(e.toString() , data: null);

    }
  }

Future<dynamic> updateBloodTransferRequest(
  String? id,
   NewBloodTransferRquest bloodTransferRquest
  ) async {
    try {
      Response response;
      var dio = Dio(BaseOptions(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        
      ));
      // var formData =
      //     FormData.fromMap(bloodTransferRquest.toJson());
      response = await dio.put('${global.url}bloodtransfare/${id}',
          data: bloodTransferRquest.toJson(),
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic recordList;

      log(response.data.toString());
      if (response.statusCode == 201 ||  response.statusCode==202 
      
      // &&
      //     response.data['status'].toString() == '1'
          
          ) {
        recordList =
               BloodTransferResponse.fromJson(response.data);

        ;
        log("sdfjjfds");
      }  else if(response.statusCode==403||  response.statusCode==401){

       g. Get.offAll(()=>AuthPage());
      }
      else {
        recordList = null;
      }

      return 

      getDioResult(response, recordList);
    }  on DioError catch(e){
      return      DioResult.withError(e.toString() , data: null);

    }
    catch (e) {
      log(e.toString());
      print("Exception - login(): " + e.toString());
      return      DioResult.withError(e.toString() , data: null);

    }
  }


  Future<dynamic> deleteBloodRequest(
  String drugRequest_id
  ) async {
    try {
      Response response;
      var dio = Dio(BaseOptions(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
    //   var formData =
    //       FormData.fromMap({
            
    //         'phone': userId,
    //         'otp':otp ,
    //         'password':password,
    //         'password_confirm':passwordConfirm
    //  });
      response = await dio.delete('${global.url}bloodtransfare/${drugRequest_id}',
          // data: formData,
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic recordList;

      log(response.data.toString());
      if (response.statusCode == 204
      
      // &&
      //     response.data['status'].toString() == '1'
          
          ) {
        recordList =
        
        {"message":"done"};
        log("sdfjjfds");
      }  else if(response.statusCode==403||  response.statusCode==401){

       g. Get.offAll(()=>AuthPage());
      }
      else {
        recordList = null;
      }

      return 

      getDioResult(response, recordList);
    }  on DioError catch(e){
      return      DioResult.withError(e.toString() , data: null);

    }
    catch (e) {
      log(e.toString());
      print("Exception - login(): " + e.toString());
     return      DioResult.withError(e.toString() , data: null);

    }
  }



Future<dynamic> getAllBloodTransferRequest(
  ) async {
    try {
      Response response;
      var dio = Dio(BaseOptions(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
    //   var formData =
    //       FormData.fromMap({
            
    //         'phone': userId,
    //         'otp':otp ,
    //         'password':password,
    //         'password_confirm':passwordConfirm
    //  });
      response = await dio.get('${global.url}bloodtransfares',
          // data: formData,
          options: Options(
            headers: await global.getApiHeaders(true),
          ));


log(response.data.toString());
      List<BloodTransferResponse>  recordList;

     
      if (response.statusCode == 200 
      
      // &&
      //     response.data['status'].toString() == '1'
          
          ) {
        recordList =
        List.from(response.data.map((e)=>BloodTransferResponse.fromJson(e)));
        // BloodTransferResponse.fromJson(response.data);
        log("sdfjjfds");
      }
      
      
       else if(response.statusCode==403||  response.statusCode==401){
   recordList = [];
       g. Get.offAll(()=>AuthPage());
      }
      
      
       else {
        recordList = [];
      }

      return 

      getDioResult(response, recordList);
    }  on DioError catch(e){
    return   DioResult.withError(getErrorMessage(e) ,
    
    data: []
    );
    }
    catch (e) {
      log(e.toString());
      print("Exception - login(): " + e.toString());
      return DioResult.withError(e.toString());
    }
  }



//medical request replies


Future<dynamic> createDrugRequestReply(
  String? id,
   DrugRequestReply bloodTransferRquest
  ) async {
    try {
      Response response;
      var dio = Dio(BaseOptions(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        
      ));
      var formData =
          FormData.fromMap(bloodTransferRquest.toJson());
      response = await dio.post('${global.url}drugrequest/${id}/reply',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic recordList;

      log(response.data.toString());
      if (response.statusCode == 201 ||  response.statusCode==200 
      
      // &&
      //     response.data['status'].toString() == '1'
          
          ) {
        recordList =
               BloodTransferResponse.fromJson(response.data);

        ;
        log("sdfjjfds");
      }   else if(response.statusCode==403||  response.statusCode==401){
       g. Get.offAll(()=>AuthPage());
      }else {
        recordList = null;
      }

      return 

      getDioResult(response, recordList);
    } on DioError catch(e){
       return      DioResult.withError(e.toString() , data: null);

    }
    catch (e) {
      log(e.toString());
      print("Exception - login(): " + e.toString());
      return      DioResult.withError(e.toString() , data: null);

    }
  }

Future<dynamic> getDurgRequestReplies(
  String drugRequest_id
  ) async {
    try {
      Response response;
      var dio = Dio(BaseOptions(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
    //   var formData =
    //       FormData.fromMap({
            
    //         'phone': userId,
    //         'otp':otp ,
    //         'password':password,
    //         'password_confirm':passwordConfirm
    //  });
      response = await dio.get('${global.url}drugrequest/${drugRequest_id}/reply',
          // data: formData,
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;

      log(response.data.toString());
      if (response.statusCode == 200 
      
      // &&
      //     response.data['status'].toString() == '1'
          
          ) {
        recordList =
        
        DrugRequestReplyResponse.fromJson(response.data);
        log("sdfjjfds");
      }   else if(response.statusCode==403||  response.statusCode==401){
   recordList = [];
       g. Get.offAll(()=>AuthPage());
      }else {
        recordList = null;
      }

      return 

      getDioResult(response, recordList);
    }  on DioError catch(e){
       return      DioResult.withError(e.toString() , data: null);

    }
    on DioError catch(e){
      return      DioResult.withError(e.toString() , data: null);

    }
    catch (e) {
      log(e.toString());
      print("Exception - login(): " + e.toString());
     return      DioResult.withError(e.toString() , data: null);

    }
  }





//config

Future<dynamic> getConfirg(
  ) async {
    try {
      Response response;
      var dio = Dio(BaseOptions(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
    //   var formData =
    //       FormData.fromMap({
            
    //         'phone': userId,
    //         'otp':otp ,
    //         'password':password,
    //         'password_confirm':passwordConfirm
    //  });
      response = await dio.get('${global.url}configs',
          // data: formData,
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;

      log(response.data.toString());
      if (response.statusCode == 200 
      
      // &&
      //     response.data['status'].toString() == '1'
          
          ) {
        recordList =
        
        ConfigModel.fromJson(response.data);
        log("sdfjjfds");
      } else {
        recordList = null;
      }

      return 

      getDioResult(response, recordList);
    } 
    on DioError catch(e){
       DioResult.withError(getErrorMessage(e));
    }
    catch (e) {
      log(e.toString());
      print("Exception - login(): " + e.toString());
      DioResult.withError(e.toString());
    }
  }


//ambulance


Future<dynamic> createAmbulanceRequest(
  double lat ,double lng, String location
  ) async {
    try {
      Response response;
      var dio = Dio(BaseOptions(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
    //   var formData =
    //       FormData.fromMap({
            
    //         'phone': userId,
    //         'otp':otp ,
    //         'password':password,
    //         'password_confirm':passwordConfirm
    //  });
      response = await dio.post('${global.url}ambulancerequest',
          data: {
            'request_latitude':lat,
            'request_longitude':lng,
            'location':'bahri'
          },
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic  recordList;
log(response.data.toString());;
     
      if (response.statusCode == 201
      
      // &&
      //     response.data['status'].toString() == '1'
          
          ) {
        recordList =response.data;
        // List.from(response.data.map((e)=>BloodTransferResponse.fromJson(e)));
        // BloodTransferResponse.fromJson(response.data);
        log("sdfjjfds");
      } 
      
        else if(response.statusCode==403||  response.statusCode==401){
   recordList = [];
       g. Get.offAll(()=>AuthPage());
      }
      else {
        recordList = [];
      }

      return 

      getDioResult(response, recordList);
    }  on DioError catch(e){
 return      DioResult.withError(e.toString() , data: null);
    }
    catch (e) {
      log(e.toString());
      print("Exception - login(): " + e.toString());
 return      DioResult.withError(e.toString() , data: null);
    }
  }





Future<dynamic> searchAmbulances(
  double lat ,double lng, 
  ) async {
    try {
      Response response;
      var dio = Dio(BaseOptions(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
    //   var formData =
    //       FormData.fromMap({
            
    //         'phone': userId,
    //         'otp':otp ,
    //         'password':password,
    //         'password_confirm':passwordConfirm
    //  });
      response = await dio.post('${global.url}ambulances/nearest',
          data: {
            'request_latitude':lat,
            'request_longitude':lng,
            // 'location':'bahri'
          },
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      List<DriverModel>  recordList;
log(response.data.toString());;
     
      if (response.statusCode == 201
      ||  response.statusCode == 200
      // &&
      //     response.data['status'].toString() == '1'
          
          ) {
        recordList =
        List.from(response.data.map((e)=>DriverModel.fromJson(e)));
        // BloodTransferResponse.fromJson(response.data);
      } 
      
        else if(response.statusCode==403||  response.statusCode==401){
   recordList = [];
       g. Get.offAll(()=>AuthPage());
      }
      else {
        recordList = [];
      }

      return 

      getDioResult(response, recordList);
    }  on DioError catch(e){
 return      DioResult.withError(e.toString() , data: []);
    }
    catch (e) {
      log(e.toString());
      print("Exception - login(): " + e.toString());
 return      DioResult.withError(e.toString() , data: []);
    }
  }


//hospital

Future<dynamic> getHospitals(
  ) async {
    try {
      Response response;
      var dio = Dio(BaseOptions(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
    //   var formData =
    //       FormData.fromMap({
            
    //         'phone': userId,
    //         'otp':otp ,
    //         'password':password,
    //         'password_confirm':passwordConfirm
    //  });
      response = await dio.get('${global.url}hospitals',
          // data: formData,
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      List<HospitalModel> recordList=[];

      if (response.statusCode == 200 
      
    ||response.statusCode == 201||response.statusCode == 202
          
          ) {
log(response.statusMessage!);
log(response.statusCode!.toString());
log(response.statusMessage!);

            
        recordList =
     List.from(response.data.map((day)=>
          HospitalModel.fromJson(day)
        ));
      
  // (response.data as List).map((map)=>
  //         HospitalModel.fromJson(map)
  //       )
        
  //       .toList();



        // response.data.map((e) => HospitalModel.fromJson(e)).toList();

        // BloodTransferResponse.fromJson(response.data);
    
      }   else if(response.statusCode==403||  response.statusCode==401){
   recordList = [];
       g. Get.offAll(()=>AuthPage());
      }else {
        recordList = [];
      }
 return getDioResult(response, recordList);
    }  on DioError catch(e){
 return      DioResult.withError(e.toString() , data: []);
    }
    catch (e) {
      log(e.toString());
      print("Exception - login(): " + e.toString());
 return      DioResult.withError(e.toString() , data: []);
    }
  }

//firebase 


Future<dynamic> updateFirebaseToken(
  String? id,
   String?  token
  ) async {
    try {
      Response response;
      var dio = Dio(BaseOptions(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        
      ));
      var formData =
          // FormData.fromMap(bloodTransferRquest.toJson());
      response = await dio.put('${global.url}user/${id}/token',
          data: {

            'device_token':token
          },
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic recordList;

      log(response.data.toString());
      if (response.statusCode == 201 ||  response.statusCode==200 
      
      // &&
      //     response.data['status'].toString() == '1'
          
          ) {
        recordList =
          response.data

        ;
        log("sdfjjfds");
      }   else if(response.statusCode==403||  response.statusCode==401){
       g. Get.offAll(()=>AuthPage());
      }else {
        recordList = null;
      }

      return 

      getDioResult(response, recordList);
    } on DioError catch(e){
 return      DioResult.withError(e.toString() , data: null);
    }
    catch (e) {
      log(e.toString());
      print("Exception - login(): " + e.toString());
 return      DioResult.withError(e.toString() , data: null);
    }
  }
//notificatin


  Future<dynamic> getNotificationCount(
  ) async {
    try {
      Response response;
      var dio = Dio(BaseOptions(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
    //   var formData =
    //       FormData.fromMap({
            
    //         'phone': userId,
    //         'otp':otp ,
    //         'password':password,
    //         'password_confirm':passwordConfirm
    //  });
      response = await dio.get('${global.url}user/unread-notifications-count',
          // data: formData,
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;

      log(response.data.toString());
      if (response.statusCode == 200 
      
      // &&
      //     response.data['status'].toString() == '1'
          
          ) {
        recordList =
        
        response.data['count'];
        log("sdfjjfds");
      } else if(response.statusCode==403||  response.statusCode==401){

       g. Get.offAll(()=>AuthPage());
      }
       else {
        recordList = null;
      }

      return 

      getDioResult(response, recordList);
    }  on DioError catch(e){
     return  DioResult.withError(getErrorMessage(e) ,data: null);
    }
    catch (e) {
      log(e.toString());
      print("Exception - login(): " + e.toString());
   return   DioResult.withError(e.toString() ,data: null);
    }
  }
 
 
 
  Future<dynamic> makeNotificationRead(
    String?  id
  ) async {
    try {
      Response response;
      var dio = Dio(BaseOptions(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
    //   var formData =
    //       FormData.fromMap({
            
    //         'phone': userId,
    //         'otp':otp ,
    //         'password':password,
    //         'password_confirm':passwordConfirm
    //  });
      response = await dio.post('${global.url}user/notifications/${id}/read',
          // data: formData,
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;

      log(response.data.toString());
      if (response.statusCode == 204 
      
      // &&
      //     response.data['status'].toString() == '1'
          
          ) {
        recordList =
        
        response.data;
        log("sdfjjfds");
      } else if(response.statusCode==403||  response.statusCode==401){

       g. Get.offAll(()=>AuthPage());
      }
       else {
        recordList = null;
      }

      return 

      getDioResult(response, recordList);
    }  on DioError catch(e){
     return  DioResult.withError(getErrorMessage(e) ,data: null);
    }
    catch (e) {
      log(e.toString());
      print("Exception - login(): " + e.toString());
   return   DioResult.withError(e.toString() ,data: null);
    }
  }
 
 


 
  Future<dynamic> getUnreadNotificationCount(
  ) async {
    try {
      Response response;
      var dio = Dio(BaseOptions(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
    //   var formData =
    //       FormData.fromMap({
            
    //         'phone': userId,
    //         'otp':otp ,
    //         'password':password,
    //         'password_confirm':passwordConfirm
    //  });
      response = await dio.post('${global.url}user/unread-notifications-count',
          // data: formData,
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;

      log(response.data.toString());
      if (response.statusCode == 204 
      
      // &&
      //     response.data['status'].toString() == '1'
          
          ) {
        recordList =
        
        response.data;
        log("sdfjjfds");
      } else if(response.statusCode==403||  response.statusCode==401){

       g. Get.offAll(()=>AuthPage());
      }
       else {
        recordList = null;
      }

      return 

      getDioResult(response, recordList);
    }  on DioError catch(e){
     return  DioResult.withError(getErrorMessage(e) ,data: null);
    }
    catch (e) {
      log(e.toString());
      print("Exception - login(): " + e.toString());
   return   DioResult.withError(e.toString() ,data: null);
    }
  }
 
 











 
 
  dynamic getDioResult<T>(final response, T recordList) {
    try {
      dynamic result;
      result = DioResult.fromJson(response, recordList);
      return result;
    } catch (e) {
      print("Exception - getDioResult():" + e.toString());
    }
  }
}



String?  getErrorMessage(DioError error){
  String errorDescription;
  switch (error.type) {
            case DioErrorType.cancel:
              errorDescription = "Request to API server was cancelled";
              break;
            case DioErrorType.connectionTimeout:
              errorDescription = "Connection timeout with API server";
              break;
            case DioErrorType.unknown:
              errorDescription =
              "Connection to API server failed due to internet connection";
              break;
            case DioErrorType.receiveTimeout:
              errorDescription =
              "Receive timeout in connection with API server";
              break;
            case DioErrorType.badResponse:
              switch (error.response!.statusCode) {
                case 404:
                case 500:
                case 503:
                  errorDescription = 'server error ';
                  break;
                default:
                
                
                    errorDescription = 'Unknown Error , try Agin';
                  
              }
              break;
            case DioErrorType.sendTimeout:
              errorDescription = "Send timeout with server";
              break;
            case DioErrorType.badCertificate:
             errorDescription = "Bad Certificate";
              break;
            case DioErrorType.connectionError:
             errorDescription = "Connection Error";
              break;
             default:
                
                
                    errorDescription = 'Unknown Error , try Agin';


          }


          return errorDescription;
}
import 'dart:developer';

import 'package:dio/dio.dart';

class DioResult<T> {
  int? statusCode;
  dynamic status;

  String? message;
  T? data;

  DioResult({this.statusCode, this.data, this.status});
    DioResult.withError(String? error , {T? data}) {

message=error;
this.data=data;


    }
  DioResult.fromJson(dynamic response, T recordList) {
    try {

      log(response.data.runtimeType.toString());

         if (response.data is Map) {

     

           if (response.data.containsKey('message')) {
              log('dsds');
             message = response.data['message'] ?? '';
           
           } else{
             message='';
           }

     

 if (response.data.containsKey('status')) {
            status =   response.data['status'] ?? 1;
           
           } else{
             status=1;
           }

         }else{
           message='';
           status=1;
         }
             log('No Error HERE');

      statusCode = response.statusCode;
      data = recordList;
    
    } catch (e) {
      log("Exception - dioResult.dart - DioResult.fromJson():" + e.toString());
    }
  }
}
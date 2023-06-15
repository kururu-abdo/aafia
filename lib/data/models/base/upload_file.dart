import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class UploadFile {
  bool? success;
  String? message;

  bool? isUploaded;

  Future<UploadFile?> call( XFile? fileData) async {
   

try {

          var fileUploaded= UploadFile()
          ..success=true 
          ..message='downloadUrl'
          ..isUploaded=true;

      return     fileUploaded;
//  return downloadUrl;
} on Exception catch (e) {
    log('Err');

    log(e.toString());
     var result=UploadFile()..success=false 
          ..message='Error uploading photo'
          ..isUploaded=false;

return result;
 throw ('Error uploading photo');

}catch(e){
  log('Err');
  log(e.toString());
  var result= UploadFile()..success=false 
          ..message='Error uploading photo'
          ..isUploaded=false;
          return result;

  throw ('Error uploading photo');
}




  }
}
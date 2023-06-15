import 'dart:developer';

import 'package:aafia/data/models/base/upload_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

enum Source { GALLERY, CAMERA, NONE }
class AddAttachmentModalSheet extends StatefulWidget {
  final Size screenSize;
  Source source = Source.NONE;
final  Function(String)? getImageUrl;
final  Function(XFile)? selectedFile;

  AddAttachmentModalSheet(this.screenSize , this.getImageUrl, {this.selectedFile});

  @override
  _AddAttachmentModalSheetState createState() =>
      _AddAttachmentModalSheetState();
}

class _AddAttachmentModalSheetState extends State<AddAttachmentModalSheet> {
  _buildHeading(String text) {
    return Text(text, style: TextStyle(fontSize: 26, color: Colors.black));
  }

  _buildCloseButton(context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(Icons.close, color: Theme.of(context).primaryColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildHeading('Upload'),
                _buildCloseButton(context)
              ],
            ),
            SizedBox(height: 16),
            _buildOption(Icons.camera, 'Camera',
                ()async{

// await Permission.storage
// .request();
// await Permission.photos
// .request();
//     var permissionStatus = await Permission.photos.status;
//     if (permissionStatus.isGranted) {
      ImagePicker picker =ImagePicker(

      );

    final XFile? image = await picker.pickImage(source: ImageSource.camera);

var uploadTaks =await UploadFile(

).call(image);

if (uploadTaks!.success!) {
  widget.getImageUrl!(uploadTaks.message!);
} else {
    widget.getImageUrl!(uploadTaks.message!);
  log('Error');
    log(uploadTaks.message.toString());

  log('Error');
  log(uploadTaks.message.toString());
  
}







    // }else {

    //   log('NOT GRANTED');
    // }


          Navigator.pop(context);




                }),
            _buildOption(Icons.photo_library, 'Photo library',
                ()async{
// await Permission.photos.request();

//     var permissionStatus = await Permission.photos.status;
//     if (permissionStatus.isGranted) {
      ImagePicker picker =ImagePicker(

      );

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
widget.selectedFile!(image!);
var uploadTaks =await UploadFile(
//////////////
).call(image);
log(uploadTaks!.success!.toString());
if (uploadTaks.success!) {
  widget.getImageUrl!(uploadTaks.message!);
} else {
    widget.getImageUrl!(uploadTaks.message!);
      log(uploadTaks.message.toString());

  log('Error');
  log(uploadTaks.message.toString());
}


  log('Error');





    // }


          Navigator.pop(context);



                }),
          ],
        ),
      ),
    );
  }

  _buildOption(IconData optionIcon, String optionName, Function() onItemClicked) {
    return GestureDetector(
      onTap: onItemClicked,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: <Widget>[
            Icon(optionIcon),
            SizedBox(width: 8),
            Text(
              optionName,
              style: TextStyle(color: Colors.black, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }

  _onAddPhotoClicked(context) async {
    // GetImagePermission getPermission = GetImagePermission.gallery();
    // await getPermission.getPermission(context);
 await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted) {
      widget.source = Source.GALLERY;
      Navigator.pop(context);
    }
  }

  _onPickFromCameraClicked(context) async {
  await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted) {
      widget.source = Source.CAMERA;
      Navigator.pop(context);
    }
  }
}
import 'dart:developer';
import 'dart:io';

import 'package:aafia/base/base.dart';
import 'package:aafia/controllers/auth_controller.dart';
import 'package:aafia/utils/app_constants.dart';
import 'package:aafia/utils/conversions.dart';
import 'package:aafia/utils/validations.dart';
import 'package:aafia/widgets/dropdown_field.dart';
import 'package:aafia/widgets/my_Button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:place_picker/place_picker.dart';
import 'package:aafia/utils/global.dart' as global;
import '../widgets/my_textfield.dart';

class EditMyDataPage extends BaseRoute {
   EditMyDataPage():super(r: 'EditData');

  @override
 _EditMyDataPageState createState() => _EditMyDataPageState();
}

class _EditMyDataPageState extends BaseRouteState{

  GlobalKey<ScaffoldState>? _scaffoldKey;


TextEditingController _uAgeController=TextEditingController();

List<String> _bloodTypes =[
  
'O-' ,'O+' ,'B+' ,'A+' ,'A-' ,'AB-' ,'AB+'
];
File? _pSelectedImage;
var authController= Get.put(AuthController());

@override
void initState() { 
  super.initState();
  authController.initUserData();
}


String? _bloodType;
List<String> _workLocations =[
  
'khartoum' ,'omdurman','bahri'
];
//functions

_selectDate(BuildContext context) async {
  final DateTime? selected = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1930),
    lastDate: DateTime(2025),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: Theme.of(context).primaryColor, // <-- SEE HERE
            onPrimary: Colors.white, // <-- SEE HERE
            onSurface: Colors.blueAccent, // <-- SEE HERE
          ),
          // textButtonTheme: TextButtonThemeData(
          //   style: TextButton.styleFrom(
          //     primary: Colors.red, // button text color
          //   ),
          // ),
        ),
        child: child!,
      );
    },
  );

  return selected;
}
Future<File?> openCamera() async {
    try {
      PermissionStatus permissionStatus = await Permission.camera.status;
      if (permissionStatus.isLimited || permissionStatus.isDenied) {
        permissionStatus = await Permission.camera.request();
      }
      XFile? _selectedImage =
          await (ImagePicker().pickImage(source: ImageSource.camera));
      File imageFile = File(_selectedImage!.path);

      // File? _finalImage = await (_cropImage(imageFile.path));

      // _finalImage = await (_imageCompress(_finalImage!, imageFile.path));

      return imageFile;
    } catch (e) {
      print("Exception - profile_picture.dart - openCamera():" + e.toString());
    }
    return null;
  }

  Future<File?> selectImageFromGallery() async {
    try {
      PermissionStatus permissionStatus = await Permission.photos.status;
      if (permissionStatus.isLimited || permissionStatus.isDenied) {
        permissionStatus = await Permission.photos.request();
      }
      File imageFile;

      XFile? _selectedImage =
          await (ImagePicker().pickImage(source: ImageSource.gallery));

      imageFile = File(_selectedImage!.path);

      // File? _byteData = await (_cropImage(imageFile.path));
      // log('NO EXCEPTION 1');
      // // log((_byteData == null).toString());
      // _byteData = await (_imageCompress(_byteData!, imageFile.path));
      // // log('NO EXCEPTION 2');
      // log(_byteData!.path.toString());
      return imageFile;
    } catch (e) {
      log("HERE IS EXCEPATION" + e.toString());
      print("Exception - profile_picture.dart - selectImageFromGallery()" +
          e.toString());
    }
    return null;
  }

  Future<File?> _cropImage(String sourcePath) async {
    try {
      var croppedImage = await ImageCropper().cropImage(
        sourcePath: sourcePath,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            initAspectRatio: CropAspectRatioPreset.original,
            backgroundColor: Colors.white,
            toolbarColor: Colors.black,
            dimmedLayerColor: Colors.white,
            toolbarWidgetColor: Colors.white,
            cropGridColor: Colors.white,
            activeControlsWidgetColor: Color(0xFF46A9FC),
            cropFrameColor: Color(0xFF46A9FC),
            lockAspectRatio: true,
          ),
        ],
      );

      File? _croppedFile = File(croppedImage!.path);

      log(_croppedFile.toString());
      return _croppedFile;
    } catch (e) {
      log(e.toString());
      print("Exception - profile_picture.dart - _cropImage():" + e.toString());
    }
    return null;
    // return null;
  }
var _uLocationCOntroller=TextEditingController();
  Future<File?> _imageCompress(File file, String targetPath) async {
    try {
      var result = await FlutterImageCompress.compressAndGetFile(
        file.path,
        targetPath,
        minHeight: 500,
        minWidth: 500,
        quality: 60,
        // format: CompressFormat.png
      );

      return result;
    } catch (e) {
      print("Exception - profile_picture.dart - _cropImage():" + e.toString());
      return null;
    }
  }

File? tImage;
  _showCupertinoModalSheet() {
    try {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: Text('Events'),
          actions: [
            CupertinoActionSheetAction(
              child: Text(
                'Take a picture',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              onPressed: () async {
                Navigator.pop(context);

                tImage = await openCamera();

// if (this.accountType=='user') {
//   _uSelectedImage=tImage;

// } else {
  _pSelectedImage=tImage;
// }

                // global.selectedImage = tImage!.path;
                // widget.imageSelected!(true);



                setState(() {});
                authController.updateImage(tImage);
              },
            ),
            CupertinoActionSheetAction(
              child: Text(
                'Upload Image',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              onPressed: () async {
                Navigator.pop(context);

                tImage = await selectImageFromGallery();
//               if (this.accountType=='user') {
//   _uSelectedImage=tImage;

// } else {
  _pSelectedImage=tImage;
// }
                setState(() {});
                  authController.updateImage(tImage);
              },

           
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text('Cancel',
                style: TextStyle(color: Theme.of(context).primaryColor)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    } catch (e) {
      print("Exception - profile_picture.dart - _showCupertinoModalSheet():" +
          e.toString());
    }
  }


var  _uFormKey= GlobalKey<FormState>();


DateTime?  _birthDate;

double?  lat;
double? lng;
String? _workLocation;




File? _uSelectedImage;




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,

        title: Text('${tr('edit_my_data')}' , style: TextStyle(color: Theme.of(context).primaryColor),),
centerTitle: true, 

leading: IconButton(onPressed: (){
  Get.back();
}, icon: Icon(Icons.arrow_back_ios  ,  color: Colors.black,)),
      ),

body:GetBuilder<AuthController>(
  builder: (controller) {
    return     Container(
      // height: 999,
      padding: EdgeInsets.only(
        top: 20  ,left: 20 ,right: 20
      ), 
    
      child: Form(
        child: SingleChildScrollView(
          //  SingleChildScrollView(
          padding: MediaQuery.of(context).viewInsets.copyWith(
            top: 20  ,left: 20 ,right: 20
          )  ,
          child:  ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
                minHeight: MediaQuery.of(context).size.height,
                // maxHeight: 1009
              ),

            child: IntrinsicHeight(
              child: Column(
                
                children: [
                Stack(
              children: [
               ClipOval(
              child: 
              
              global.currentUser!.image == null || global.currentUser!.image.length<2?
                
              // _pSelectedImage!=null?
              authController.pSelectedImage!=null?
              Image.file( authController.pSelectedImage! ,width: 120,height: 120,):
              Image.asset('assets/images/png/placeholder.jpg' , fit: BoxFit.cover,
                width: 120.0,
                height: 120.0,):
              
              
              
              
              Image.network(
                global.configModel.imagesUrl!+"/"+global.currentUser!.image.toString(),
                fit: BoxFit.cover,
                width: 120.0,
                height: 120.0,
              )
                ) ,
                
                Positioned(
                  
                  bottom: 0, right: -5,
                
                  child: GestureDetector(
                    onTap: (){
                      _showCupertinoModalSheet();
                      // showModalBottomSheet(context: context, builder: _showCupertinoModalSheet)
                    },
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white ,shape: BoxShape.circle
                      ),
                      child: Icon(
                  Icons.edit  ,color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                ) ,
                
                
              ],
                ),
              SizedBox(
                height: 69
              ),
                
                Form(
              key: controller.formKey,
              child: 
                
                Expanded(
              child:   Column(
                children: [
              
              
                  BoxTextField(
                    label: '${tr('name')}',
                    controller: controller.nameController,validator: validateRequiredField,
                  ),
              //dropdown here
              GestureDetector(
                onTap: ()async{
              var date =await _selectDate(context);
                 if (date!=null) {
                
              setState(() {
                _birthDate =date;
                controller.birthDate.text =birthDateFormate(_birthDate!);
              });
                 }
                },
                child:   BoxTextField(label: '${tr('birth_date')}',
                enabled: false,
                // controller: _uAgeController,
                // suffix: IconButton(onPressed: (){},
                
                //  icon:  Icon(Icons.keyboard_arrow_down,
                
                
                // color: Theme.of(context).primaryColor,
                // )
                
                // ),
                            controller: controller.birthDate,validator: validateRequiredField,
                  
                ),
              )
              ,
              
              //dropdown here
                GestureDetector(
                onTap: ()async{
                LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            PlacePicker(AppConstants.GOOGLE_MAP_KEY!,
                                      
              
              
              
                                        )));
              
              
                      controller.locationController.text =result.name!;
                      setState(() {
                        lat =result.latLng!.latitude;
                        lng = result.latLng!.longitude;
                      });
                },
                child:   BoxTextField(label: '${tr('address')}',
                
                controller: controller.locationController,
                enabled: false,
                suffix: IconButton(onPressed: (){
                  log('sdfdsf');
                }, icon:  Icon(Icons.location_on,
                color: Theme.of(context).primaryColor,
                )
                
                ),
                
                ),
              ),
              
                
              AppDropdownInput<String>(
                options: _bloodTypes,
                hintText: '${tr('blood_type')}',
                value: controller.bloodType,
                getLabel: (str)=>str,
                onChanged: (str){
              setState(() {
                
                _bloodType =str!;
              });
              controller.updateBlood(str);
                },
              
              ),
              SizedBox(height: 10,),
              SizedBox(
                height: 30
              ),
              // Spacer(),
              MyButton(
                title: '${tr('edit_my_data')}' ,
                isLoading: controller.isLoading,
                onTap: ()async{
                  if (controller.formKey.currentState!.validate()) {
                     await controller.updateUserData();
                     setState(() {
                       
                     });
                  }
                 
                },
              )
              // Container(
              //       height: 60,
              //       margin: EdgeInsets.symmetric(vertical: 4),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(10) ,color: Theme.of(context).primaryColor
              // ),
              // child: Center(child: Text('Edit My Data' ,style: TextStyle(
              //   color: Colors.white ,
              // ),),),
              // )
              
              
                ],
              ),
                )
                )
                
                
                
                
                
                
                
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
),
    );
  }





}
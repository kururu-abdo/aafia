import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:aafia/base/base.dart';
import 'package:aafia/data/models/response/current_user.dart';
import 'package:aafia/data/models/response/new_user.dart';
import 'package:aafia/pages/dashboard.dart';
import 'package:aafia/pages/otp_page.dart';
import 'package:aafia/pages/terms_and_conditions.dart';
import 'package:aafia/utils/app_constants.dart';
import 'package:aafia/utils/colors.dart';
import 'package:aafia/utils/conversions.dart';
import 'package:aafia/utils/global.dart' as global;
import 'package:aafia/utils/validations.dart';
import 'package:aafia/widgets/custom_dropdown.dart';
import 'package:aafia/widgets/dropdown_field.dart';
import 'package:aafia/widgets/my_Button.dart';
import 'package:aafia/widgets/my_textfield.dart';
import 'package:aafia/widgets/phone_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';
class SignupScreen extends BaseRoute {
  final String? accountType;
   SignupScreen({ Key? key, this.accountType ='user'}) : super(r: 'Signup');

  @override
  _SignupScreenState createState() => _SignupScreenState(accountType);
}

class _SignupScreenState extends BaseRouteState {
  final String? accountType;

bool isLoading=false;


//person
var  _uFormKey= GlobalKey<FormState>();

TextEditingController _uNameController=TextEditingController();
var __uNameFocus=FocusNode();

TextEditingController _uAgeController=TextEditingController();
var __uAgeFocus=FocusNode();

var _uLocationCOntroller=TextEditingController();
var _uLocationFocus= FocusNode();


var _uBloodTypeConroller=TextEditingController();
var _uBloodTypeFocus=FocusNode();

var _udescribeLocationConroller=TextEditingController();

var _uPhoneNumberController=TextEditingController();
var _uPhoneFocus=FocusNode();


var _uPasswordController=TextEditingController();
var _uPasswordFocus=FocusNode();
var _uConfirmPasswordController=TextEditingController();
var _uConnfirmPasswordFocus=FocusNode();

File? _uSelectedImage;


bool _pshowPassword=false;
bool _pshowConfirmPassword=false;
bool _pAgree=false;

List<String> _bloodTypes =[
  
'O-' ,'O+' ,'B+' ,'A+' ,'A-' ,'AB-' ,'AB+'
];



String? _bloodType;
List<String> _workLocations =[
  
'khartoum' ,'omdurman','bahri'
];



String? _workLocation;



DateTime?  _birthDate;

double?  lat;
double? lng;

//pharmacy

var  _pFormKey= GlobalKey<FormState>();



TextEditingController _pNameController=TextEditingController();
var __pNameFocus=FocusNode();


var _pLocationCOntroller=TextEditingController();
var _pLocationFocus= FocusNode();



var _pPhoneNumberController=TextEditingController();
var _pPhoneFocus=FocusNode();
var _pDescController=TextEditingController();
var _pDescFocus=FocusNode();

var _pPasswordController=TextEditingController();
var _pPasswordFocus=FocusNode();
var _pConfirmPasswordController=TextEditingController();
var _pConnfirmPasswordFocus=FocusNode();

File? _pSelectedImage;

bool _fshowPassword=false;
bool _fshowConfirmPassword=false;
bool _fAgree=false;

  _SignupScreenState(this.accountType);


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


//signup functions
_onSignup()async{
        bool isConnected = await br.checkConnectivity();
if (isConnected) {
   if (accountType=='user') {
    

if (_uFormKey.currentState!.validate()) {
  
if(_bloodType==null){
ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please select Blood type'),
          backgroundColor: Colors.red,
        ));
  
  
  
  }
  
  else if(lat==null || lng==null){
ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Select Location'),
          backgroundColor: Colors.red,
        ));

  }else if(!_fAgree){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('You have to Agree with our terms '),
          backgroundColor: Colors.red,
        ));
  }
  else {
NewUser newUser =NewUser()
..password=_uPasswordController.text.trim()
..password_confirm=_uConfirmPasswordController.text.trim()
..phone= _uPhoneNumberController.text.trim()
..usertype='client'
..longitude=lng
..latitude=lat
..name=_uNameController.text.trim()
..image=_uSelectedImage!=null?_uSelectedImage!.path:null
..birthdate=_birthDate.toString()
..bloodtype=_bloodType

;

;
            showOnlyLoaderDialog();
await apiHelper.signUp(newUser ).then((result) {
hideLoader();

      if (result != null) { 
 if (result.data!=null) {
     global.currentUser=   result.data!;
    // global.sp!.setString(
    //               'currentUser', json.encode(result.data!.toJson()));
    //               global.sp!.setString(global.token, result.data!.token!);
showSnackBar(
                    key: _scaffoldKey,
                    
                    snackBarMessage:
                    'Your account created successfully' ,isSuccess: true);
//    Get.to(()=>OtpPage(
// isFirstScreen: true,
// phoneNumber: _uPhoneNumberController.text.trim()
     
//    ));

   Get.offAll(
                  () => OtpPage(
                    phoneNumber: _uPhoneNumberController.text.trim(),
                    isFirstScreen: true,
                    onNavigate: (){
                       Get.offAll(
                  () => DashboardPage(                    isFromOtp:true
));
                    },
                        // a: widget.analytics,
                        // o: widget.observer,
                      ),
                  transition: Transition.circularReveal);
 }else{

   
showSnackBar(
                    key: _scaffoldKey,
                    
                    snackBarMessage:
                    result.message.toString() ,   );
 }
   
   
      }else {
showSnackBar(
                    key: _scaffoldKey,
                    
                    snackBarMessage:
                    result.message.toString() ,   );
      }
//               if (result.status == "1") {
//                 hideLoader();
//                 log('GOIN WITH NUMBER' + _cPhoneNumber.text);

             
//                 // var mapper = ToCurrnerUser();

//                 global.currentUser =result.data;
                
//                 // var mapper = ToCurrnerUser();
//                 global.userProfileController.currentUser = result.data;
//               try {
//                   global.sp!.setString(
//                       'currentUser', json.encode(result.data.toJson()));
//               } catch (e) {
//                 log(e.toString());
//               }
// log('Sign up Done');




//                 Get.to(() => OtpVerificationScreen(
//                       a: widget.analytics,
//                       o: widget.observer,
//                       phoneNumber: _cPhoneNumber.text.trim(),
//                       referalCode: _cReferral.text.trim(),
//                     ));
//               } else {
//                 hideLoader();
//           String?  valiationMessage;
// var stringSrc = jsonEncode(result.data);
// Map  map =  jsonDecode(stringSrc);

//       if (map.containsKey('errors')) {
//         valiationMessage = 
//         map['errors'].containsKey('user_phone')?
//          'هذا الرقم مستخدم بالفعل , استخدم رقم اخر': 'Login Failed , try again';
//       }

//       log('///');

//                 showSnackBar(
//                     key: _scaffoldKey,
//                     snackBarMessage:valiationMessage??result.message.toString());
//               }
//             }
});




  }


}
//  hideLoader();

  } else {

    //attach api

if (_pFormKey.currentState!.validate()) {
  

  
   if(lat==null || lng==null){
ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Select Location'),
          backgroundColor: Colors.red,
        ));

  }else if(!_pAgree){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('You have to Agree with our terms '),
          backgroundColor: Colors.red,
        ));
  }
  else {
NewUser newUser =NewUser()
..password=_pPasswordController.text.trim()
..password_confirm=_pConfirmPasswordController.text.trim()
..phone= _pPhoneNumberController.text.trim()
..usertype='pharmacist'
..longitude=lng
..worklocation=_workLocation
..latitude=lat
..name=_pNameController.text.trim()
..image=_pSelectedImage!=null?_pSelectedImage!.path:null
..birthdate=_birthDate.toString()
..bloodtype=_bloodType

;

;
            showOnlyLoaderDialog();
await apiHelper.signUp(newUser ).then((result) {
// hideLoader();

      if (result != null  && result.data !=null) { 
     global.currentUser=   result.data!;
    global.sp!.setString(
                  'currentUser', json.encode(result.data!.toJson()));
                  global.sp!.setString(global.token, result.data!.token!);
 Get.to(()=>OtpPage(
isFirstScreen: true,
phoneNumber: _pPhoneNumberController.text.trim()
     
   ));
      }else {
showSnackBar(
                    key: _scaffoldKey,
                    snackBarMessage:
                    result.message.toString());
      }
hideLoader();
});
  }



  
}}
  
}
}

  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    return Builder(
      builder: (context){

if (this.accountType=="user") {


  return Form(key: _uFormKey,
    child: Column(
      children: [
  
  Container(
    margin: EdgeInsets.only(bottom: 13),
             width: double.infinity,
  // margin: EdgeInsets.only(bottom: 9),
  padding: EdgeInsets.only(
    left: 114,right: 115 ,top: 17 ,bottom: 24
  ),
    decoration: BoxDecoration(
      color: AppColors.TEXT_FILLED_COLOR,
      borderRadius: BorderRadius.circular(8)
    ),
     child: Center(
  
  child: _uSelectedImage !=null?
  Stack(
    clipBehavior: Clip.none,
    children: [
          CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 60,
                      backgroundImage: FileImage(File(_uSelectedImage!.path)),
                    ),
  
  
                    Positioned(
                  bottom: 0,
                  right: -4,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: IconButton(
                      icon: Icon(
                        Icons.add_a_photo_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        _showCupertinoModalSheet();
                        setState(() {});
                      },
                    ),
                  ),
                )
    ],
  )
  : Column(
    children: [
      Transform.rotate(
        
        angle: 300,
        child: IconButton(onPressed: (){ 
          _showCupertinoModalSheet();
                        setState(() {});}, 
                        icon: Icon(Icons.login_outlined ,
                        
                        size: 24
                        ,color: Theme.of(context).primaryColor,))
        
        ),
        Text('Upload A personal Image' , style: TextStyle(
          fontSize: 14 ,fontWeight: FontWeight.w300
        ),)
    ],
  )
  ,
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
     ),
  )
  ,
  BoxTextField(label: tr('name'),
  keyboardType: TextInputType.text,
  controller: _uNameController,
  validator: validateRequiredField,
  isPhone: false,
  
  ) ,


  GestureDetector(
    onTap: ()async{
  var date =await _selectDate(context);
 if (date!=null) {
    
  setState(() {
    _birthDate =date;
    _uAgeController.text =birthDateFormate(_birthDate!);
  });
 }
    },
    child:   BoxTextField(label: tr('birth_date'),
    enabled: false,
    controller: _uAgeController,
    // suffix: IconButton(onPressed: (){},
    
    //  icon:  Icon(Icons.keyboard_arrow_down,
    
    
    // color: Theme.of(context).primaryColor,
    // )
    
    // ),
    
    ),
  )
  
  
  ,
  
  
  GestureDetector(
    onTap: ()async{
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                PlacePicker(AppConstants.GOOGLE_MAP_KEY!,
                          
  
  
  
                            )));
  
  
          // _uLocationCOntroller.text =result.name!;
          setState(() {
            lat =result.latLng!.latitude;
            lng = result.latLng!.longitude;
          });
           List<Placemark> placemarks = await placemarkFromCoordinates(lat!, lng!);
        
        
                        _uLocationCOntroller.text =  "${placemarks.first.country} ,  ${placemarks.first.locality}  ,   ${placemarks.first.name}";
        
    },
    child:   BoxTextField(label: tr('address'),
    
    controller: _uLocationCOntroller,
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
    hintText: tr('blood_type'),
    value: _bloodType,
    getLabel: (str)=>str,
    onChanged: (str){
  setState(() {
    
    _bloodType =str!;
  });
    },
  
  ),
  // SizedBox(height: 10,),
 
 
  PhoneTextField(
    
    label: tr('phone'),
     isPhone: true,
  controller: _uPhoneNumberController,
  validator: validatePhone,
  
  )
  
  
  ,
  
  
  
  BoxTextField(label:  tr('password'),
  
  controller: _uPasswordController,
  obsecure: !_pshowPassword,
  validator: validatePassword,
  suffix: IconButton(onPressed: (){
    _pshowPassword= !_pshowPassword;
    setState(() {
      
    });
  
  }, icon:  Icon(
    
    !_pshowPassword?
    Icons.visibility_off :  Icons.visibility  ,
  color: Theme.of(context).primaryColor,
  )
  
  ),
  
  ),
  
  BoxTextField(label:  tr('password_confirm'),
  obsecure: !_pshowConfirmPassword ,
  controller: _uConfirmPasswordController,
  suffix: IconButton(onPressed: (){
  
    _pshowConfirmPassword = !_pshowConfirmPassword;
    setState(() {
      
    });
  }, 
  
  
  
  icon:  Icon(
    
    !_pshowConfirmPassword?
    Icons.visibility_off :  Icons.visibility  ,
  color: Theme.of(context).primaryColor,
  )
  
  ),
  validator: (str)=>
    validateConfirmPassword(str, _uPasswordController.text.trim())
  ,
  ),
  
  Row(
    mainAxisSize: MainAxisSize.min,
    children: [
  

    GestureDetector(
                        onTap: (){
                        _fAgree=!_fAgree;

                          setState(() {
                            
                          });
                             
                        },
                        child: Container(
                      width: 24,height: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color:_fAgree?Theme.of(context).primaryColor: AppColors.ONBACKGROUND
                      ),
                      
                      child: Center(
                        child: _fAgree?Icon(Icons.check,color: Colors.white,):SizedBox.shrink(),
                      )
                        ),
                      ),
                      SizedBox(width: 6,),
  //     Checkbox(value: _fAgree, onChanged: (bool){
  // _fAgree = bool!;
  // setState(() {
    
  // });
  
  //     }),
      Expanded(child: 
      RichText(text: 
      TextSpan(
     text:   tr('agree_with'),
     style: TextStyle(
       color: Colors.black ,fontSize: 14,fontWeight: FontWeight.w400
     ),
     children: [
  
  
       TextSpan(
     text:    tr('terms_and_conditions'),
     style: TextStyle(
       color: Theme.of(context).primaryColor
      ,fontSize: 14,fontWeight: FontWeight.w400,
       decoration: TextDecoration.underline
     ),
   recognizer: TapGestureRecognizer()
     ..onTap=(){
       //route to terms page
  
       Get.to(()=>
       
       TermsAndConditionsPage()
       );
     }
  
       ) 
     ]
      )
      
      
      )
      
      )
    ],
  ),
  SizedBox(height: 10,),
  MyButton(
    title: tr('sign_up_button'),

    onTap: (){
  _onSignup();
    },
  )
  
  
  
  
      ],
    ),
  );



}


else{
 
  return Form(
    key: _pFormKey,
    child: Column(
      children: [
  
  Container(
  height: size.height*.15,
  margin: EdgeInsets.only(bottom: 5),
  width: double.infinity,
  padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: AppColors.TEXT_FILLED_COLOR,
      borderRadius: BorderRadius.circular(10)
    ),
     child: Center(
  
  child: _pSelectedImage !=null?
  Stack(
    clipBehavior: Clip.none,
    children: [
          CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 60,
                      backgroundImage: FileImage(File(_pSelectedImage!.path)),
                    ),
  
  
                    Positioned(
                  bottom: 0,
                  right: -4,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: IconButton(
                      icon: Icon(
                        Icons.add_a_photo_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        _showCupertinoModalSheet();
                        setState(() {});
                      },
                    ),
                  ),
                )
    ],
  )
  : Column(
    children: [
      Transform.rotate(
        
        angle: 300,
        child: IconButton(onPressed: (){
   _showCupertinoModalSheet();
                        setState(() {});
  
  
        }, icon: Icon(Icons.login_outlined ,color: Theme.of(context).primaryColor,))
        
        ),
        Text('Upload A Pharmacy Logo')
    ],
  )
  ,
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
     ),
  )
  ,
  BoxTextField(label: 'Pharmcacy Name',
  
  controller: _pNameController,
  
  validator: validateRequiredField,
  ) ,
  
 AppDropdownInput<String>(
    options: _workLocations,
    hintText: 'Work Location',
    value: _workLocation,
    getLabel: (str)=>str,
    onChanged: (str){
  setState(() {
    
    _workLocation =str!;
  });
    },
  
  ),
  
  
  
  SizedBox(height: 10,),
  
  GestureDetector(
    onTap: ()async{
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                PlacePicker(AppConstants.GOOGLE_MAP_KEY!,
                          
  
  
  
                            )));
  
  
          _pLocationCOntroller.text =result.name!;
          setState(() {
            lat =result.latLng!.latitude;
            lng = result.latLng!.longitude;
          });
    },
    child:   BoxTextField(label: 'Location',
    
    controller: _pLocationCOntroller,
    enabled: false,
    suffix: IconButton(onPressed: (){
      log('sdfdsf');
    }, icon:  Icon(Icons.location_on,
    color: Theme.of(context).primaryColor,
    )
    
    ),
    
    ),
  ),
  
   
  
  BoxTextField(label: 'Describe of the Location',
  
  controller: _udescribeLocationConroller,
  hegiht: 120,
  isMulti: true,
  validator: validateRequiredField,
  
  // suffix: IconButton(onPressed: (){}, icon:  Icon(Icons.keyboard_arrow_down,
  // color: Theme.of(context).primaryColor,
  // )
  
  // ),
  
  ),
  BoxTextField(label: 'Phone Number',
  
  controller: _pPhoneNumberController,
  
  validator: validatePhone,

  ),
  
  
  
  BoxTextField(label: 'Password',
  obsecure: !_fshowPassword,
  controller: _pPasswordController,
  validator: validatePassword,
  suffix: IconButton(onPressed: (){
  
    _fshowPassword= !_fshowPassword;
    setState(() {
      
    });
  }, icon:  Icon(
     !_fshowPassword?
    Icons.visibility_off :  Icons.visibility  ,
    
    // Icons.visibility_off
    // ,
  color: Theme.of(context).primaryColor,
  )
  
  ),
  
  ),
  
  BoxTextField(label: 'Confirm Password',
  obsecure: !_fshowConfirmPassword,
  validator:(str)=> validateConfirmPassword(str!.trim(), _pPasswordController.text.trim()),
  controller: _pConfirmPasswordController,
  suffix: IconButton(onPressed: (){
  _fshowConfirmPassword = !_fshowConfirmPassword;
  setState(() {
    
  });
  
  
  }, icon:  Icon( !_fshowConfirmPassword?
    Icons.visibility_off :  Icons.visibility  ,
  color: Theme.of(context).primaryColor,
  )

  ),
  
  ),
  
  Row(
    mainAxisSize: MainAxisSize.min,
    children: [
  
      Checkbox(value: _pAgree, onChanged: (bool){
  _pAgree=bool!;
  setState(() {
    
  });
  
      }),
      Expanded(child: 
      RichText(text: 
      TextSpan(
     text:   'I Agree to the ',
     style: TextStyle(
       color: Colors.black
     ),
     children: [
  
  
       TextSpan(
     text:   'Terms and Conditions',
     style: TextStyle(
       color: Theme.of(context).primaryColor,
       fontWeight: FontWeight.w600,
       decoration: TextDecoration.underline
     ),
     recognizer: TapGestureRecognizer()
     ..onTap=(){
       //route to terms page
       Get.to(()=>
       
       TermsAndConditionsPage()
       );
     }
  
       ) 
     ]
      )
      
      
      )
      
      )
    ],
  ),
  SizedBox(height: 10,),
  MyButton(
    title: 'Create a  new Account',
    onTap: (){
 
 _onSignup();
    },
  )
  
  
  
  
      ],
    ),
  );


}




      },
    );
  }





File? tImage;


//  _onSignUp() async {
//     try {
//       bool isConnected = await br.checkConnectivity();
// //       if (isConnected) {
// //         if (_cName.text.isNotEmpty &&
// //             // EmailValidator.validate(_cEmail.text) &&
// //             // _cEmail.text.isNotEmpty &&
// //             _cPassword.text.trim().length >= 8 &&
// //             _cConfirmPassword.text.isNotEmpty &&
// //             _cPassword.text.trim().length ==
// //                 _cConfirmPassword.text.trim().length &&
// //             _cPassword.text.trim() == _cConfirmPassword
// //             _cPhoneNumber.text.isNotEmpty &&
// //             _cPhoneNumber.text.trim().length ==
// //                 global.appInfo!.phoneNumberLength &&
// //             _cPassword.text.isNotEmpty &&
// //             _imageSelected &&
// //             (lat !=null || lng !=null) &&
// // isAgreed&&



// //             _cPassword.text.trim().length >= 8 &&
// //             _cConfirmPassword.text.isNotEmpty &&
// //             _cPassword.text.trim().length ==
// //                 _cConfirmPassword.text.trim().length &&
// //             _cPassword.text.trim() == _cConfirmPassword.text.trim() &&
// //             _selectedCity != null &&
// //             _selectedCity!.cityId != null) {
       
// //           CurrentUser _user = new CurrentUser();

// //           _user.name = _cName.text.trim();
// //           _user.email = _cEmail.text.trim();
// //           final String replaced = _cPhone.text
// //               .trim()
// //               .replaceFirst('0', global.appInfo!.countryCode!.toString());

// //           _user.userPhone =
// //               //  replaced.toString().trim();
// //               _cPhoneNumber.text.trim();  Get.back();

// //           _user.password = _cPassword.text.trim();

// //           //USEr IMAGE
// //           _user.userImage =
// //               global.selectedImage != null ? global.selectedImage : null;

// //            if (_user.userImage != null) {
// //                 _user.updateImageFile(_user.userImage!);
// //            }
              
      




// //           // _user.referralCode = _cReferr':al.text.trim();
// //           _user.userCity = _selectedCity!.cityId;
// //           // user.referralCode= global.appInfo.
// //           _user.userArea = 
// //           _selectedSociety!.societyId;
// //           _user.address = addressController.text.trim();
// //           _user.lat = lat;
// //           _user.lng = lng;
// //           // _user.facebookId = user!.facebookId;
// //           ///
// //           ///
// //             showOnlyLoaderDialog();
// //           await apiHelper.signUp(_user).then((result) {

// //             // log('RESULT'+ result.data.toString());
// //             if (result != null) {
// //               if (result.status == "1") {
// //                 hideLoader();
// //                 log('GOIN WITH NUMBER' + _cPhoneNumber.text);

             
// //                 // var mapper = ToCurrnerUser();

// //                 global.currentUser =result.data;
                
// //                 // var mapper = ToCurrnerUser();
// //                 global.userProfileController.currentUser = result.data;
// //               try {
// //                   global.sp!.setString(
// //                       'currentUser', json.encode(result.data.toJson()));
// //               } catch (e) {
// //                 log(e.toString());
// //               }
// // log('Sign up Done');




// //                 Get.to(() => OtpVerificationScreen(
// //                       a: widget.analytics,
// //                       o: widget.observer,
// //                       phoneNumber: _cPhoneNumber.text.trim(),
// //                       referalCode: _cReferral.text.trim(),
// //                     ));
// //               } else {
// //                 hideLoader();
// //           String?  valiationMessage;
// // var stringSrc = jsonEncode(result.data);
// // Map  map =  jsonDecode(stringSrc);

// //       if (map.containsKey('errors')) {
// //         valiationMessage = 
// //         map['errors'].containsKey('user_phone')?
// //          'هذا الرقم مستخدم بالفعل , استخدم رقم اخر': 'Login Failed , try again';
// //       }

// //       log('///');

// //                 showSnackBar(
// //                     key: _scaffoldKey,
// //                     snackBarMessage:valiationMessage??result.message.toString());
// //               }
// //             }
// //           });

// //           // .then((result) async {
// //           //   if (result != null) {

// //           //     if (result.status == "1") {
// //           //       global.currentUser = result.data;
// //           //       global.userProfileController.currentUser = global.currentUser;

// //           //       if (global.appInfo!.firebase != 'off') {
// //           //         // if firebase is enabled then only we need to send OTP through firebase.
// //           //         await sendOTP(_cPhoneNumber.text.trim());
// //           //       } else {
// //           //         hideLoader();
// //           //         Get.to(() => OtpVerificationScreen(
// //           //               a: widget.analytics,
// //           //               o: widget.observer,
// //           //               phoneNumber: _cPhoneNumber.text.trim(),
// //           //               referalCode: _cReferral.text.trim(),
// //           //             ));
// //           //       }
// //           //     } else {
// //           //       hideLoader();
// //           //       showSnackBar(
// //           //           key: _scaffoldKey,
// //           //           snackBarMessage: result.message.toString());
// //           //     }
// //           //   }e
// //           // });

// //         } else if (_cName.text.isEmpty) {
// //           showSnackBar(
// //               key: _scaffoldKey,
// //               snackBarMessage:
// //                   '${AppLocalizations.of(context)!.txt_please_enter_your_name}');
// //         }
// //         // else if (_cEmail.text.isEmpty) {
// //         //   showSnackBar(
// //         //       key: _scaffoldKey,
// //         //       snackBarMessage:
// //         //           '${AppLocalizations.of(context)!.txt_please_enter_your_email}');
// //         // }
// //         // else if (_cEmail.text.isNotEmpty &&
// //         //     !EmailValidator.validate(_cEmail.etext)) {
// //         //   showSnackBar(
// //         //       key: _scaffoldKey,
// //         //       snackBarMessage:
// //         //           '${AppLocalizations.of(context)!.txt_please_enter_your_valid_email}');
// //         // }

// //         else if (_cPhoneNumber.text.isEmpty ||
// //             (_cPhone.text.isNotEmpty &&
// //                 _cPhone.text.trim().length !=
// //                     global.appInfo!.phoneNumberLength)) {
// //           showSnackBar(
// //               key: _scaffoldKey,
// //               snackBarMessage:
// //                   '${AppLocalizations.of(context)!.txt_please_enter_valid_mobile_number}');
// //         } else if (_cPassword.text.isEmpty) {
// //           showSnackBar(
// //               key: _scaffoldKey,
// //               snackBarMessage:
// //                   '${AppLocalizations.of(context)!.txt_please_enter_your_password}');
// //         } else if (_cPassword.text.isNotEmpty &&
// //             _cPassword.text.trim().length < 8) {
// //           showSnackBar(
// //               key: _scaffoldKey,
// //               snackBarMessage:
// //                   '${AppLocalizations.of(context)!.txt_password_should_be_of_minimum_8_character}');
// //         } else if (_cConfirmPassword.text.isEmpty &&
// //             _cPassword.text.isNotEmpty) {
// //           showSnackBar(
// //               key: _scaffoldKey,
// //               snackBarMessage:
// //                   '${AppLocalizations.of(context)!.txt_please_reEnter_your_password}');
// //         } else if (_cConfirmPassword.text.isNotEmpty &&
// //             _cPassword.text.isNotEmpty &&
// //             (_cConfirmPassword.text.trim() != _cPassword.text.trim())) {
// //           showSnackBar(
// //               key: _scaffoldKey,
// //               snackBarMessage:
// //                   '${AppLocalizations.of(context)!.txt_password_do_not_match}');
// //         } else if (_selectedCity!.cityId == null) {
// //           showSnackBar(
// //               key: _scaffoldKey,
// //               snackBarMessage:
// //                   '${AppLocalizations.of(context)!.txt_select_city}');
// //         }
// //         else if (!_imageSelected) {
// //           showSnackBar(
// //               key: _scaffoldKey,
// //               snackBarMessage:
// //                   'الرجاء ادخال الصورة');
// //         }

// //         else if( (lat ==null || lng ==null)){
// //           showSnackBar(
// //               key: _scaffoldKey,
// //               snackBarMessage:
// //               'الرجاء اختيار الموقع');
// //         }
// //          else if (isAgreed==false) {
// //           showSnackBar(
// //               key: _scaffoldKey, snackBarMessage: 'الرجاء  الموافقة على الشروط والاحكام');
// //         }
// //       } else {
// //         showNetworkErrorSnackBar(_scaffoldKey);
// //       }
//     } catch (e) {
//       print("Exception - signup_screen.dart - _onSignUp():" + e.toString());
//     }
//   }


  GlobalKey<ScaffoldState>? _scaffoldKey;





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
      // log('NO EXCEPTION 2');
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

  _showCupertinoModalSheet() {
    try {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: Text('Events'),
          actions: [
            CupertinoActionSheetAction(
              child: Text(
                tr('camera'),
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              onPressed: () async {
                Navigator.pop(context);

                tImage = await openCamera();

if (this.accountType=='user') {
  _uSelectedImage=tImage;

} else {
  _pSelectedImage=tImage;
}

                // global.selectedImage = tImage!.path;
                // widget.imageSelected!(true);



                setState(() {});
              },
            ),
            CupertinoActionSheetAction(
              child: Text(
                tr('gallery'),
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              onPressed: () async {
                Navigator.pop(context);

                tImage = await selectImageFromGallery();
              if (this.accountType=='user') {
  _uSelectedImage=tImage;

} else {
  _pSelectedImage=tImage;
}
                setState(() {});
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

















}
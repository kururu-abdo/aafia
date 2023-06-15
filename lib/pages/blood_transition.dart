import 'dart:developer';

import 'package:aafia/base/base.dart';
import 'package:aafia/data/models/base/page_mode.dart';
import 'package:aafia/data/models/response/blood_transfre_request.dart';
import 'package:aafia/data/models/response/hospital_model.dart';
import 'package:aafia/utils/app_constants.dart';
import 'package:aafia/utils/colors.dart';
import 'package:aafia/utils/conversions.dart';
import 'package:aafia/utils/validations.dart';
import 'package:aafia/widgets/custom_dropdown.dart';
import 'package:aafia/widgets/dropdown_field.dart';
import 'package:aafia/widgets/my_Button.dart';
import 'package:aafia/widgets/my_textfield.dart';
import 'package:aafia/widgets/phone_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';

import '../widgets/toastfile.dart';
import '../data/models/response/blood_tranfer_pagination.dart' as blood;

class AddBloodTransition extends BaseRoute {
  final String?  operationType;
  final PageMode? pageMode;
  final blood.Data?  data;
   AddBloodTransition(this.operationType, { Key? key
   ,this.pageMode=PageMode.NEW ,
   this.data
   
    }) : super(r: 'AddBloodTransition');

  @override
  _AddBloodTransitionState createState() => _AddBloodTransitionState(operationType , this.pageMode ,
  
  this.data
  
  );
}

class _AddBloodTransitionState extends BaseRouteState {
    final PageMode? pageMode;
  final   blood.Data?  data;

final String?  requestType;
TextEditingController _locationController=TextEditingController();

TextEditingController _bottleController=TextEditingController();
FocusNode _bottleFocus=FocusNode();


TextEditingController _hospitalNameController=TextEditingController();
FocusNode _hospitalNameFocus=FocusNode();


TextEditingController _phoneController=TextEditingController();
FocusNode _phoneFocus=FocusNode();


var urgentValue=0;
var nonUrgentValue=1;
var groupValue=5;

DateTime? _requestDate;
List<String> _bloodTypes =[
  
'O-' ,'O+' ,'B+' ,'A+' ,'A-' ,'AB-' ,'AB+'
];
final List<Map> operationTypeDetials =[
  {
    'key':'urgent',
    'value-en':'Urgent',
    'value-ar':"طارئة"
  },
  {
    'key':'not-urgent',
    'value-en':'Not Urgent',
    'value-ar':"غير طارئة"
  },
];


var _operationType;

// var _operationTypeDetial;



final List<Map> operationTypes =[
  {
    'key':'volunteer',
    'value-en':'Volunteer',
    'value-ar':"تتبرع"
  },
  {
    'key':'receiver',
    'value-en':'Receiver',
    'value-ar':"تلقي"
  },
];
var _type;
final List<Map> operationTypeDetails =[
  {
    'key':'operation',
    'value-en':'Operation',
    'value-ar':"عملية"
  },
  {
    'key':'birth',
    'value-en':'Birth',
    'value-ar':"ولادة"
  },

  {
    'key':'accident',
    'value-en':'Accident',
    'value-ar':"حادث"
  },
];
var _operationTypeDetail;


final List<Map> transferTypes =[
  {
    'key':'volunteer',
    'value-en':'Volunteer',
    'value-ar':"تبرع بالدم"
  },
  {
    'key':'receiver',
    'value-en':'Receiver',
    'value-ar':"تلقي دم"
  },

  
];
var transferType;

















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


TextEditingController _dateController =TextEditingController();

TextEditingController _followUpPhoneController =TextEditingController();

double? distance;
double? lat;
double? lng;

  GlobalKey<ScaffoldState>? _scaffoldKey;

String? _bloodType;

  _AddBloodTransitionState(this.requestType ,
  
  
  this.pageMode , this.data
  );

List<HospitalModel> _hopsitals=[];
HospitalModel?  _hospitalModel;

_getHospitals()async{
  
  try {
    apiHelper.getHospitals()
    .then((result) {
if (result!=null) {

  
  // if (result.data.length>0) {
    _hopsitals=result.data;
    setState(() {
      
    });

log(_hopsitals.length.toString());

  
  // }
}
    });
  } catch (e) {
    log(e.toString());
  }
}



_init()async{
  try {
    
await _getHospitals();
  if (pageMode==PageMode.EDIT) {
      
transferType=

transferTypes.firstWhere((element) => element['key']==this.data!.transfareType)
;


_bottleController.text=this.data!.bottelsCount.toString();
_bloodType=this.data!.bloodType;
_hospitalModel = _hopsitals.firstWhere((element) => element.id==this.data!.hospitalId!);

// ..distance=0.0
// hospital_id=_hospitalModel!.id.toString()
//_hospitalNameController.text.trim()
// ..transfare_type=requestType
_dateController.text=this.data!.createdAt.toString();

// ..operation_type=
_operationType=operationTypeDetials.firstWhere((element) => element['key']==this.data!.operationType);

_operationTypeDetail=operationTypeDetails.firstWhere((element) => element['key']==this.data!.operationTypeDetail);
lat=double.parse(this.data!.requestLatitude!);
lng=double.parse(this.data!.requestLongitude!);
_followUpPhoneController.text=this.data!.followUpPhone;

      //init controllers
  
  
  
    }
  } catch (e) {
  }
}
FToast? fToast;

@override
void initState() { 
  super.initState();
   fToast = FToast();
    // if you want to use context from globally instead of content we need to pass navigatorKey.currentContext!
    fToast!.init(context);
    _init();

  
}
_onBloodRequest()async{
  try {
    if (_uFormKey.currentState!.validate()) {
      
   if(lat==null || lng==null){
ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Select Location'),
          backgroundColor: Colors.red,
        ));
   }

   else if (_requestDate==null){
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('please Select Request date'),
          backgroundColor: Colors.red,
        ));
   }
else if (groupValue!=0 && groupValue!=1  ){
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('please Select Operation type'),
          backgroundColor: Colors.red,
        ));
   }
else if (_bloodType==null  ){
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('please Select Blood type'),
          backgroundColor: Colors.red,
        ));
   }
   else if (_operationTypeDetail==null  ){
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('please Select Operation type'),
          backgroundColor: Colors.red,
        ));
   }
   else if (_hospitalModel==null  ){
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('please Select Hospital'),
          backgroundColor: Colors.red,
        ));
   }
else {
if(groupValue==0){
  _operationType='urgent';
}else{
    _operationType='not-urgent';

}
NewBloodTransferRquest newBloodTransferRquest =
NewBloodTransferRquest() 
..bottels_count=int.parse(_bottleController.text.trim())
..blood_type=_bloodType
..distance=0.0
..hospital_id=_hospitalModel!.id.toString()
//_hospitalNameController.text.trim()
..transfare_type=requestType
..transfare_time=_dateController.text.trim()
..operation_type=_operationType.trim()
..operation_type_detail=_operationTypeDetail['key'].toString().trim()
..request_latitude=lat
..request_longitude=lng
..follow_up_phone=_followUpPhoneController.text.trim()

;

showOnlyLoaderDialog();

apiHelper.createBloodTransferRequest(newBloodTransferRquest)
.then((result) {
hideLoader();


if (result!=null) {
  if (result.data!=null) {
    Get.back();

    showTopToast('تم ارسال الطلب بنجاح', context,fToast!,
isSuccess: true
);
  }else{
    showSnackBar(
                    key: _scaffoldKey,
                    
                    snackBarMessage:
                    result.message.toString() ,isSuccess: false);
  }
} else {

showSnackBar(
                    key: _scaffoldKey,
                    
                    snackBarMessage:
                    'request not completed , try again' ,isSuccess: false);
}

});

}

    }
  } catch (e) {
  }
}










_onBloodUpdateRequest()async{
  try {
    if (_uFormKey.currentState!.validate()) {
      
   if(lat==null || lng==null){
ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Select Location'),
          backgroundColor: Colors.red,
        ));
   }

   else if (_requestDate==null){
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('please Select Request date'),
          backgroundColor: Colors.red,
        ));
   }
else if (groupValue!=0 && groupValue!=1  ){
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('please Select Operation type'),
          backgroundColor: Colors.red,
        ));
   }
else if (_bloodType==null  ){
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('please Select Blood type'),
          backgroundColor: Colors.red,
        ));
   }
   else if (_operationTypeDetail==null  ){
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('please Select Operation type'),
          backgroundColor: Colors.red,
        ));
   }
   else if (_hospitalModel==null  ){
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('please Select Hospital'),
          backgroundColor: Colors.red,
        ));
   }
else {
if(groupValue==0){
  _operationType='urgent';
}else{
    _operationType='not-urgent';

}
NewBloodTransferRquest newBloodTransferRquest =
NewBloodTransferRquest() 
..bottels_count=int.parse(_bottleController.text.trim())
..blood_type=_bloodType
..distance=0.0
..hospital_id=_hospitalModel!.id.toString()
//_hospitalNameController.text.trim()
..transfare_type=transferType['key'].toString().trim()
..transfare_time=_dateController.text.trim()
..operation_type=_operationType.trim()
..operation_type_detail=_operationTypeDetail['key'].toString().trim()
..request_latitude=lat
..request_longitude=lng
..follow_up_phone=_followUpPhoneController.text.trim()

;

showOnlyLoaderDialog();

apiHelper.updateBloodTransferRequest(
  
  data!.id.toString(),
  newBloodTransferRquest)
.then((result) {
hideLoader();


if (result!=null) {
  if (result.data!=null) {
    Get.back();

    showTopToast('تم تحديث الطلب بنجاح', context,fToast!,
isSuccess: true
);
  }else{
    showSnackBar(
                    key: _scaffoldKey,
                    
                    snackBarMessage:
                    result.message.toString() ,isSuccess: false);
  }
} else {

showSnackBar(
                    key: _scaffoldKey,
                    
                    snackBarMessage:
                    'request not completed , try again' ,isSuccess: false);
}

});

}

    }
  } catch (e) {
  }
}








var  _uFormKey= GlobalKey<FormState>();







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,backgroundColor: Colors.transparent ,

leading: IconButton(onPressed: (){
  Get.back();
}, icon: Icon(
  Icons.arrow_back_ios ,color: Colors.black,
)),
centerTitle: true,
title: Text(tr('blood_tranfusion_request') ,style: TextStyle(
  color: Theme.of(context).primaryColor
),),


      ),

      body: Builder(
        builder: (context) {
          
          if (pageMode==PageMode.NEW) {
            
          return Form(
            key: _uFormKey,
            child:  SingleChildScrollView(
            // physics: const NeverScrollableScrollPhysics(),
            padding: MediaQuery.of(context).viewInsets.copyWith(
              left: 30,right: 30,top: 29
            )  ,
              child:  ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
                minHeight: MediaQuery.of(context).size.height,
                // maxHeight: 1009
              ),
                child: IntrinsicHeight(
                  child: Column(children: [
                      
                    Image.asset('assets/images/png/Request a blood transfusion.png',
                    
                    
                    width: 247,height: 196,
                    ) ,
                    SizedBox(height: 12,),
                      
                  AppDropdownInput<String>(  prefix: ImageIcon(AssetImage('assets/images/png/blood3.png'),
    color: Theme.of(context).colorScheme.error,
    ),
                    options: _bloodTypes,
                    hintText: 'Blood type',
                    value: _bloodType,
                    getLabel: (str)=>str,
                    onChanged: (str){
                  setState(() {
                    
                    _bloodType =str!;
                  });
                    },
                  
                  ), 
                      
                      
                      BoxTextField( prefix: ImageIcon(AssetImage('assets/images/png/bottle3.png'),
  color: Theme.of(context).colorScheme.error,
    ),
                      label: tr('bottle_count'),
                      validator: validateRequiredField,
                      keyboardType: TextInputType.number,
                      controller: _bottleController,
                    
                      ),
                      
                         AppDropdownInput<HospitalModel>( prefix:ImageIcon(AssetImage('assets/images/png/hospital3.png'),
    color: Theme.of(context).primaryColor,
    ),
                    options: _hopsitals,
                    hintText: tr('donat_hospital'),
                    value: _hospitalModel,
                    getLabel: (str)=>str.name!,
                    onChanged: (str){
                  setState(() {
                    
                    _hospitalModel =str!;
                  });
                    },
                  
                  )
                      
                      
                      
                      ,

                      
                      
                      PhoneTextField(
                  //        prefix:Icon(Icons.call,
                  // color: Theme.of(context).primaryColor,
                  //     ),
                      label: tr('phone'),
                      validator: validatePhone,
                      controller: _followUpPhoneController,
                      ),
  GestureDetector(
    onTap: ()async{


  // var date =await _selectDate(context);

            DatePicker.showDateTimePicker(context,
                                  showTitleActions: true,
                                 locale:  LocaleType.en ,
                                  minTime: DateTime.now(),
                                  maxTime: DateTime(2050, 6, 7), 
                                
                                  
                                   onChanged: (date) {
                                print('change $date');
                              }, onConfirm: (date) {
                               if (date!=null) {
    
  setState(() {
    _requestDate =date;
    _dateController.text =requestTimeFormat(_requestDate!);
  });
 }
                              }, currentTime: DateTime.now(), 
                          
                              );




 
    },
    child:   BoxTextField(
           prefix:ImageIcon(AssetImage('assets/images/png/calendar3.png'),
    color: Theme.of(context).primaryColor,
    ),
          label:tr('transfer_date'),
    enabled: false,
    controller: _dateController,
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
  
  
            

              // result.name!;
              setState(() {
                lat =result.latLng!.latitude;
                lng = result.latLng!.longitude;
              });

List<Placemark> placemarks = await placemarkFromCoordinates(lat!, lng!);


                        _locationController.text =  "${placemarks.first.country} ,  ${placemarks.first.locality}  ,   ${placemarks.first.name}";


    },
    child:   BoxTextField(label: tr('location'),
    
    controller: _locationController,
    enabled: false,
    prefix:ImageIcon(AssetImage('assets/images/png/mapMarker3.png'),
    color: Theme.of(context).primaryColor,
    
    
    ),
    
    ),
  ),
  
  
                      Row(
                  children: [
                    Text(tr('request_status'), style: TextStyle(
                      fontSize: 15,fontWeight: FontWeight.w400
                    ),) ,
                    SizedBox(width: 35,),
                    Expanded(
                  flex: 1,
                  child: 
                  
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [


                      GestureDetector(
                        onTap: (){
                          if ( groupValue !=urgentValue) {
                            groupValue=urgentValue;
                          }else{
                             groupValue=-1;
                          }

                          setState(() {
                            
                          });
                             
                        },
                        child: Container(
                      width: 24,height: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color:groupValue==urgentValue?Theme.of(context).primaryColor: AppColors.ONBACKGROUND
                      ),
                      
                      child: Center(
                        child: groupValue==urgentValue?Icon(Icons.check,color: Colors.white,):SizedBox.shrink(),
                      )
                        ),
                      ),
                      
                      

 SizedBox(width: 6,),

                      // Checkbox(value: groupValue==urgentValue, onChanged: (value){


                      //   if (value!) {
                      //     groupValue=urgentValue;
                      //     setState(() {
                            
                      //     });
                      //   }
                      // },) ,
                      Text(tr('emergent')  , style: TextStyle(
                      fontSize: 14,fontWeight: FontWeight.w400
                    ),) ,
                    ],
                  ) ,
                  
                  
                  ) ,
                      
                   Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                    
                    
                      GestureDetector(
                        onTap: (){
                          if ( groupValue !=nonUrgentValue) {
                            groupValue=nonUrgentValue;
                          }else{
                             groupValue=-1;
                          }

                          setState(() {
                            
                          });
                             
                        },
                        child: Container(
                      width: 24,height: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color:groupValue==nonUrgentValue?Theme.of(context).primaryColor: AppColors.ONBACKGROUND
                      ),
                      
                      child: Center(
                        child: groupValue==nonUrgentValue?Icon(Icons.check,color: Colors.white,):SizedBox.shrink(),
                      )
                        ),
                      ),
                      
                      
                      // Checkbox(value: groupValue==nonUrgentValue, 
                      // onChanged: (value){

                      //     if (value!) {
                      //     groupValue=nonUrgentValue;
                      //     setState(() {
                            
                      //     });
                      //   }
                      // },) ,
                 SizedBox(width: 6,),     
                      Text(tr('no-emergent')  , style: TextStyle(
                      fontSize: 14,fontWeight: FontWeight.w400
                    ),) ,
                    ],
                  ) ,
                  
                  
                  )
                      
                  ],
                      ) ,
                      
                       SizedBox(height: 18,),
                          AppDropdownInput<Map>(
                    options: operationTypeDetails,
                    hintText: tr('operation_details'),
                    value: _operationTypeDetail,
                    getLabel: (str){

                      if (context.locale==Locale('ar')) {
                        return str['value-ar'];
                      }else{
                        return str['value-en'];
                      }
                    },
                    onChanged: (str){
                  setState(() {
                    
                    _operationTypeDetail =str;
                  });
                    },
                  
                  ), 
                     
                     
                     
                     SizedBox(height: 30,),








                      
                      MyButton(
                  title: tr('add_btn'),
                  color: Theme.of(context).primaryColor,
                  onTap: ()async{
                  await _onBloodRequest();
                  },
                      )
                  ],),
                ),
              ),
            ),
          );
      
          } else {



          return Form(
            key: _uFormKey,
            child:  SingleChildScrollView(
            // physics: const NeverScrollableScrollPhysics(),
            padding: MediaQuery.of(context).viewInsets.copyWith(
              left: 30,right: 30,top: 29
            )  ,
              child:  ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
                minHeight: MediaQuery.of(context).size.height,
                // maxHeight: 1009
              ),
                child: IntrinsicHeight(
                  child: Column(children: [
                      
                    Image.asset('assets/images/png/Request a blood transfusion.png',
                    
                    
                    width: 247,height: 196,
                    ) ,
                    SizedBox(height: 12,),
                      
                  AppDropdownInput<String>(  prefix: ImageIcon(AssetImage('assets/images/png/blood3.png'),
    color: Theme.of(context).colorScheme.error,
    ),
                    options: _bloodTypes,
                    hintText: 'Blood type',
                    value: _bloodType,
                    getLabel: (str)=>str,
                    onChanged: (str){
                  setState(() {
                    
                    _bloodType =str!;
                  });
                    },
                  
                  ), 
                      
                                   AppDropdownInput<Map>(  prefix: 
                                   ImageIcon(AssetImage('assets/images/png/blood3.png'),
    color: Theme.of(context).colorScheme.error,
    ),
                    options: transferTypes,
                    hintText: 'Transfer type',
                    value: transferType,
                    getLabel: (str){
                       if (context.locale==Locale('ar')) {
                        return str['value-ar'];
                      }else{
                        return str['value-en'];
                      }
                    },
                    onChanged: (str){
                  setState(() {
                    
                    transferType =str!;
                  });
                    },
                  
                  ),  
                      BoxTextField( prefix: ImageIcon(AssetImage('assets/images/png/bottle3.png'),
  color: Theme.of(context).colorScheme.error,
    ),
                      label: tr('bottle_count'),
                      validator: validateRequiredField,
                      keyboardType: TextInputType.number,
                      controller: _bottleController,
                    
                      ),
                      
                         AppDropdownInput<HospitalModel>( prefix:ImageIcon(AssetImage('assets/images/png/hospital3.png'),
    color: Theme.of(context).primaryColor,
    ),
                    options: _hopsitals,
                    hintText: tr('donat_hospital'),
                    value: _hospitalModel,
                    getLabel: (str)=>str.name!,
                    onChanged: (str){
                  setState(() {
                    
                    _hospitalModel =str!;
                  });
                    },
                  
                  )
                      
                      
                      
                      ,
                      
                      PhoneTextField(
                      label: tr('phone'),
                      validator: validatePhone,
                      controller: _followUpPhoneController,
                      ),
                     
  GestureDetector(
    onTap: ()async{


  // var date =await _selectDate(context);

            DatePicker.showDateTimePicker(context,   locale:  LocaleType.en ,
                                  showTitleActions: true,
                                  minTime: DateTime.now(),
                                  maxTime: DateTime(2050, 6, 7), onChanged: (date) {
                                print('change $date');
                              }, onConfirm: (date) {
                               if (date!=null) {
    
  setState(() {
    _requestDate =date;
    _dateController.text =requestTimeFormat(_requestDate!);
  });
 }
                              }, currentTime: DateTime.now(),                                
                               

                              );




 
    },
    child:   BoxTextField(
           prefix:ImageIcon(AssetImage('assets/images/png/calendar3.png'),
    color: Theme.of(context).primaryColor,
    ),
          label:tr('transfer_date'),
    enabled: false,
    controller: _dateController,
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
  
  
            

              // result.name!;
              setState(() {
                lat =result.latLng!.latitude;
                lng = result.latLng!.longitude;
              });

List<Placemark> placemarks = await placemarkFromCoordinates(lat!, lng!);


                        _locationController.text =  "${placemarks.first.country} ,  ${placemarks.first.locality}  ,   ${placemarks.first.name}";


    },
    child:   BoxTextField(label: tr('location'),
    
    controller: _locationController,
    enabled: false,
    prefix:ImageIcon(AssetImage('assets/images/png/mapMarker3.png'),
    color: Theme.of(context).primaryColor,
    
    
    ),
    
    ),
  ),
  
  
                      Row(
                  children: [
                    Text(tr('request_status'), style: TextStyle(
                      fontSize: 15,fontWeight: FontWeight.w400
                    ),) ,
                    SizedBox(width: 35,),
                    Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [


                      GestureDetector(
                        onTap: (){
                          if ( groupValue !=urgentValue) {
                            groupValue=urgentValue;
                          }else{
                             groupValue=-1;
                          }

                          setState(() {
                            
                          });
                             
                        },
                        child: Container(
                      width: 24,height: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color:groupValue==urgentValue?Theme.of(context).primaryColor: AppColors.ONBACKGROUND
                      ),
                      
                      child: Center(
                        child: groupValue==urgentValue?Icon(Icons.check,color: Colors.white,):SizedBox.shrink(),
                      )
                        ),
                      ),
                      
                      

 SizedBox(width: 6,),

                      // Checkbox(value: groupValue==urgentValue, onChanged: (value){


                      //   if (value!) {
                      //     groupValue=urgentValue;
                      //     setState(() {
                            
                      //     });
                      //   }
                      // },) ,
                      Text(tr('emergent')  , style: TextStyle(
                      fontSize: 14,fontWeight: FontWeight.w400
                    ),) ,
                    ],
                  ) ,
                  
                  
                  ) ,
                      
                   Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      GestureDetector(
                        onTap: (){
                          if ( groupValue !=nonUrgentValue) {
                            groupValue=nonUrgentValue;
                          }else{
                             groupValue=-1;
                          }

                          setState(() {
                            
                          });
                             
                        },
                        child: Container(
                      width: 24,height: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color:groupValue==nonUrgentValue?Theme.of(context).primaryColor: AppColors.ONBACKGROUND
                      ),
                      
                      child: Center(
                        child: groupValue==nonUrgentValue?Icon(Icons.check,color: Colors.white,):SizedBox.shrink(),
                      )
                        ),
                      ),
                      
                      
                      // Checkbox(value: groupValue==nonUrgentValue, 
                      // onChanged: (value){

                      //     if (value!) {
                      //     groupValue=nonUrgentValue;
                      //     setState(() {
                            
                      //     });
                      //   }
                      // },) ,
                 SizedBox(width: 6,),     
                      Text(tr('no-emergent')  , style: TextStyle(
                      fontSize: 14,fontWeight: FontWeight.w400
                    ),) ,
                    ],
                  ) ,
                  
                  
                  )
                      
                  ],
                      ) ,
                      
                       SizedBox(height: 18,),
                          AppDropdownInput<Map>(
                    options: operationTypeDetails,
                    hintText: tr('operation_details'),
                    value: _operationTypeDetail,
                    getLabel: (str){

                      if (context.locale==Locale('ar')) {
                        return str['value-ar'];
                      }else{
                        return str['value-en'];
                      }
                    },
                    onChanged: (str){
                  setState(() {
                    
                    _operationTypeDetail =str;
                  });
                    },
                  
                  ), 
                     
                     
                     
                     SizedBox(height: 30,),








                      
                      MyButton(
                  title: tr('save_edits'),
                  color: Theme.of(context).primaryColor,
                  onTap: ()async{
                  await _onBloodUpdateRequest();
                  },
                      )
                  ],),
                ),
              ),
            ),
          );
      
          }
          
          
      
      
        }
      ),
    );
  }
}
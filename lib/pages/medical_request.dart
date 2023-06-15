import 'dart:developer';
import 'dart:io';

import 'package:aafia/base/base.dart';
import 'package:aafia/data/models/base/page_mode.dart';
import 'package:aafia/data/models/base/success_bottomsheet.dart';
import 'package:aafia/data/models/response/new_drug_request.dart';
import 'package:aafia/utils/app_constants.dart';
import 'package:aafia/utils/colors.dart';
import 'package:aafia/utils/validations.dart';
import 'package:aafia/widgets/custom_dropdown.dart';
import 'package:aafia/utils/global.dart' as global;
import 'package:aafia/widgets/dropdown_field.dart';
import 'package:aafia/widgets/my_Button.dart';
import 'package:aafia/widgets/my_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';

import '../data/models/response/drugResponsePagination.dart' as drug;


class MedicalRequestPage extends BaseRoute {
  final PageMode? pageMode ;
  final  drug.Data?  drugData; 
   MedicalRequestPage(
     {
       this.pageMode=PageMode.NEW , this.drugData
     }

   ):super(r: 'MedicineRequest');

  @override
  _MedicalRequestPageState createState() => _MedicalRequestPageState(pageMode, this.drugData);
}

class _MedicalRequestPageState extends BaseRouteState {
  final PageMode? pageMode ;
    final  drug.Data?  drugData; 

String?  Function(String?)?  _insuranceValidator;

bool _haveHealthInsurance=false;
  GlobalKey<ScaffoldState>? _scaffoldKey;

bool isLoading=false;
List<String> _areas =[
  
'khartoum' ,'omdurman','bahri'
];

List<Map> _areas2 =[
  {
    'key':'khartoum',
    'value-en':"Khartoum",
    'value-ar':"الخرطوم"
  }
  ,
   {
    'key':'omdurman',
    'value-en':"Omdurman",
    'value-ar':"ام درمان"
  }
  ,
   {
    'key':'bahri',
    'value-en':"Bahri",
    'value-ar':"بحري"
  }
//  ,'omdurman','bahri'
];
Map? _area2;

String? _area;
double?  lat;
double? lng;
File? _prescriptionImage;
File? _insuraceImage;

var  _pFormKey= GlobalKey<FormState>();



var _pLocationCOntroller=TextEditingController();

var _drugNameController=TextEditingController();

  _MedicalRequestPageState(this.pageMode ,   this.drugData
);



var _insuranceCompanyController=TextEditingController();


_onDrugRequest(BuildContext context)async{
  try {
    if(lat==null || lng==null){
ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(tr('please_select_location')),
          backgroundColor: Colors.red,
        ));

    }
else  if(_haveHealthInsurance
      && _insuraceImage==null){
ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(tr('please_upload_insurance_image')),
          backgroundColor: Colors.red,
        ));
      

}
else if(_prescriptionImage==null){
ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(tr('please_upload_prescription_image')),
          backgroundColor: Colors.red,
        ));
}else {

NewDrugRequest  newDrugRequest =NewDrugRequest()
..drug_name=_drugNameController.text.trim()
..image=_prescriptionImage!.path
..insuranceImage=_haveHealthInsurance?_insuraceImage!.path:''
..insuranceCompany=_haveHealthInsurance?_insuranceCompanyController.text.trim():''
..latitude=lat
..longitude=lng
..distance=904545;
  showOnlyLoaderDialog();


await apiHelper.sendDrugRequest(newDrugRequest ).then((result) {
hideLoader();

  if (result.data != null) { 

    log('HERER');
try {
scaffoldState.currentState!.  showBottomSheet(

 (context){

return DrugRquestSuccessBottomSheet();

},

shape: RoundedRectangleBorder(
   borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(25),
                    topStart: Radius.circular(25),
                  )
),


);

} catch (e) {log(e.toString());
}
  }else {


    showSnackBar(
                    key: _scaffoldKey,
                    snackBarMessage:
                    result.message.toString());
  }









}
);};








  } catch (e) {log(e.toString());
  }
}




_onUpdateDrugRequest(BuildContext context)async{
  try {
     if(lat==null || lng==null){
ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(tr('please_select_location')),
          backgroundColor: Colors.red,
        ));

    }
else  if(_haveHealthInsurance
     && _insuraceImage==null && initialInsuranceImage==null){
ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(tr('please_upload_insurance_image')),
          backgroundColor: Colors.red,
        ));
      
}
else if(_prescriptionImage==null  && initialDrugImage==null){
ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(tr('please_upload_prescription_image')),
          backgroundColor: Colors.red,
        ));
}


else {

NewDrugRequest  newDrugRequest =NewDrugRequest()
..drug_name=_drugNameController.text.trim()
..image=

_prescriptionImage!=null?
_prescriptionImage!.path:null
..insuranceCompany=_insuranceCompanyController.text.trim()
..insuranceImage=

_insuraceImage!=null?
_insuraceImage!.path:null
..latitude=lat
..longitude=lng
..distance=904545;

  showOnlyLoaderDialog();


await apiHelper.updateDrugRequest(drugData!.id.toString(), newDrugRequest.drug_name!.trim(), newDrugRequest.latitude, newDrugRequest.longitude, 



newDrugRequest.image
// image
 , newDrugRequest.insuranceCompany   ,
 newDrugRequest.insuranceImage


).then((result) {
hideLoader();

  if (result.data != null) { 

    log('HERER');
try {
 showSnackBar(
                    key: _scaffoldKey,
                    snackBarMessage:
                    tr('updated_successfully') ,
                    
                    isSuccess: true
                    );
                    Get.back();

// scaffoldState.currentState!.  showBottomSheet(

//  (context){

// return DrugRquestSuccessBottomSheet();

// },

// shape: RoundedRectangleBorder(
//    borderRadius: BorderRadiusDirectional.only(
//                     topEnd: Radius.circular(25),
//                     topStart: Radius.circular(25),
//                   )
// ),


// );

} catch (e) {log(e.toString());
}
  }else {


    showSnackBar(
                    key: _scaffoldKey,
                    snackBarMessage:
                    result.message.toString());
  }









}
);};








  } catch (e) {

    showSnackBar(
                    key: _scaffoldKey,
                    snackBarMessage:
                    e.toString());
  }
}


final scaffoldState = GlobalKey<ScaffoldState>();


String? initialDrugImage;
String? initialInsuranceImage;

@override
  void initState() {
    // TODO: implement initState
    super.initState();

   

Future.microtask(()async {
 if (pageMode==PageMode.EDIT) {
await
_initData();

 }
});
    
  }

_initData()async{
     _drugNameController.text=drugData!.drugName!;
initialDrugImage= drugData!.image!;

lat=  double.parse(drugData!.latitude.toString());
lng =double.parse(drugData!.longitude.toString());

_haveHealthInsurance =  drugData!.insurranceCompany!=null;
if (_haveHealthInsurance) {
  _insuranceCompanyController.text =drugData!.insurranceCompany;
  initialInsuranceImage = drugData!.insuranceImage;
}
// ..distance=904545;
List<Placemark> placemarks = await placemarkFromCoordinates(lat!, lng!);
        
        
                        _pLocationCOntroller.text =  "${placemarks.first.country} ,  ${placemarks.first.locality}  ,   ${placemarks.first.name}";
        
}

  @override
  Widget build(BuildContext context) {
        var size =MediaQuery.of(context).size;

    return  Scaffold(
key: scaffoldState,
      appBar: AppBar(
elevation: 0,
backgroundColor: Colors.transparent ,

leading: IconButton(onPressed: (){
  Get.back();
}, icon: Icon(Icons.arrow_back_ios , color: Colors.black,)),
title: Text('Medical request' , 

style: TextStyle(color: Colors.black ,fontWeight: FontWeight.bold),

),
centerTitle: true,


      ),
body: 

Builder(
  builder: (context) {
    if (pageMode==PageMode.NEW) {
      
    return     Form(
      child:  
      
      
       SingleChildScrollView(
          padding: MediaQuery.of(context).viewInsets.copyWith(
            left: 30,right: 30 , top: 17
          )  ,
         child:   ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
                minHeight: MediaQuery.of(context).size.height,
                // maxHeight: 1009
              ),
           child: IntrinsicHeight(
             child: Column(children: [

             Image.asset('assets/images/png/Medicine request.png'),
             
             SizedBox(height: 15,),
             Container(
            //  height: 90,
             margin: EdgeInsets.only(bottom: 13),
             width: double.infinity,
             padding: EdgeInsets.only(
               top: 20,bottom: 20
             ),
              decoration: BoxDecoration(
                color: AppColors.ONBACKGROUND,
                borderRadius: BorderRadius.circular(8)
              ),
               child: Center(
             
             child: _prescriptionImage !=null?
            
             Stack(
              clipBehavior: Clip.none,
              children: [
             
             
             
             
             
             
             
                  Container(
                               height: 90,
                               width: double.infinity,
                               
                                // backgroundColor: Colors.white,
                                // radius: 60,
                                // backgroundImage: FileImage(File(_insuraceImage!.path)),
    
    decoration: BoxDecoration(
    
      image: DecorationImage(image: FileImage(File(_prescriptionImage!.path) ,),fit: BoxFit.cover)
    ),
                              ),
             
                    // CircleAvatar(
                    //             backgroundColor: Colors.white,
                    //             radius: 60,
                    //             backgroundImage: FileImage(File(_prescriptionImage!.path)),
                    //           ),
             
             
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
             : 
             Column(
              children: [
                Transform.rotate(
                  
                  angle: 300,
                  child: IconButton(onPressed: (){
             _showCupertinoModalSheet();
                                  setState(() {});
             log(';;;;;;;');
             
                  }, icon: Icon(Icons.login_outlined ,color: Theme.of(context).primaryColor,))
                  
                  ),
                  Text(tr('add_prescription_image' ,
                  
                  
                  ) ,style: TextStyle(


                    fontSize: 15 ,fontWeight: FontWeight.w300,
                    color: Color(0xFF3A3B55)
                  ),)
              ],
             )
             ,
             
             
             
             
             
             
             
             
             
             
             
             
             
             
             
               ),
             )
             ,
             
             BoxTextField(
             label: tr('drug_name'),
             controller: _drugNameController,
             validator: validateRequiredField,
             ),
           AppDropdownInput<Map>(
        options: _areas2,
        hintText:  tr('select_search_area'),
        value: _area2,
        getLabel: (str){
          if (context.locale==Locale('ar')) {
            return str['value-ar'];
          }else{
             return str['value-en'];
          }
        } ,
        onChanged: (str){
      setState(() {
        
        _area2 =str!;
      });
        },
      
      ),
      
      
               GestureDetector(
        onTap: ()async{
        LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    PlacePicker(AppConstants.GOOGLE_MAP_KEY!,
                              
      
      
      
                                )));
      
      
              setState(() {
                lat =result.latLng!.latitude;
                lng = result.latLng!.longitude;
              });
List<Placemark> placemarks = await placemarkFromCoordinates(lat!, lng!);
        
        
                        _pLocationCOntroller.text =  "${placemarks.first.country} ,  ${placemarks.first.locality}  ,   ${placemarks.first.name}";
        

                            // _pLocationCOntroller.text =result.name!;

        },
        child:   BoxTextField(label: tr('select_current_location'),
        
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
      
       SizedBox(height: 5,),
            
            
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [

Text(tr('you_have_insurance') ,style: TextStyle(

               fontSize: 14, fontWeight: FontWeight.w400
             ),),
            //  SizedBox(width: 6,)

      GestureDetector(
                        onTap: (){
                          // if ( groupValue !=urgentValue) {
                          //   groupValue=urgentValue;
                          // }else{
                          //    groupValue=-1;
                          // }
_haveHealthInsurance =!_haveHealthInsurance;
                          setState(() {
                            
                          });
                             if (_haveHealthInsurance) {
                               _insuranceValidator =validateRequiredField;

                              
                             }else{
                               _insuranceValidator=null;
                             }
                             setState(() {
                               
                             });
                        },
                        child: Container(
                      width: 24,height: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color:_haveHealthInsurance?Theme.of(context).primaryColor: AppColors.ONBACKGROUND
                      ),
                      
                      child: Center(
                        child: _haveHealthInsurance?Icon(Icons.check,color: Colors.white,):SizedBox.shrink(),
                      )
                        ),
                      ),
                      
                    
               ],
             ),

            
            //  CheckboxListTile(value: _haveHealthInsurance, onChanged: (value){
            //    _haveHealthInsurance=value!;
            //    setState(() {
                 
            //    });
            //  } ,
             
            //  title: Text(tr('you_have_insurance') ,style: TextStyle(

            //    fontSize: 14, fontWeight: FontWeight.w400
            //  ),),
            //  )
             
             
            //  ,
             


                                SizedBox(height: 8,),

            //  AppDropdownInput(
            //    options: [],
            //    value: '',
               
            // hintText: tr('insurane_company')
            //  ) ,
              BoxTextField(
             label: tr('insurane_company'),
             controller: _insuranceCompanyController,
             validator:_haveHealthInsurance?validateRequiredField: (str)=>null,
             ),
             
             
             Container(
             height: 90,
             margin: EdgeInsets.only(bottom: 30),
             width: double.infinity,
             padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.ONBACKGROUND,
                borderRadius: BorderRadius.circular(10) ,
    
              // image:  _insuraceImage !=null?
    
              // DecorationImage(image: FileImage(_insuraceImage!)):null
              ),
               child: Center(
             
             child: _insuraceImage !=null?
             Stack(
              // clipBehavior: Clip.none,
              children: [
             
             
             
             
             
             
             
             
             
                    Container(
                               
                               height: 90, width: double.infinity,
                                // backgroundColor: Colors.white,
                                // radius: 60,
                                // backgroundImage: FileImage(File(_insuraceImage!.path)),
    
    decoration: BoxDecoration(
    
      image: DecorationImage(image: FileImage(File(_insuraceImage!.path) ,),fit: BoxFit.cover)
    ),
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
                                onPressed: !_haveHealthInsurance?  
                                null:
                                () {
                                  _showCupertinoModalSheetForInsurance();
                                  setState(() {});
                                },
                              ),
                            ),
                          )
              ],
             )
             : 
             
             Column(
              children: [
                Transform.rotate(
                  
                  angle: 300,
                  child: IconButton(onPressed:  !_haveHealthInsurance?  
                                null:(){
            //  _showCupertinoModalSheet();
             _showCupertinoModalSheetForInsurance();
                                  setState(() {});
             
             
                  }, icon: Icon(Icons.login_outlined ,color: Theme.of(context).primaryColor,))
                  
                  ),
                  Text(tr('add_insurance_image' ,
                  
                  
                  )
                  
                  ,style: TextStyle(


                    fontSize: 15 ,fontWeight: FontWeight.w300,
                    color: Color(0xFF3A3B55)
                  )
                  )
              ],
             )
             ,
             
             
             
             
             
             
             
             
             
             
             
             
             
             
             
               ),
             )
             ,
             SizedBox(height: 10,),
             MyButton(
               title: tr('add_request'),
               
               color: Theme.of(context).primaryColor,

               onTap: (){
    
                 _onDrugRequest(context);
               },
             )
             
             
             
             
             
             ]),
           ),
         ),
       ),
    );
  
  
    } else {


    return     Form(
      child:  
      
      
       SingleChildScrollView(
          padding: MediaQuery.of(context).viewInsets.copyWith(
            left: 30,right: 30 , top: 17
          )  ,
         child:   ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
                minHeight: MediaQuery.of(context).size.height,
                // maxHeight: 1009
              ),
           child: IntrinsicHeight(
             child: Column(children: [

             Image.asset('assets/images/png/Medicine request.png'),
             
             SizedBox(height: 15,),
             Container(
            //  height: 90,
             margin: EdgeInsets.only(bottom: 13),
             width: double.infinity,
             padding: EdgeInsets.only(
               top: 20,bottom: 20
             ),
              decoration: BoxDecoration(
                color: AppColors.ONBACKGROUND,
                borderRadius: BorderRadius.circular(8)
              ),
               child: Center(
             
             child: _prescriptionImage !=null?
            
             Stack(
              clipBehavior: Clip.none,
              children: [
             
             
             
             
             
             
             
                  Container(
                               height: 90,width: double.infinity,
                               
                                // backgroundColor: Colors.white,
                                // radius: 60,
                                // backgroundImage: FileImage(File(_insuraceImage!.path)),
    
    decoration: BoxDecoration(
    
      image: DecorationImage(image: FileImage(File(_prescriptionImage!.path) ,),fit: BoxFit.cover)
    ),
                              ),
             
                    // CircleAvatar(
                    //             backgroundColor: Colors.white,
                    //             radius: 60,
                    //             backgroundImage: FileImage(File(_prescriptionImage!.path)),
                    //           ),
             
             
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
          
          
         :
          initialDrugImage!=null?


             Stack(
              clipBehavior: Clip.none,
              children: [
             
             
             
             
             
             
             
                  Container(
                               
                               height: 90,width: double.infinity,
                                // backgroundColor: Colors.white,
                                // radius: 60,
                                // backgroundImage: FileImage(File(_insuraceImage!.path)),
    
    decoration: BoxDecoration(
    
      image: DecorationImage(image: NetworkImage(
        
        global.configModel.imagesUrl!+"/"+initialDrugImage!
         ),fit: BoxFit.cover)
    ),
                              ),
             
                    // CircleAvatar(
                    //             backgroundColor: Colors.white,
                    //             radius: 60,
                    //             backgroundImage: FileImage(File(_prescriptionImage!.path)),
                    //           ),
             
             
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
          
          
             :
             
              Column(
              children: [
                Transform.rotate(
                  
                  angle: 300,
                  child: IconButton(onPressed: (){
             _showCupertinoModalSheet();
                                  setState(() {});
             
             
                  }, icon: Icon(Icons.login_outlined ,color: Theme.of(context).primaryColor,))
                  
                  ),
                  Text(tr('add_prescription_image' ,
                  
                  
                  ) ,style: TextStyle(


                    fontSize: 15 ,fontWeight: FontWeight.w300,
                    color: Color(0xFF3A3B55)
                  ),)
              ],
             )
             ,
             
             
             
             
             
             
             
             
             
             
             
             
             
             
             
               ),
             )
             ,
             
             BoxTextField(
             label: tr('drug_name'),
             controller: _drugNameController,
             validator: validateRequiredField,
             ),
           AppDropdownInput<Map>(
        options: _areas2,
        hintText:  tr('select_search_area'),
        value: _area2,
        getLabel: (str){
          if (context.locale==Locale('ar')) {
            return str['value-ar'];
          }else{
             return str['value-en'];
          }
        } ,
        onChanged: (str){
      setState(() {
        
        _area2 =str!;
      });
        },
      
      ),
      
      
               GestureDetector(
        onTap: ()async{
        LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    PlacePicker(AppConstants.GOOGLE_MAP_KEY!,
                              
      
      
      
                                )));
      
      
              setState(() {
                lat =result.latLng!.latitude;
                lng = result.latLng!.longitude;
              });
List<Placemark> placemarks = await placemarkFromCoordinates(lat!, lng!);
        
        
                        _pLocationCOntroller.text =  "${placemarks.first.country} ,  ${placemarks.first.locality}  ,   ${placemarks.first.name}";
        

                            // _pLocationCOntroller.text =result.name!;

        },
        child:   BoxTextField(label: tr('select_current_location'),
        
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
      
       
             
           SizedBox(height: 5,),
            
            
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [

Text(tr('you_have_insurance') ,style: TextStyle(

               fontSize: 14, fontWeight: FontWeight.w400
             ),),
            //  SizedBox(width: 6,)

      GestureDetector(
                        onTap: (){
                          // if ( groupValue !=urgentValue) {
                          //   groupValue=urgentValue;
                          // }else{
                          //    groupValue=-1;
                          // }
_haveHealthInsurance =!_haveHealthInsurance;
                          setState(() {
                            
                          });
                             
                        },
                        child: Container(
                      width: 24,height: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color:_haveHealthInsurance?Theme.of(context).primaryColor: AppColors.ONBACKGROUND
                      ),
                      
                      child: Center(
                        child: _haveHealthInsurance?Icon(Icons.check,color: Colors.white,):SizedBox.shrink(),
                      )
                        ),
                      ),
                      
                    
               ],
             ),

            
            //  CheckboxListTile(value: _haveHealthInsurance, onChanged: (value){
            //    _haveHealthInsurance=value!;
            //    setState(() {
                 
            //    });
            //  } ,
             
            //  title: Text(tr('you_have_insurance') ,style: TextStyle(

            //    fontSize: 14, fontWeight: FontWeight.w400
            //  ),),
            //  )
             
             
            //  ,
             


                                SizedBox(height: 8,),
             
             
            BoxTextField(
             label: tr('insurane_company'),
             controller: _insuranceCompanyController,
             validator:_haveHealthInsurance?validateRequiredField: (str)=>null,
             ),
             
             
             Container(
             height: 90,
             margin: EdgeInsets.only(bottom: 30),
             width: double.infinity,
             padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.ONBACKGROUND,
                borderRadius: BorderRadius.circular(10) ,
    
              // image:  _insuraceImage !=null?
    
              // DecorationImage(image: FileImage(_insuraceImage!)):null
              ),
               child: Center(
             
             child: _insuraceImage !=null?
             Stack(
              // clipBehavior: Clip.none,
              children: [
             
             
             
             
             
             
             
             
             
                    Container(
                               
                               height: 90, width: double.infinity,
                                // backgroundColor: Colors.white,
                                // radius: 60,
                                // backgroundImage: FileImage(File(_insuraceImage!.path)),
    
    decoration: BoxDecoration(
    
      image: DecorationImage(image: FileImage(File(_insuraceImage!.path) ,),fit: BoxFit.cover)
    ),
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
                                onPressed: !_haveHealthInsurance?  
                                null:
                                () {
                                  _showCupertinoModalSheetForInsurance();
                                  setState(() {});
                                },
                              ),
                            ),
                          )
              ],
             )
             : 
             initialInsuranceImage!=null?


             Stack(
              clipBehavior: Clip.none,
              children: [
             
             
             
             
             
             
             
                  Container(
                               
                               height: 90,width: double.infinity,
                                // backgroundColor: Colors.white,
                                // radius: 60,
                                // backgroundImage: FileImage(File(_insuraceImage!.path)),
    
    decoration: BoxDecoration(
    
      image: DecorationImage(image: NetworkImage(
        
        global.configModel.imagesUrl!+"/"+initialInsuranceImage!
         ),fit: BoxFit.cover)
    ),
                              ),
             
                    // CircleAvatar(
                    //             backgroundColor: Colors.white,
                    //             radius: 60,
                    //             backgroundImage: FileImage(File(_prescriptionImage!.path)),
                    //           ),
             
             
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
                                  _showCupertinoModalSheetForInsurance();
                                  setState(() {});
                                },
                              ),
                            ),
                          )
              ],
             )
          
          
             :
             Column(
              children: [
                Transform.rotate(
                  
                  angle: 300,
                  child: IconButton(onPressed:  !_haveHealthInsurance?  
                                null:(){
            //  _showCupertinoModalSheet();
             _showCupertinoModalSheetForInsurance();
                                  setState(() {});
             
             
                  }, icon: Icon(Icons.login_outlined ,color: Theme.of(context).primaryColor,))
                  
                  ),
                  Text(tr('add_insurance_image' ,
                  
                  
                  )
                  
                  ,style: TextStyle(


                    fontSize: 15 ,fontWeight: FontWeight.w300,
                    color: Color(0xFF3A3B55)
                  )
                  )
              ],
             )
             ,
             
             
             
             
             
             
             
             
             
             
             
             
             
             
             
               ),
             )
             ,
             SizedBox(height: 10,),
             MyButton(
               title: tr('update_my_data_btn'),
               
               color: Theme.of(context).primaryColor,

               onTap: (){
    
                 _onUpdateDrugRequest(context);
               },
             )
             
             
             
             
             
             ]),
           ),
         ),
       ),
    );
  
  
    }
    
  }
),














    );
  }










File? tImage;









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
      // log((_byteData == null).toString());
      // _byteData = await (_imageCompress(_byteData!, imageFile.path));
      // log('NO EXCEPTION 2');
      log(imageFile.path.toString());
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
   
  _prescriptionImage=tImage;

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



 _showCupertinoModalSheetForInsurance() {
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


                // global.selectedImage = tImage!.path;
                // widget.imageSelected!(true);



                setState(() {});
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
   
  _insuraceImage=tImage;

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
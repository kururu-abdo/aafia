import 'dart:developer';

import 'package:aafia/base/base.dart';
import 'package:aafia/utils/app_constants.dart';
import 'package:aafia/widgets/my_Button.dart';
import 'package:aafia/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';

import '../../utils/validations.dart';

class EditPharmacyDataPage extends BaseRoute {
   EditPharmacyDataPage({ Key? key }) : super(r: 'EditPharmacyData');

  @override
  _EditPharmacyDataPageState createState() => _EditPharmacyDataPageState();
}

class _EditPharmacyDataPageState extends BaseRouteState {
TextEditingController _nameController =TextEditingController(
  text: 'صيدلية الامل الجديدة'
);
TextEditingController _phoneControlelr =TextEditingController(
  text: '0966302389'
);
TextEditingController _addressControlelr =TextEditingController(
  text: 'الخرطوم , الكلاكلة'
);

TextEditingController _descController =TextEditingController(
  text: 'يالقرب من طلمبة بشائر'
);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios ,color: Colors.black,)),
        elevation: 0.0,
        backgroundColor: Colors.transparent,

        title: Text('تغيير بياناتي' ,style: TextStyle(color: 
        Theme.of(context).primaryColor, fontWeight: FontWeight.bold,
        fontSize: Theme.of(context).
        textTheme.titleMedium!.fontSize,
        
        ),),
        centerTitle: true,
      ),
      body:Form(
        child: SingleChildScrollView(
                 padding: MediaQuery.of(context).viewInsets
                 .copyWith(
                   left: 20 ,right: 20
                 )
                   ,
child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
            // maxHeight: 1009
          ),
         
child:    IntrinsicHeight(
child: Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    SizedBox(
      height: 100,
    ),
SizedBox(
     height: 190,
      width: 260,
  child:   Stack(
    children: [
          Container(
        height: 180,
        width: 250,
      decoration: BoxDecoration(
      
      borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: 
      
      AssetImage('assets/images/png/HomeImage.png'),fit: BoxFit.cover
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(.05) ,
        )
      ]
      ),
      
      
      ),
      Positioned(
       bottom: 5,
       right: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
  shape: BoxShape.circle ,
  color: Colors.grey.withOpacity(.5)

        ),

        child: Center(
          child: Icon(Icons.edit ,color: Theme.of(context).primaryColor,),
        ),
      ),
      )
    ],
  ),
),

SizedBox(height: 20,),

BoxTextField(
  controller: _nameController,
  label: ''


),
BoxTextField(
  controller: _phoneControlelr,
  label: ''


),

  GestureDetector(
    onTap: ()async{
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                PlacePicker(AppConstants.GOOGLE_MAP_KEY!,
                          
  
  
  
                            )));
  
  
          _addressControlelr.text =result.name!;
          // setState(() {
          //   lat =result.latLng!.latitude;
          //   lng = result.latLng!.longitude;
          // });
    },
    child:   BoxTextField(label: '',
    
    controller: _addressControlelr,
    enabled: false,
    suffix: IconButton(onPressed: (){
      log('sdfdsf');
    }, icon:  Icon(Icons.location_on,
    color: Theme.of(context).primaryColor,
    )
    
    ),
    
    ),
  ),
   
  BoxTextField(label: '',
  
  controller: _descController,
  hegiht: 120,
  isMulti: true,
  validator: validateRequiredField,
  
  // suffix: IconButton(onPressed: (){}, icon:  Icon(Icons.keyboard_arrow_down,
  // color: Theme.of(context).primaryColor,
  // )
  
  // ),
  
  ),

    Spacer(),
    MyButton(
      title: 'حفظ التعديلات', 
      isLoading: false,
      onTap: (){

      },
      color: Theme.of(context).primaryColor,
    )
  ],
),
)
)
        ),
      ),
    );
  }
}
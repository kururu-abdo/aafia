import 'dart:developer';

import 'package:aafia/utils/colors.dart';
import 'package:aafia/utils/validations.dart';
import 'package:aafia/widgets/my_Button.dart';
import 'package:aafia/widgets/my_textfield.dart';
import 'package:aafia/widgets/toastfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CommentBottomSheet extends StatefulWidget {
  final Size screenSize;
final  Function(String)? getImageUrl;
  CommentBottomSheet(this.screenSize , this.getImageUrl);

  @override
  _CommentBottomSheetState createState() =>
      _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  _buildHeading(String text) {
    return Text(text, style: TextStyle(fontSize: 26, color: Colors.black));
  }
int _available = -1;
  _buildCloseButton(context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(Icons.close, color: Theme.of(context).primaryColor),
    );
  }
FToast? fToast;


   var _availableFormKey=GlobalKey<FormState>();
   var _unAvailableFormKey=GlobalKey<FormState>();
@override
void initState() {
    super.initState();
    fToast = FToast();
    // if you want to use context from globally instead of content we need to pass navigatorKey.currentContext!
    fToast!.init(context);
}

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*.60,

decoration: BoxDecoration(
     borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(25),
                    topStart: Radius.circular(25),
                  ),
                  color: Colors.white
),

      child: Container(
        margin: 
        EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child:
        Column(children: [
          Center(
            child: Text('رد على الطلب' ,
            style:Theme.of(context).textTheme.titleLarge,

            ),
          ) ,
GestureDetector(
  onTap: (){
    setState(() {
      
      _available=1;
    });
  },
  child:   Container(
    width: double.infinity,
    child:   Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
    
    Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        color: AppColors.TEXT_FILLED_COLOR,
        
      ),
      child: Center(
  child: _available==1?Icon(
    Icons.check ,
    color: Theme.of(context).primaryColor,
  ):SizedBox.shrink(),
  
      ),
    ) ,
  
    SizedBox(width: 5,) ,
    Text('الدواء متوفر لديك'
    
        ,
    style: Theme.of(context).textTheme.titleMedium!.copyWith(
fontWeight: FontWeight.bold
    ),
    
    )
    
    
      ],
    ),
  ),
),


Form(
  key: _availableFormKey,
  child:   Column(
    children: [
          BoxTextField(label: 'سعر الدواء' ,
      keyboardType: TextInputType.number,
      
      enabled: _available==1,
      validator: validateRequiredField,
      ),
    ],
  ),
),




GestureDetector(
  onTap: (){
    setState(() {
      
      _available=0;
    });
  },
  child: 
    Container(
    width: double.infinity,
    child:   Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
    
    Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        color: AppColors.TEXT_FILLED_COLOR,
        
      ),
      child: Center(
  child: _available==0?Icon(
    Icons.check ,
    color: Theme.of(context).primaryColor,
  ):SizedBox.shrink(),
  
      ),
    ) ,
  
    SizedBox(width: 5,) ,
    Text('متوفر دواء بديل'  ,
    
    style: Theme.of(context).textTheme.titleMedium!.copyWith(
fontWeight: FontWeight.bold
    ),
    )
    
    
      ],
    ),
  ),
),


Form(
  key: _unAvailableFormKey,
  child: 

Column(children: [
     BoxTextField(label: 'سعر الدواء البديل' ,
      keyboardType: TextInputType.number,
      
      enabled: _available==0,
      validator: validateRequiredField,
      ),

       BoxTextField(label: 'اسم الدواء البديل' ,
      keyboardType: TextInputType.number,
      
      enabled: _available==0,
      validator: validateRequiredField,
      ),


  BoxTextField(label: 'تفاصيل',
  
  hegiht: 120,
  isMulti: true,
  validator: validateRequiredField,
  
  // suffix: IconButton(onPressed: (){}, icon:  Icon(Icons.keyboard_arrow_down,
  // color: Theme.of(context).primaryColor,
  // )
  
  // ),
  
  ),
],)
),


          Spacer(),

          MyButton(
            color: Theme.of(context).primaryColor,
            title: 'رد على الطلب',
            onTap: (){
              Navigator.pop(context);
showTopToast('تم اضافة الرد بنجاح', context,fToast!,
isSuccess: true
);
            },
            isLoading: false,
          )
        ],)
     
      ),
    );
  }




}
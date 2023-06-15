
import 'package:aafia/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


getBottomSheetRoundedBox(width, height, radius){
  return  

                    
              FractionallySizedBox(
          widthFactor: 0.2, // width of top divider bar
          child: Container(
            margin: const EdgeInsets.symmetric( // margin of top divider bar
              vertical: 12.0,
            ),
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: Color(0xFFF0F2FA), // color of top divider bar
                borderRadius:  BorderRadius.all(Radius.circular(radius)),
              ),
            ),
          ),
            );
           
}
getUserConfirmBottomSheet(){

Get.bottomSheet(Container(
height: 283,
width: double.infinity,

padding: EdgeInsets.fromLTRB(30, 12, 40, 42),
child: Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
getBottomSheetRoundedBox(44, 6, 4),
SizedBox(height: 23,),
Center(
  child: Container(
   height: 100,width: 100,
  decoration: BoxDecoration(
    shape: BoxShape.circle ,color: AppColors.SPLASH_COLOR ,
image: DecorationImage(image: AssetImage('assets/images/png/verification step-3.png'))
  ),
  // child: Center(child: Image.asset('assets/images/'    ),),
  ),
),
SizedBox(height: 18,),
Center(
  child: Text('تم تأكيد طلبك بنجاح',
  textAlign: TextAlign.justify
   ,style: TextStyle(color: Colors.green ,
  
  fontWeight: FontWeight.w500 ,fontSize: 16
  ),),
) ,

SizedBox(height: 18,),
Center(
  child: Text('سيتم توصيل الطلب مباشرة في مدة لا تتجاوز الساعة  ,شكراً لك',
  textAlign: TextAlign.center
   ,style: TextStyle(
     fontSize: 14,fontWeight: FontWeight.w400
   ),
  ))


]),
),
shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.vertical(top: Radius.circular(20))
)

);
}
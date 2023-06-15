import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:showcaseview/showcaseview.dart';

void showToast(String message ,{bool isSucess=false}) {
  Fluttertoast.showToast(
      msg: message,
    
      gravity: ToastGravity.CENTER,
      textColor: Colors.white,
      fontSize: 13,
      backgroundColor:isSucess?Colors.green: Colors.black);
}



void showTopToast(String? message ,
BuildContext context,
FToast fToast,
{bool isSuccess=false}
){
   
   MotionToast(
    barrierColor: Colors.black.withOpacity(.5),
     
icon: null,
	primaryColor:
   isSuccess?
  Colors.green[900]!
  
  : Theme.of(context).primaryColor,


	title:  Text(message! ,  
  
  style: TextStyle(
    fontWeight: FontWeight.w400 ,fontSize: 16 
  ),
  
  ),
	description:  Text(""),
  
  borderRadius: 6,
 width: 327,
	height:  47,

  padding: 
  
  const EdgeInsets
                  .symmetric( vertical: 10.0 ,horizontal: 15)
  ,
position: MotionToastPosition.top,

	
).show(context);
  //   Widget toast = 
    
  
  // ShowCaseWidget(
      

  //     builder: Builder(
  //       builder: (context) {
  //         return 
  // Stack(
  //           children: [
  //             Container(
  //               width: double.infinity,
  //               height: 70,
  //                 padding: const EdgeInsets
  //                 .symmetric( vertical: 10.0 ,horizontal: 15),
  //                 decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(10.0),
  //                 color: Colors.white,
                
  //                 ),
  //                 child:
  //                     Text(
  //                       message!,
  //                       style: TextStyle(
  //                         color: Colors.green,
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 18
  //                       ),
  //                     ),
               
  //             ),
    
  //             Align(alignment: 
  //             AlignmentDirectional.centerStart ,
  //             child:  Container(
  //               width: 10,
  //             height: 70,
  //                 padding: const EdgeInsets
  //                 .symmetric( vertical: 10.0),
  //                 decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(2.0),
  //                 color: Colors.green[900],
  //                 ), )
  //             ,)
  //           ],
  //         );
  //       }
  //     ),
  //   );


  //   fToast.showToast(
  //       child: toast,
  //       gravity: ToastGravity.TOP,
  //       toastDuration: Duration(seconds: 2),
  //   );
    
   
        
}



SnackBar showResultSnackBar(String? msg ,{bool isSucess=true}){
 return SnackBar(
  elevation: 6.0,
  backgroundColor: isSucess?  Colors.green:Colors.red,
  behavior: SnackBarBehavior.floating,
  content: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Text(
        msg!.toString(),
        style: TextStyle(color: isSucess?Colors.white:Colors.black),
      ),

      isSucess?Icon(Icons.done_rounded ,color: Colors.white,):
      Icon(Icons.dangerous ,color: Colors.black,)
    ],
  ),
);
}
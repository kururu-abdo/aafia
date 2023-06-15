import 'package:aafia/utils/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  

static  darkTheme(BuildContext context){
  return ThemeData(
    useMaterial3: true,
    primaryColor: Color(0xFFed6c66),
brightness: Brightness.dark ,
       buttonTheme: ButtonThemeData( // 4
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor:  Color(0xFFed6c66),
      )
  
  ) ;
}

static  lightTheme(BuildContext context){
  return ThemeData(
    fontFamily: 'montserrat-arabic',
    useMaterial3: true,
     primaryColor: AppColors.PRIMARY_COLOR,

    

    //  scaffoldBackgroundColor: Colors.blue[50],
   appBarTheme: AppBarTheme(

    
    iconTheme: IconThemeData(
      color: Colors.white ,

    
    ),
    
    
     color: Color(0xFFed6c66),
     titleTextStyle: TextStyle(
       color:  Colors.white ,

       fontWeight: FontWeight.w500 ,fontSize: 15
     ),
     elevation: 0.0,
  

   ),
brightness: Brightness.light ,
         buttonTheme: ButtonThemeData( // 4
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor:  Color(0xFFed6c66),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor:MaterialStatePropertyAll<Color>(
            Color(0xFFed6c66),
        )
         ,


         
       
      )

      
  ) ;
}



}
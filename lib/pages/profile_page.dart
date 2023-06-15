import 'package:aafia/pages/about_app.dart';
import 'package:aafia/pages/change_lang.dart';
import 'package:aafia/pages/change_password.dart';
import 'package:aafia/pages/contact_us.dart';
import 'package:aafia/pages/edit_my_data_page.dart';
import 'package:aafia/pages/pharmacy/edit_my_data_pharmacy.dart';
import 'package:aafia/pages/splash_page.dart';
import 'package:aafia/pages/terms_and_conditions.dart';
import 'package:aafia/widgets/custom_switch.dart';
import 'package:easy_localization/easy_localization.dart' as loc;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:aafia/utils/global.dart' as global;
class ProfilePage extends StatelessWidget {
   ProfilePage({ Key? key }) : super(key: key);
 final  cancelButton = TextButton(
    child: Text("${loc.tr('cancel')}"),
    onPressed:  () {
      Get.back();
    },
  );
  final  Widget continueButton = TextButton(
    child: Text("${loc.tr('continue')}"),
    onPressed:  () {
global.sp!.clear();
     Get.offAll(SplashPage()); 
    },
  );

  // // set up the AlertDialog
  // AlertDialog alert = AlertDialog(
  //   title: Text("AlertDialog"),
  //   content: Text("Would you like to continue learning how to use Flutter alerts?"),
  //   actions: [
  //     cancelButton,
  //     continueButton,
  //   ],
  // );

  @override
  Widget build(BuildContext context) {

    var directon =Directionality.of(context);
    return SizedBox.expand(
      child: ListView(

        children: [
          SizedBox(height: 40,)
,
global.currentUser!.usertype=='client'?
Padding(
  padding: EdgeInsets.symmetric(
    horizontal: 10 ,

  ),  child:   Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
  
  ClipOval(
  child: 
  
  global.currentUser!.image == null || global.currentUser!.image.length<2?
  Image.asset('assets/images/png/placeholder.jpg' , fit: BoxFit.cover,
    width: 80.0,
    height: 80.0,):
  
  
  
  
  Image.network(
    global.configModel.imagesUrl!+"/"+global.currentUser!.image.toString(),
    fit: BoxFit.cover,
    width: 80.0,
    height: 80.0,
  )
),
//   CircleAvatar(
//     radius: 50,


// backgroundColor: Colors.white,
//     backgroundImage: 

//     //  global.currentUser!.image != null?

//     // NetworkImage(global.currentUser!.image.toString() ,
//     // )
    
    
//     // :
// AssetImage('assets/images/png/placeholder.jpg')

//     // AssetImage('assetName')
    
//      ,
//    child: Image.network(global.configModel.imagesUrl!+"/"+global.currentUser!.image.toString())
//   ) ,
  SizedBox(height: 10,),
  
  Text('${global.currentUser!.name}' , style: TextStyle(
    color: Colors.green ,fontSize: 16,fontWeight: FontWeight.w400
  ),)
  
  ,
SizedBox(height: 19,),
  ],
  ),
):
Padding(
  padding: EdgeInsets.symmetric(
    vertical: 27 ,horizontal: 48

  ),  child:   Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
  
  Container(
    height: 80,
    width: 80, 
  
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(6),
    image: DecorationImage(image: AssetImage('assets/images/png/medicine2.png',),
    fit: BoxFit.cover
    )
  ),
  ),
  
  Text(
    'صيدلية الامل' ,
  
    style: TextStyle(
      fontWeight: FontWeight.bold ,
      fontSize: 20
    ),
  )
  
    ],
  ),
)

,

SizedBox(height: 20,),

Container(


  padding: EdgeInsets.symmetric(
    horizontal: 25

  ),

  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
mainAxisAlignment: MainAxisAlignment.spaceAround,

    children: [


Container(
  margin: const EdgeInsets.only(bottom:26.0),
  padding: EdgeInsets.only(
    top: 2,bottom: 11,right: 17,left: 10
  ),
  child:   Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
  Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.edit),Text('${loc.tr('edit_my_data')}' ,     style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400 ,color: Color(0xFF3A3B55)),
)
    ],
  ) ,
  
  IconButton(onPressed: (){
if (global.currentUser!.usertype=='client'
) {
  Get.to(()=>EditMyDataPage());
}else{
  Get.to(()=>EditPharmacyDataPage());
}



  }, icon: Icon(
    directon==TextDirection.ltr?
    
    Icons.keyboard_arrow_right:
      Icons.keyboard_arrow_left
  
    
    ))
  
  
    ],
  ),
),

Container(
  margin: const EdgeInsets.only(bottom:26.0),
  padding: EdgeInsets.only(
    top: 2,bottom: 11,right: 17,left: 10
  ),
  child:   Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
  Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.translate),
      Text(loc.tr('change_lang') ,
      
            style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400 ,color: Color(0xFF3A3B55)),

      )
    ],
  ) ,
  
   IconButton(onPressed: (){
     Get.to(()=>LanguageSelectorPage());

   }, icon: Icon(
        directon==TextDirection.ltr?
        
        Icons.keyboard_arrow_right:
          Icons.keyboard_arrow_left
      
        
        ))
  
    ],
  ),
),


Container(
  margin: const EdgeInsets.only(bottom:26.0),
  padding: EdgeInsets.only(
    top: 2,bottom: 11,right: 17,left: 10
  ),

  child:   Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
  Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.lock),Text('${loc.tr('change_password')}' ,      style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400 ,color: Color(0xFF3A3B55)),
)
    ],
  ) ,
   IconButton(onPressed: (){
         Get.to(()=>ChangePasswordPage());

   }, icon: Icon(
      directon==TextDirection.ltr?
      
      Icons.keyboard_arrow_right:
        Icons.keyboard_arrow_left
    
      
      ))
  
  
  
    ],
  ),
),



Container(
 margin: const EdgeInsets.only(bottom:26.0),
  padding: EdgeInsets.only(
    top: 2,bottom: 11,right: 17,left: 10
  ),
  child:   Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
  Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.notifications),Text('${loc.tr('notifications')}'  ,       style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400 ,color: Color(0xFF3A3B55)),
)
    ],
  ) ,
  
  // IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios))
  CustomSwitch( 
    value: true,
    enableColor: Colors.green ,
    disableColor: Colors.grey
    ,
    width: 70,
    switchHeight: 20,
    height: 40,
    onChanged: (value){},
  )
  
    ],
  ),
),

Container(
  margin: const EdgeInsets.only(bottom:26.0),
  padding: EdgeInsets.only(
    top: 2,bottom: 11,right: 17,left: 10
  ),
  child:   GestureDetector(
    onTap: (){
      Get.to(()=>ContactUs());
  
    },
    child:   Container(
      margin: EdgeInsets.symmetric(
        vertical: 8
      ),
      child:   Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.headphones_outlined),Text('${loc.tr('call_us')}'
          
          ,
                style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400 ,color: Color(0xFF3A3B55)),

          )
        ],
      ) ,
      
      // IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios))
      
      
        ],
      ),
    ),
  ),
),


Container(
  margin: const EdgeInsets.only(bottom:26.0),
  padding: EdgeInsets.only(
    top: 2,bottom: 11,right: 17,left: 10
  ),
  child:   Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
  Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.description),Text('${loc.tr('terms_and_conditions')}' ,
      
      
      style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400 ,color: Color(0xFF3A3B55)),
      )
    ],
  ) ,
  
   IconButton(onPressed: (){
     Get.to(()=>TermsAndConditionsPage());

   }, icon: Icon(
        directon==TextDirection.ltr?
        
        Icons.keyboard_arrow_right:
          Icons.keyboard_arrow_left
      
        
        ))
  
    ],
  ),
),






Container(
  margin: const EdgeInsets.only(bottom:26.0),
  padding: EdgeInsets.only(
    top: 2,bottom: 11,right: 17,left: 10
  ),
  child:   Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
  Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.description),Text('${loc.tr('privacy')}' ,
      
            style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400 ,color: Color(0xFF3A3B55)),

      )
    ],
  ) ,
  
   IconButton(onPressed: (){
    //  Get.to(()=>());

   }, icon: Icon(
        directon==TextDirection.ltr?
        
        Icons.keyboard_arrow_right:
          Icons.keyboard_arrow_left
      
        
        ))
  
    ],
  ),
),


Container(
 margin: const EdgeInsets.only(bottom:26.0),
  padding: EdgeInsets.only(
    top: 2,bottom: 11,right: 17,left: 10
  ),
  child:   Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
  Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.star),Text('${loc.tr('rate_app')}' ,      style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400 ,color: Color(0xFF3A3B55)),
)
    ],
  ) ,
  
   IconButton(onPressed: (){


     Get.to(AboutPage());
   }, icon: Icon(
        directon==TextDirection.ltr?
        
        Icons.keyboard_arrow_right:
          Icons.keyboard_arrow_left
      
        
        ))
  
    ],
  ),
),
Container(
margin: const EdgeInsets.only(bottom:26.0),
  padding: EdgeInsets.only(
    top: 2,bottom: 11,right: 17,left: 10
  ),
  child:   Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
  Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.description),Text('${loc.tr('about')}',       style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400 ,color: Color(0xFF3A3B55)),
)
    ],
  ) ,
  
   IconButton(onPressed: (){

Get.to(()=>AboutPage());



   }, icon: Icon(
        directon==TextDirection.ltr?
        
        Icons.keyboard_arrow_right:
          Icons.keyboard_arrow_left
      
        
        ))
  
    ],
  ),
),


Container(
  margin: const EdgeInsets.only(bottom:26.0),
  padding: EdgeInsets.only(
    top: 2,bottom: 11,right: 17,left: 10
  ),
  child:   GestureDetector(
    onTap: ()async{
  //  Provider.of<AuthProvider>(context)
  
  
   AlertDialog alert = AlertDialog(
      title: Text("${loc.tr('logout')}" ),
      content: Text("Do you want to logout?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
  
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  
    },
    child:   Container(
        margin: EdgeInsets.symmetric(vertical: 8),
    
      child:   Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.logout, color: Colors.red),Text('${loc.tr('logout')}' ,style: TextStyle(
            color: Colors.red ,fontSize: 14,fontWeight: FontWeight.w400
          ),)
        ],
      ) ,
      
      // IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios))
      
      
        ],
      ),
    ),
  ),
),



    ],
  ),
)








        ],
      ),
    );
  }
}
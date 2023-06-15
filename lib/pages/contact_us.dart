import 'package:aafia/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ONBACKGROUND,
      appBar: AppBar(
        elevation: 0, backgroundColor: Colors.transparent ,


        title: Text(
          '${tr('call_support')}' ,style: TextStyle(
            color: Theme.of(context).primaryColor
          ),

        ),
        centerTitle: true,

        leading: IconButton(onPressed: (){ 
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios  ,
        color: Colors.black,
        
        )),
      ),
      body: Column(
        children: [
SizedBox(height: 47,),
SizedBox(
  // height: MediaQuery.of(context).size.height/2,
  child: Container(
    width: 256,
    height: 235,
// height: MediaQuery.of(context).size.height/2,
decoration:BoxDecoration(
  image: DecorationImage(image: AssetImage('assets/images/png/Sent Message-bro.png' ,),fit: BoxFit.cover)
),

  ),
),
SizedBox(height: 1,),
Expanded(child: 
Container(
  height: 375,
  padding: EdgeInsets.only(
  left: 40 ,right: 40 ,top: 45
  ),
decoration: BoxDecoration(
  color: Colors.white,
borderRadius: BorderRadius.vertical(
  top: Radius.circular(10)
)
),
child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
Text('${tr('we_happy')}' ,

textAlign: TextAlign.justify,
style: TextStyle(
  fontWeight: FontWeight.w400 ,fontSize: 15
),
) ,
SizedBox(height: 23,),

Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [

SizedBox(
  height: 26,
  child:   Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
  
    children: [
  Icon(Icons.phone),
  SizedBox(width: 5,),
  Text('+966302389' ,
 style: TextStyle(
    fontSize: 15,fontWeight: FontWeight.w400
  )
  
  )
  
    ],
  ),
),


SizedBox(height: 19,),

SizedBox(
    height: 26,

  child:   Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
  
    children: [
  Image.asset('assets/images/png/whatsapp.png'),
  SizedBox(width: 5,),
  Text('${tr('whatsapp')}' ,style: 
  
  TextStyle(
    fontSize: 15,fontWeight: FontWeight.w400
  )
  ,)
  
    ],
  ),
),












  ],
)











  ],
),

)

)












        ],
      ),
    );
  }
}
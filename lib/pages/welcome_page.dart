import 'package:aafia/pages/change_lang.dart';
import 'package:aafia/pages/login_page.dart';
import 'package:aafia/utils/sizes.dart';
import 'package:aafia/widgets/my_Button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreem extends StatelessWidget {
  const WelcomeScreem({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height:132),

SizedBox(


child: Center(
 child: Image.asset('assets/images/png/undraw_mobile_encryption_re_yw3o.png',
 width: 220,
 height:250 ,
 )
),

),



SizedBox(height: 35,),

Text(tr('welcome_to_afia'),

style: Theme.of(context).textTheme.titleMedium!.copyWith(
  fontSize:            Sizes.FontSizeTitle
,
  color: Theme.of(context).primaryColor ,fontWeight: FontWeight.w500
),
)
,
SizedBox(height: 17,),


SizedBox(
  height: 87,
  width: double.infinity,

  child:   Text('\" ${tr('we_offer')}"'
  
   ,
  style: TextStyle(
    fontSize:             Sizes.FontSizeBody,fontWeight: FontWeight.w400
  
  ),
  textAlign: TextAlign.justify,
  overflow: TextOverflow.ellipsis,
  maxLines: 10,
  
  ),
)
,

SizedBox(height: 89,),
// Spacer(),
MyButton(
  title: tr('getting_started'),
  
  onTap: (){
    Get.to(()=>AuthPage(
    accountType: 'user',
    ));
  },

),
// SizedBox(height: 8,),
// MyButton(
//   title: 'Register as Pharmacy',
//   color: Color(0xFF3a3b55),
//   onTap: (){
//      Get.to(()=>AuthPage(
//     accountType: 'pharmacy',
//     ));
//   },
  
// )
SizedBox(height: 20,)
,

TextButton(onPressed: (){
Get.to(()=>LanguageSelectorPage());
}, child: Text(tr('change_lang' ) ,style: TextStyle(
  color: Theme.of(context).primaryColor,fontWeight: FontWeight.w300
),))

            ],
          ),
        ),
      ),
    );
  }
}
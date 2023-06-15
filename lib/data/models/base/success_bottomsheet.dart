import 'package:aafia/pages/dashboard.dart';
import 'package:aafia/pages/home.dart';
import 'package:aafia/utils/colors.dart';
import 'package:aafia/widgets/my_Button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrugRquestSuccessBottomSheet extends StatelessWidget {
  const DrugRquestSuccessBottomSheet({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: MediaQuery.of(context).size.height*.40,
      decoration: BoxDecoration(
     borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(25),
                    topStart: Radius.circular(25),
                  ),
                  color: Colors.white
),  child: Container(
        padding: 
        EdgeInsets.symmetric(vertical: 16, horizontal: 16),
child: Column(children: [

Center(
  child: Container(
    padding: EdgeInsets.all(40),
  decoration: BoxDecoration(
    shape: BoxShape.circle ,color: AppColors.SPLASH_COLOR ,
image: DecorationImage(image: AssetImage('assets/images/png/verification step-3.png'))
  ),
  // child: Center(child: Image.asset('assets/images/'    ),),
  ),
),

SizedBox(height: 20,),
Center(
  child: Text('${tr('request_added')}',
  textAlign: TextAlign.justify
   ,style: TextStyle(color: Colors.green ,
  
  fontWeight: FontWeight.bold
  ),),
) ,
SizedBox(height: 10,),
Center(
  child: Text('${tr('thanks_for_order')}',
  textAlign: TextAlign.center
   ,style: Theme.of(context).textTheme.bodyMedium,),
) ,
Spacer() ,


 MyButton(
           title: '${tr('go_home_btn')}',
           
           color: Colors.green,
           onTap: (){
             Get.to(DashboardPage());
           },
         )
         
]),

)
    );
  }
}
import 'package:aafia/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({ Key? key }) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: AppColors.ONBACKGROUND,
        appBar: AppBar(
        elevation: 0,backgroundColor: Colors.transparent ,

leading: IconButton(onPressed: (){

  Get.back();
}, icon: Icon(
  Icons.arrow_back_ios , color: Colors.black,
)),
centerTitle: true,
title: Text(tr('about') ,style: TextStyle(
  color: Theme.of(context).primaryColor ,
  fontSize: 15,fontWeight: FontWeight.w500
),),


      ),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
      
      SizedBox(height: 27,),
            SizedBox(
              height: 209,
              width: 222,
              child: Image.asset('assets/images/png/Mobile Marketing-bro-1.png'),
            ),

               
      SizedBox(height: 9,),
            Expanded(child: 
            
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: 15 ,

                horizontal: 20
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(
                    20
                  )
                )
              ),
              child: Column(
                

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 88,
                    child: Text('${tr('about_offers')}' ,
                                textAlign: TextAlign.justify,
                                maxLines: 6,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13,fontWeight: FontWeight.w400
                                ),
                                ),
                  )
                  
                  ,
                  SizedBox(height:10 ,),
                  Expanded(
                    child:ListView(
                      children: [




AboutWidget(
  img: 'assets/images/png/svgexport-11 (2).png',
  title: tr('blood_service'),
) ,



AboutWidget(
  img: 'assets/images/png/medicine-1.png',
  title: tr('drug_service'),
) ,



AboutWidget(
  img: 'assets/images/png/Ambulance.png',
  title: tr('ambulance_service'),
) ,










                      ],
                    )
                  )
                  
              ],),
            )
            
            )
          ],
        ),
      ),
      
    );
  }
}




class AboutWidget extends StatelessWidget {
  final String? title;
 final String? img;
   AboutWidget({ Key? key, this.title, this.img }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 103,
      width: double.infinity,
      margin: EdgeInsets.only(
        // left: 15 ,right: 15,
        bottom: 8
      ),
padding: EdgeInsets.fromLTRB(6, 19, 13, 10),

      decoration: BoxDecoration(
        color: AppColors.ONBACKGROUND ,

        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [

Container(
  // padding: EdgeInsets.all(10),
height: 50,
  decoration: BoxDecoration(
    shape: BoxShape.circle,color: Colors.white
  ),
  child: Center(
    child: Image.asset(img!, height: 33 ,width: 45,),
  ),
) ,

SizedBox(width: 10,),
Expanded(child: 
SizedBox(
  height: 72,
  child:   Text(title! , 
  
  style: TextStyle(
    fontWeight: FontWeight.w400 ,fontSize: 14
  ),
   overflow:
    TextOverflow.ellipsis,textAlign: TextAlign.justify,
    maxLines: 10,
    
    
    ),
)

)
        ],
      ),
      
    );
  }
}



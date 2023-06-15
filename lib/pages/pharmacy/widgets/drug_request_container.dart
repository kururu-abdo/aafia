import 'package:aafia/pages/pharmacy/image_page.dart';
import 'package:aafia/pages/pharmacy/widgets/comment_bottomsheet.dart';
import 'package:aafia/utils/colors.dart';
import 'package:aafia/widgets/my_Button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrugRequestWidget extends StatelessWidget {
  final String? drugName;
 final String?   drugImage;
 final  String?  insurranceImage;


 
  const DrugRequestWidget({ Key? key, this.drugName, this.drugImage, this.insurranceImage }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    width: double.infinity, 
     height: MediaQuery.of(context).size.height/3,
  margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
BoxShadow(
  color: AppColors.SPLASH_COLOR,
  blurRadius: 10,
  offset: Offset(0, -1)

) ,

BoxShadow(
  color: AppColors.SPLASH_COLOR,
  blurRadius: 10,
  offset: Offset(-1, 0)

)
      ]
    ),



child: Column(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  crossAxisAlignment: CrossAxisAlignment.start,

  children: [

Row(
  mainAxisAlignment: MainAxisAlignment.start,
  mainAxisSize: MainAxisSize.min,

  children: [
Container(

  padding: EdgeInsets.all(15),
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: AppColors.SPLASH_COLOR
  ),
child: Center(
  child: Image.asset('assets/images/png//medicine-1.png'),
),
),

SizedBox(width: 6,) ,

Text(drugName! , style: TextStyle(
  fontWeight: FontWeight.w400,fontSize: 14
),)




  ],
)





,


Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [




GestureDetector(
  onTap: (){
    Get.to(()=>ImagePage(
      title: 'روشتة الدواء',
      image: drugImage,
    ));
  },
  child:   Row(
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
  
    children: [
  Container(
    
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: AppColors.SPLASH_COLOR
    ),
  child: Center(
    child: Icon(Icons.edit_document ,
    color: Theme.of(context).primaryColor,
    )
  ),
  ),
  
  SizedBox(width: 6,) ,
  
  Text('الروشتة' , style: TextStyle(
    
    fontWeight: FontWeight.bold
  ),)
  
  
  
  
    ],
  ),
)


,






GestureDetector(
   onTap: (){
    Get.to(()=>ImagePage(
      title: 'صورة التأمين',
      image: insurranceImage,
    ));
  },
  child:   Row(
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
  
    children: [
  Container(
    
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: AppColors.SPLASH_COLOR
    ),
  child: Center(
    child: Icon(Icons.edit_document ,
    color: Theme.of(context).primaryColor,
    )
  ),
  ),
  
  SizedBox(width: 6,) ,
  
  Text('صورة التأمين' , style: TextStyle(
    
    fontWeight: FontWeight.bold
  ),)
  
  
  
  
    ],
  ),
)


  ],
)

 ,


 MyButton(
  onTap: ()async{

showModalBottomSheet(context: context, 
isScrollControlled: true,
  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(25),
                    topStart: Radius.circular(25),
                  ),
                ),
builder: (_) 
=>CommentBottomSheet(
  
  Size(
  MediaQuery.of(context).size.height,
    MediaQuery.of(context).size.width,

), (p0) => null)
);

  },
  title: 'الرد على الطلب',
isLoading: false,
  color: Theme.of(context).primaryColor,
 ) ,


  ],
),













    );
  }
}
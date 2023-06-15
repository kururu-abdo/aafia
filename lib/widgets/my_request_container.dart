import 'package:aafia/data/models/response/drugResponsePagination.dart';
import 'package:aafia/pages/pharmacy/image_page.dart';
import 'package:aafia/utils/colors.dart';
import 'package:aafia/utils/enum_string.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';
import 'package:aafia/utils/global.dart' as global;
enum RequestStatus {
Completed('Completed') ,Canceled('Cancelled'),Underway('Underway');
final String? name;

const 
RequestStatus(this.name);
}




class MedicationRequestContainer extends StatelessWidget {
  final RequestStatus? requestStatus;
  final String? medicineName;
  final Data?  drugData;
  final Function(int)? onDelete;
  final Function(Data)? onEdit;
  const MedicationRequestContainer({ Key? key, this.requestStatus, this.medicineName, this.drugData, this.onDelete, this.onEdit }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Slidable(


  key:  ValueKey(int.parse(drugData!.id!.toString())),

  // The start action pane is the one at the left or the top side.
  startActionPane: ActionPane(
    dragDismissible: false,
    // A motion is a widget used to control how the pane animates.
    motion: const ScrollMotion(),

    // A pane can dismiss the Slidable.
    dismissible: DismissiblePane(onDismissed: () {
      
    }),

    // All actions are defined in the children parameter.
    children:  [
      // A SlidableAction can have an icon and/or a label.
      SlidableAction(
        onPressed: (ctx){
onDelete!(drugData!.id!);
        },
        backgroundColor: Color(0xFFFE4A49),
        foregroundColor: Colors.white,
        icon: Icons.delete,
        label: '${tr('delete_btn')}',
      ),
      SlidableAction(
        onPressed: (context){
onEdit!(drugData!);
        },
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        icon: Icons.edit,
        label: '${tr('edit_btn')}',
      ),
    ],
  ),


      child: DropShadow(
        blurRadius: 7,
        color: AppColors.SHADOW_COLOR,
        offset: Offset(0, 0),
        child: Container
        (
    
          margin: EdgeInsets.only(
    
    
            bottom: 18
          ),
            // margin: EdgeInsets.only(right: 30),
      // height: 205,
      width:double.infinity,
          decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      // boxShadow: [
      //   BoxShadow(
      //   color: Colors.grey[300]!,
      //   blurRadius: 5,
      //   spreadRadius: 1,
      //   offset: Offset(-0.5 ,0)
      //   )
      // ]
          ),
      
      
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
      
      
       Container(
      width:double.infinity,
      height: 58,
       padding: EdgeInsets.symmetric(
         horizontal: 15 ,vertical: 17
       ),
       
       
         decoration: BoxDecoration(
       color: Colors.white,
       borderRadius: BorderRadius.circular(10),
       boxShadow: [
       BoxShadow(
       blurRadius: 7,
        color: AppColors.SHADOW_COLOR,
        offset: Offset(0, 0),
       )
       ]
         ) ,
       child:   Center(
         child: Row(
           crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Row(
             mainAxisSize: MainAxisSize.min,
             children: [
                   Container(
             padding: EdgeInsets.all(6),
           
             decoration: BoxDecoration(
               shape: BoxShape.circle,
               color: AppColors.ONBACKGROUND
             ),
             
             child: Center(
               child: Image.asset('assets/images/png/medicine-1.png',
               height: 19,width: 19,
               )
             ),),
         
         SizedBox(
           width: 5,
         ) ,
         
         Text(drugData!.drugName! ,
         
         style: TextStyle(
           fontWeight: FontWeight.w400,fontSize: 14
         ),
         
         ) ,
         
         
             ],
           ) ,
         // SizedBox(
         //   width: 5,
         // ) ,
         
         
         
         
          Container(
           // padding: EdgeInsets.all(10),
           width: 82,
         height: 26,
           decoration: BoxDecoration(
             color: getWidgetThemeColor().withOpacity(.05) ,
         
             borderRadius: BorderRadius.circular(13)
           ),
           child: Center(
             child: Text(
               
               requestStatus!.toShortString()
                , style: TextStyle(
               color:getWidgetThemeColor() , fontWeight: FontWeight.w400,fontSize: 13
             ),),
           ),
         ),
         ],
         ),
       ),
       )
      
      ,
      Container(
       padding: EdgeInsets.symmetric(
         horizontal: 15 ,vertical: 17
       ),
      child: Column(
        children: [
      SizedBox(height: 15,),
      Row(
        children: [
      
      
            Container(
      height: 30,
        width: 30,
        padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.ONBACKGROUND
          ),
          
          child: Center(
            child: Icon(Icons.location_on ,
        color: Theme.of(context).primaryColor,
        
        ),
          ),),
      SizedBox(width: 5,),
      
          Text.rich(
            TextSpan(
              text: '${'${tr('search_area')}'}: ' ,
              style: TextStyle(
                color: Color(0xFF020202).withOpacity(.7),
    
                fontSize: 13,fontWeight: FontWeight.w400
    
    
              ),
              children: [
                 TextSpan(
              text: 'Khartoum' ,
              style: TextStyle(color: Colors.black,
                fontSize: 14,fontWeight: FontWeight.w400
              ),
                 )
              ]
            ),
      
          )
        
      
        ])
        ,
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
        SizedBox(height: 15,),
      Row(
        children: [
      
      
            Container(
         height: 30,
        width: 30,
        padding: EdgeInsets.all(4),
        
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.ONBACKGROUND
          ),
          
          child: Center(
            child: Icon(Icons.location_on ,
        color: Theme.of(context).primaryColor,
        
        ),
          ),),
      SizedBox(width: 5,),
      
          Text.rich(
            TextSpan(
              text: '${'${tr('address_drug')}'}: ' ,
              style: TextStyle(
                // color: Colors.grey
             color: Color(0xFF020202).withOpacity(.70) ,
    
                fontSize: 13,fontWeight: FontWeight.w400
              ),
              children: [
                 TextSpan(
              text: 'Khartoum , Bahri' ,
              style: TextStyle(
                color: Colors.black ,
                fontSize: 14,fontWeight: FontWeight.w400
                // color: Colors.grey
              ),
                 )
              ]
            ),
      
          )
        
      
        ])
      ,
      
        SizedBox(height: 15,),
      
      
      
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      
        children: [
      
      GestureDetector(
        onTap: (){
        Get.to(()=>ImagePage(
          title: '${'${tr('prescription')}'}',
          image: global.configModel.imagesUrl!+"/"+drugData!.image ,
        ));
        },
        child:   Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        
        children: [
        Container(
      height: 30,
        width: 30,
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.ONBACKGROUND
        ),
        child: Center(
        child: Icon(Icons.edit_document ,
        color: Theme.of(context).primaryColor,
        )
        ),
        ),
        
        SizedBox(width: 6,) ,
        
        Text( '${'${tr('prescription')}'}' , style: TextStyle(
        decoration: TextDecoration.underline,
      fontWeight: FontWeight.w400,fontSize: 14
        ),)
        
        
        
        
        ],
        ),
      )
      
      
      ,
      
      
      
      
      
      
      GestureDetector(
         onTap: (){
           if (drugData!.insuranceImage!=null) {
               Get.to(()=>ImagePage(
          title: '${'${tr('insurrance')}'}',
          image: global.configModel.imagesUrl!+"/"+drugData!.insuranceImage ,
        ));
           }
     
        },
        child:   Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        
        children: [
        Container(
        height: 30,
        width: 30,
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.ONBACKGROUND
        ),
        child: Center(
        child: Icon(Icons.edit_document ,
        color: Theme.of(context).primaryColor,
        )
        ),
        ),
        
        SizedBox(width: 6,) ,
        
        Text( '${'${tr('insurrance')}'}' , style: TextStyle(
            decoration: TextDecoration.underline,
    
      
        fontWeight: FontWeight.w400,fontSize: 14
        ),)
        
        
        
        
        ],
        ),
      )
      
      
      
        ])
      
        ],
      ),
      )
      
      
      
            ]),
        ),
      ),
    )
    
    ;
  }

  Color getWidgetThemeColor(){
    if ( requestStatus!.toShortString()=="Underway") {
      return Color(0xFF3D6DEF);
    }else if (requestStatus!.toShortString()=="Completed") {
       return Color(0xFF148F46);
    }else{
       return Color(0xFFFF3838);
       ;
    }
  }
}





class MedicationRequestContainerShimmer extends StatelessWidget {
 
  const MedicationRequestContainerShimmer({ Key? key,  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container
    (
      margin: EdgeInsets.all(10),
        // margin: EdgeInsets.only(right: 30),
height: MediaQuery.of(context).size.height/3,
width: double.infinity,
      decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(10),
boxShadow: [
  BoxShadow(
    color: Colors.grey[300]!,
    blurRadius: 5,
    spreadRadius: 1,
    offset: Offset(-0.5 ,0)
  )
]
      ),


      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


Container(
  width: double.infinity,

  padding: EdgeInsets.all(10),

      decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(10),
boxShadow: [
  BoxShadow(
    color: Colors.grey[300]!,
    blurRadius: 5,
    spreadRadius: 1,
    offset: Offset(1 ,-0.5)
  )
]
      ) ,
  child:   Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          SkeletonAvatar(
            style: SkeletonAvatarStyle(
              width: 25,height: 25
            ),
          )
            ,
    
    SizedBox(
      width: 5,
    ) ,
  
   SkeletonLine(
     style: SkeletonLineStyle(
       width: 50 ,height: 10 ,borderRadius: BorderRadius.circular(10)
     ),
   ) ,
  
  
        ],
      ) ,
    // SizedBox(
    //   width: 5,
    // ) ,
  
   SkeletonLine(
     style: SkeletonLineStyle(
       width: 100 ,height: 50 ,borderRadius: BorderRadius.circular(50)
     ),
   ) ,
  
  
   
    ],
  ),
)

,
Container(
    padding: EdgeInsets.all(10),
child: Column(
  children: [
SizedBox(height: 15,),
Row(
  children: [


        SkeletonAvatar(
            style: SkeletonAvatarStyle(
              width: 25,height: 25
            ),
          ),
SizedBox(width: 5,),

    SkeletonLine(
     style: SkeletonLineStyle(
       width: 50 ,height: 10 ,borderRadius: BorderRadius.circular(10)
     ),
   ) ,

  ])
  ,
















  SizedBox(height: 15,),
Row(
  children: [


         SkeletonAvatar(
            style: SkeletonAvatarStyle(
              width: 25,height: 25
            ),
          )
      
      ,
SizedBox(width: 5,),

    SkeletonLine(
     style: SkeletonLineStyle(
       width: 50 ,height: 10 ,borderRadius: BorderRadius.circular(10)
     ),
   ) ,
  ])
,

  SizedBox(height: 15,),



Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,

  children: [

GestureDetector(
  onTap: (){
    // Get.to(()=>ImagePage(
    //   title: 'روشتة الدواء',
    //   image: drugImage,
    // ));
  },
  child:   Row(
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
  
    children: [
   SkeletonAvatar(
            style: SkeletonAvatarStyle(
              width: 25,height: 25
            ),
          ),
  
  SizedBox(width: 6,) ,
  
 SkeletonLine(
     style: SkeletonLineStyle(
       width: 50 ,height: 10 ,borderRadius: BorderRadius.circular(10)
     ),
   ) ,
  
  
  
  
    ],
  ),
)


,






GestureDetector(
   onTap: (){
    // Get.to(()=>ImagePage(
    //   title: 'صورة التأمين',
    //   image: insurranceImage,
    // ));
  },
  child:   Row(
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
  
    children: [
   SkeletonAvatar(
            style: SkeletonAvatarStyle(
              width: 25,height: 25
            ),
          ),
  
  SizedBox(width: 6,) ,
  
   SkeletonLine(
     style: SkeletonLineStyle(
       width: 50 ,height: 10 ,borderRadius: BorderRadius.circular(10)
     ),
   ) ,
  
  
  
  
    ],
  ),
)



  ])

  ],
),
)



        ]),
    )
    
    ;
  }


}
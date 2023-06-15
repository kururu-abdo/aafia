
import 'package:aafia/data/models/response/current_user.dart';
import 'package:aafia/pages/blood_transition_page.dart';
import 'package:aafia/pages/contact_us.dart';
import 'package:aafia/pages/drug_requests.dart';
import 'package:aafia/pages/edit_my_data_page.dart';
import 'package:aafia/pages/medical_request.dart';
import 'package:aafia/pages/notifications.dart';
import 'package:aafia/pages/search_for_ambulance_page.dart';
import 'package:aafia/services/firebase_notification_service.dart';
import 'package:aafia/utils/colors.dart';
import 'package:aafia/widgets/carousel_widget.dart';
import 'package:aafia/widgets/toast.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aafia/utils/global.dart' as global;
      ValueNotifier<CurrentUser> userValue =ValueNotifier(global.currentUser!);

class HomePAge extends StatefulWidget {
  const HomePAge({ Key? key }) : super(key: key);

  @override
  _HomePAgeState createState() => _HomePAgeState();
}

class _HomePAgeState extends State<HomePAge> {
CarouselController? _carouselController;
   int _currentIndex = 0;
var _bannerIitems=[
  {
    "image":"assets/images/png/Home image-10.png"
  },
  {
    "image":"assets/images/png/Home image-10.png"
  },
  {
    "image":"assets/images/png/Home image-10.png"
  }
];

List<Widget> _bannerItems() {
    List<Widget> list = [];
    for (int i = 0; i < _bannerIitems.length; i++) {
      list.add(InkWell(
        onTap: () {
          // Get.to(() => ProductListScreen(
          //       a: widget.analytics,
          //       o: widget.observer,
          //       categoryId: _homeScreenData?.banner[i].catId,
          //       screenId: 0,
          //       categoryName: _homeScreenData?.banner[i].title,
          //     ));
        },
        child: 
      Image.asset(_bannerIitems[i]['image']!)
        // CachedNetworkImage(
        //   imageUrl: global.appInfo!.imageUrl! +
        //       _homeScreenData!.banner[i].bannerImage!,
        //   imageBuilder: (context, imageProvider) => Container(
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        //     ),
        //   ),
        //   placeholder: (context, url) =>
        //       Center(child: CircularProgressIndicator()),
        //   errorWidget: (context, url, error) => Container(
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(15),
        //       image: DecorationImage(
        //           image: AssetImage('assets/images/icon.png'),
        //           fit: BoxFit.cover),
        //     ),
        //   ),
        // ),
     
     
     
      ));
    }
    return list;
  }
@override
void initState() { 
  super.initState();
  
  FirebaseNotificationsService().init();
  // FirebaseNotificationsService
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30 ,vertical: 20
        ),
        child:
         Column(
          crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    
    SizedBox(height: 20,),
      Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
    Row(
      mainAxisSize: MainAxisSize.min,
      children: [
      GestureDetector(
        onTap: (){
                     Get.to(EditMyDataPage());

        },
        child: Container(
          // padding: EdgeInsets.all(8),
          width: 40,height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).primaryColor.withOpacity(.3),
            
          ),
          child: Center(child: Icon(Icons.person,    color: Theme.of(context).primaryColor  ),),
        ),
      ),
    SizedBox(width: 5,),

    ValueListenableBuilder(
  valueListenable: userValue,
  builder: ( context, user, child){
       return 
      Text.rich(TextSpan(
        text:
        '${tr('welcome')}  '
        ,
    
    style: TextStyle(
      color: Colors.black ,fontWeight: FontWeight.w400 ,
fontSize: 14
    
    )  ,
    
    
    children: [
      TextSpan(
        text:
        '${global.currentUser!.name}'
        ,
    style: TextStyle(
   color: Colors.black ,fontWeight: FontWeight.w400 ,
fontSize: 14
    )  ,
     )
    ]
      ),
      
      
      );
      
      }
)


      
      
      ],
    )  ,
    
    IconButton(onPressed: (){
    Get.to(()=>NotificationsPage());
    }, icon: Icon(Icons.notifications ,size: 24,))
      ],
      ),
    SizedBox(
      height: MediaQuery.of(context).size.height/5,
      child: 
      // Stack(children: [
    
    CarouselWidget(),
    
                                          
                                  //              Container(
                                  // width: MediaQuery.of(context).size.width,
                                  // height: MediaQuery.of(context).size.height * 0.15,
                                  // child:CarouselSlider(
                                  //         items: _bannerItems(),
                                  //         carouselController: _carouselController,
                                  //         options: CarouselOptions(
                                  //             viewportFraction: 0.95,
                                  //             initialPage: _currentIndex,
                                  //             enableInfiniteScroll: true,
                                  //             reverse: false,
                                  //             autoPlay: true,
                                  //             autoPlayInterval:
                                  //                 Duration(seconds: 3),
                                  //             autoPlayAnimationDuration:
                                  //                 Duration(milliseconds: 800),
                                  //             autoPlayCurve: Curves.fastOutSlowIn,
                                  //             enlargeCenterPage: true,
                                  //             scrollDirection: Axis.horizontal,
                                  //             onPageChanged: (index, _) {
                                  //               _currentIndex = index;
                                  //               setState(() {});
                                  //             })),
                                          
                                  //         ),
    
    
    
    
    
    
    
    
    
    
    
    
    
    //     Image.asset(
    //       "assets/images/png/Home image-10.png",
    //  height: MediaQuery.of(context).size.height/5,
    //       width: double.infinity,
    //     ),
    
    
    
    
      //   Align(alignment: Alignment.center,
      //   child: Text('sdf;ksd;')
      //   ,)
      // ],),
    )
    
    ,
    SizedBox(height: 35,),
    Text('${tr('services')}' ,
    style: Theme.of(context).textTheme.headline5!.copyWith(
      fontWeight: FontWeight.w500 ,fontSize: 16
    ),
    )
    
    ,
      SizedBox(height: 22,),
    Expanded(child: 
    Column(
    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
    
    
    DropShadow(
      offset: Offset(0, 0),
      color: AppColors.SHADOW_COLOR,
      blurRadius: 7,
      child: Container(
height: 134,
// width: 315,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10) ,color: Colors.white
        ),
        child: GestureDetector(
          onTap: (){
          Get.to(()=>BloodTransitionPage());
          },
          child:   Container
          (
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width-100,
          child: Row(
          
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          
          Container(
            height: 100,
            width: 100, 
            padding: EdgeInsets.all(20),

            decoration: BoxDecoration(

              color: AppColors.TEXT_FILLED_COLOR ,
              shape: BoxShape.circle
            ),
            
            child: Center(child: Image.asset('assets/images/png/svgexport-11 (2).png' ,))) ,
          SizedBox(width: 10,),
          Text('${tr('blood_transfer_service')}' ,style: TextStyle(
            fontSize: 16  , fontWeight: FontWeight.w500
          ))
          ],
          
          
          ),),
        ),
      ),
    )
    
    ,
    
          SizedBox(height: 22,),

    Container
    (
    //   padding: EdgeInsets.all(10),
    
    // width: MediaQuery.of(context).size.width-100,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    
      children: [
    
    InkWell(
      onTap: (){
      Get.to(()=>MedicalRequestPage());
      },  child:  DropShadow(
      offset: Offset(0, 3),
      color: AppColors.SHADOW_COLOR,
      blurRadius: 6,
      child: Container(padding: EdgeInsets.symmetric(
  vertical: 4,horizontal: 25
),
height: 150,
// width: MediaQuery.of(context).size.width/2-50,

// , 

decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10) ,color: Colors.white
        ),
child: Center(
        child: Column(
        children: [
       Container(
            height: 100,
            width: 100, 
            padding: EdgeInsets.all(20),

            decoration: BoxDecoration(

              color: AppColors.TEXT_FILLED_COLOR ,
              shape: BoxShape.circle
            ),
          
          
          child: Center(child: Image.asset("assets/images/png/medicine2.png",))),
        SizedBox(height: 10,),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${tr('medicine_request')}' ,style: TextStyle(
                fontSize: 14,fontWeight: FontWeight.w500
              )),Text(
              "(5)" ,style: TextStyle(
                fontSize: 14,fontWeight: FontWeight.w500
              ),
             )
          ],
        )
        
        
        ],
        ),
      ),))
    ) ,
    
    
    GestureDetector(
      onTap: (){
      Get.to(()=>SearchFormAmbulancePage());
      },
      child:   DropShadow(
      offset: Offset(0, 3),
      color: AppColors.SHADOW_COLOR,
      blurRadius: 6,
      child: Container(
height: 150,
// width: 150, 
// width: MediaQuery.of(context).size.width/2-100,

padding: EdgeInsets.symmetric(
  vertical: 4,horizontal: 25
),

decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10) ,color: Colors.white
        ),
child: 
        Column(
        children: [
        Container(
            height: 100,
            width: 100, 
            padding: EdgeInsets.all(20),

            decoration: BoxDecoration(

              color: AppColors.TEXT_FILLED_COLOR ,
              shape: BoxShape.circle
            ),
          
          child: Center(child: Image.asset("assets/images/png/medicine2.png" ))),
        SizedBox(height: 10,),
        Text('${tr('ambulance_request')}' ,style: TextStyle(
                fontSize: 14,fontWeight: FontWeight.w500
              ))
        
        
        ],
        ),
      ),
      )
    )
    
    
    
    
    
    
      ],
    ),
    )
    
    
    
    
      ],
    )
    
    )
    
    ],
    
    
        ),
      ),
    );
  }
}
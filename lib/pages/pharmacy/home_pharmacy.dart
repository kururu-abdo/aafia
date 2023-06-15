import 'package:aafia/base/base.dart';
import 'package:aafia/pages/notifications.dart';
import 'package:aafia/pages/pharmacy/all_drug_requests.dart';
import 'package:aafia/pages/pharmacy/pharmacy_notifications.dart';
import 'package:aafia/pages/pharmacy/widgets/drug_request_container.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeParmacy extends BaseRoute {
   HomeParmacy({ Key? key }) : super(r: 'HomePharmacy');

  @override
  _HomeParmacyState createState() => _HomeParmacyState();
}

class _HomeParmacyState extends BaseRouteState {

  CarouselController? _carouselController;
   int _currentIndex = 0;


   var requests =[
     {

       'name':'X-ray sdfsdf' ,
       'image':'assets/images/png/medicine-1.png',
       'insurance':'assets/images/png/medicine-1.png',
     } ,

      {

       'name':'X-ray sdfsdf' ,
       'image':'assets/images/png/medicine-1.png',
       'insurance':'assets/images/png/medicine-1.png',
     },
      {

       'name':'X-ray sdfsdf' ,
       'image':'assets/images/png/medicine-1.png',
       'insurance':'assets/images/png/medicine-1.png',
     } ,
      {

       'name':'X-ray sdfsdf' ,
       'image':'assets/images/png/medicine-1.png',
       'insurance':'assets/images/png/medicine-1.png',
     } ,

      {

       'name':'X-ray sdfsdf' ,
       'image':'assets/images/png/medicine-1.png',
       'insurance':'assets/images/png/medicine-1.png',
     } , {

       'name':'X-ray sdfsdf' ,
       'image':'assets/images/png/medicine-1.png',
       'insurance':'assets/images/png/medicine-1.png',
     }
   ];




var _bannerIitems=[
  {
    "image":"assets/images/png/HomeImage.png"
  },
  {
     "image":"assets/images/png/HomeImage.png"
  },
  {
     "image":"assets/images/png/HomeImage.png"
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
  Widget build(BuildContext context) {
     return Padding(
      padding: const EdgeInsets.all(15.0),
      child:
       Column(
        crossAxisAlignment: CrossAxisAlignment.start,
children: [

SizedBox(height: 15,),
  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).primaryColor.withOpacity(.5),
        
      ),
      child: Center(child: Icon(Icons.person,   color: Theme.of(context).primaryColor  ),),
    ),
SizedBox(width: 5,),
    Text.rich(TextSpan(
      text:
      'مرحبا  '
      ,

style: TextStyle(
  color: Colors.black ,fontWeight: FontWeight.bold
)  ,


children: [
  TextSpan(
      text:
      'صيدلية الامل'
      ,
style: TextStyle(
  color: Theme.of(context).primaryColor , fontWeight: FontWeight.bold
)  ,
 )
]
  ),
    
    
    )
  ],
)  ,

IconButton(onPressed: (){
Get.to(()=>PharmcyNotificationsPage());
}, icon: Icon(Icons.notifications))
    ],
  ),
SizedBox(
  height: MediaQuery.of(context).size.height/5,
  child: 
  // Stack(children: [

                                             Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 0.15,
                                child:CarouselSlider(
                                        items: _bannerItems(),
                                        carouselController: _carouselController,
                                        options: CarouselOptions(
                                            viewportFraction: 0.95,
                                            initialPage: _currentIndex,
                                            enableInfiniteScroll: true,
                                            reverse: false,
                                            autoPlay: true,
                                            autoPlayInterval:
                                                Duration(seconds: 3),
                                            autoPlayAnimationDuration:
                                                Duration(milliseconds: 800),
                                            autoPlayCurve: Curves.fastOutSlowIn,
                                            enlargeCenterPage: true,
                                            scrollDirection: Axis.horizontal,
                                            onPageChanged: (index, _) {
                                              _currentIndex = index;
                                              setState(() {});
                                            })),
                                        
                                        ),

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
SizedBox(height: 15,),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
        Text('طلبات الدواء الجديدة' ,
    style: Theme.of(context).textTheme.headline5!.copyWith(
      fontWeight: FontWeight.bold
    ),





    ),



    GestureDetector(
      onTap: (){
        Get.to(
          ()=> AllDrugRquestsPage()
        );
      },
      child: Text('عرض الكل' ,
      
      style: TextStyle(
    
    decoration: TextDecoration.underline,
    color: Theme.of(context).primaryColor ,
    
    fontWeight: FontWeight.bold
      )),
    )
  ],
),

Expanded(child: 


ListView(
  children: requests.map((e) => DrugRequestWidget( 
    drugName: e['name'],
    drugImage: e['image'],
    insurranceImage: e['insurance'],
  )).toList(),
)

)

,


],


      ),
    );
  }
}
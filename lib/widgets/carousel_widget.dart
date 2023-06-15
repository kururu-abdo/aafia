import 'package:aafia/utils/colors.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({ Key? key }) : super(key: key);

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
       CarouselController carouselController = CarouselController();
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
      Container(child: Image.asset(_bannerIitems[i]['image']!))
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
    return Container(
                                      // height:190,

      child: 
      
      Column(
mainAxisAlignment: MainAxisAlignment.center


,
    children: [

      
           CarouselSlider(
  options: CarouselOptions(
    height: 150.0 ,
    // aspectRatio: 12/9,
      // viewportFraction: 0.8,
      initialPage: 0,
      // enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
    onPageChanged: (index, _) {
                         _currentIndex = index;
                         setState(() {});
                       }
  
  ),
  items:
  
_bannerItems().map((e) => e).toList()
),
      
      
           
    
    


      SizedBox(height: 8,),

    Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ...List.generate(
             _bannerIitems.length,
              (index) => Container(
                margin: EdgeInsets.all(5),
                height: 8,width: _currentIndex == index?20:8,
                decoration: BoxDecoration(
                  borderRadius:  _currentIndex == index?
                  
                  BorderRadius.circular(50):null,
                  shape: _currentIndex == index?BoxShape.rectangle : BoxShape.circle,
 color: _currentIndex == index
                    ?Theme.of(context).primaryColor
                    : AppColors.TEXT_FILLED_COLOR
                ),
              ),
               
              
            )
          ],
        )
    
      ]  ),
                    //  )
                     ) ;
      
      
    
  }
}
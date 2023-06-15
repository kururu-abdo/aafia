import 'package:aafia/base/base.dart';
import 'package:flutter/material.dart';

class AdvertisementsPage extends BaseRoute {
   AdvertisementsPage({ Key? key }) : super(r: 'Advs');

  @override
  _AdvertisementsPageState createState() => _AdvertisementsPageState();
}

class _AdvertisementsPageState extends BaseRouteState {


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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
        elevation: 0, 
        backgroundColor: Colors.transparent,
        title: Text('الاعلانات' , style: TextStyle(
          color:Colors.black
        ),), 
centerTitle: true,

      ),
      
      body: _bannerIitems.length<1?
      Center()
      :

      ListView(
        children: _bannerIitems.map((e) => 
      Container(

        height: MediaQuery.of(context).size.height/4,
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal: 15 ,vertical: 6
        ),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
        
        image: DecorationImage(image: 
        AssetImage(e['image']! ,
        
        ) ,fit: BoxFit.cover
        
        )
        ),
      )
        
        ).toList(),
      )
      
      ,
    );
  }
}
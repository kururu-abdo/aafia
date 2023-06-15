import 'package:aafia/base/base.dart';
import 'package:aafia/pages/pharmacy/widgets/drug_request_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllDrugRquestsPage extends BaseRoute {
   AllDrugRquestsPage({ Key? key }) : super(r: 'DrugRequests');

  @override
  _AllDrugRquestsPageState createState() => _AllDrugRquestsPageState();
}

class _AllDrugRquestsPageState extends BaseRouteState{


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



  @override
  Widget build(BuildContext context) {
    return Scaffold(



      appBar: AppBar(

        title: Text('طلبات دواء جديدة' ,
        
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold ,fontSize: 20
        ),
        ),
        centerTitle: true,
        elevation: 0, 
        backgroundColor: Colors.transparent,

leading: IconButton(onPressed: (){
Get.back();

}, icon: Icon(Icons.arrow_back_ios , color: Colors.black,)),

      ),


body: Container(padding: 
EdgeInsets.symmetric(horizontal: 20 ,)

,child: 


ListView(
  children: requests.map((e) => DrugRequestWidget( 
    drugName: e['name'],
    drugImage: e['image'],
    insurranceImage: e['insurance'],
  )).toList(),
)

),
      
    );
  }
}
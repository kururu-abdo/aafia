import 'dart:convert';
import 'dart:developer';

import 'package:aafia/base/base.dart';
import 'package:aafia/data/models/base/page_mode.dart';
import 'package:aafia/pages/add_bloodtransition_dontation.dart';
import 'package:aafia/pages/all_drug_requests.dart';
import 'package:aafia/pages/blood_transition.dart';
import 'package:aafia/pages/cancelled_drug_requests.dart';
import 'package:aafia/pages/confirmed_requests.dart';
import 'package:aafia/pages/dontation_request_page.dart';
import 'package:aafia/pages/medical_request.dart';
import 'package:aafia/pages/pending_drug_requests.dart';
import 'package:aafia/pages/pharmacy/all_drug_requests.dart';
import 'package:aafia/pages/volunteer_requests_page.dart';
import 'package:aafia/utils/app_constants.dart';
import 'package:aafia/utils/colors.dart';
import 'package:aafia/widgets/decision_alert.dart';
import 'package:aafia/widgets/my_request_container.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:skeletons/skeletons.dart';
import '../data/models/response/drugResponsePagination.dart';
import '../data/models/response/drugResponsePagination.dart' as drug;
import '../data/models/response/blood_tranfer_pagination.dart' as blood;

import '../.././utils/global.dart' as global;
class MyRequestPage extends BaseRoute {
   MyRequestPage({ Key? key }) : super(r: 'MyRequests');

  @override
  _MyRequestPageState createState() => _MyRequestPageState();
}

class _MyRequestPageState extends BaseRouteState {



  final _scafolkey = GlobalKey<ScaffoldState>();


 var uri = '${global.url}user/drug-requests';
  var pendingUri = '${global.url}user/drug-requests/pending';

  var nexturl;
    var nextPendingurl;

  // ScrollController _scrollController = new ScrollController();


  ScrollController _pendingScrollController = new ScrollController();







  List<drug.Data> tempList = [];
  List<drug.Data> pendingList = [];






  //determine if all data has been recieved
  var loadCompleted = false;
    var pendingCompleted = false;



















  @override
  void initState() {
    
    super.initState();
  
  
//     scrollindecator();
// scrollCancelledindecator();
// scrollConfirmedindecator();

  
  }







/*

SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FutureBuilder(
              future: data,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  //if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.length ?? 0,
                      itemBuilder: (BuildContext contex, int index) {
                        if (index == snapshot.data.length - 1 &&
                            !loadCompleted) {
                          return Center(
                            child: new Opacity(
                              opacity: 1.0,
                              child: new CircularProgressIndicator(),
                            ),
                          );
                        } else {
                          return ListTile(
                            leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                child:
                                    Text(snapshot.data[index].id.toString())),
                            title: Text(snapshot.data[index].name),
                            subtitle: Text(snapshot.data[index].email),
                            trailing: Icon(
                              Icons.info,
                              color: Colors.blue,
                            ),
                            onTap: () {
                              print(index);
                            },
                          );
                        }
                      }
                      //  },
                      );
                }
              },
            ),
          ],
        ),
      ),

      */













 


















bool _isMedicalRequestLoading=false;



// _initMedicalRequests()async{
//   try {
//     _isBloodRequestRequestLoading=true;
//     setState(() {
      
//     })
//     ;


//     // apiHelper.getDrugRequests(drugRequest_id)
//   } catch (e) {
//   }
// }

// _init()async{
//   try {
//    await  _initMedicalRequests();
//   } catch (e) {
//   }

// }

  GlobalKey<ScaffoldState>? _scaffoldKey1;

deleteBloodRequest(drugRequest_id)async{


  try {
    showOnlyLoaderDialog();
    apiHelper.deleteBloodRequest(drugRequest_id)
    .then((result) {
hideLoader();
if (result.data!=null) {
  showSnackBar(
                    key: _scaffoldKey1,
                    
                    snackBarMessage:
                    'Your Request deleted successfully' ,isSuccess: true);
} else {
  showSnackBar(
                    key: _scaffoldKey1,
                    
                    snackBarMessage:
                    result.message.toString() ,isSuccess: false);
}


    });


  } catch (e) {
     showSnackBar(
                    key: _scaffoldKey1,
                    
                    snackBarMessage:
                    e.toString() ,isSuccess: false);
  }
}




deleteMedicalRequest(drugRequest_id)async{


  try {
    showOnlyLoaderDialog();
    apiHelper.deleteDrugRequest(drugRequest_id)
    .then((result) {
hideLoader();
if (result.data!=null) {
  showSnackBar(
                    key: _scaffoldKey1,
                    
                    snackBarMessage:
                    'Your Request deleted successfully' ,isSuccess: true);
} else {
  showSnackBar(
                    key: _scaffoldKey1,
                    
                    snackBarMessage:
                    result.message.toString() ,isSuccess: false);
}


    });


  } catch (e) {
     showSnackBar(
                    key: _scaffoldKey1,
                    
                    snackBarMessage:
                    e.toString() ,isSuccess: false);
  }
}



  List titles=[
    
     Get.locale!.languageCode=="ar"?"طلبات الدواء":
    'Medication Requests',
     Get.locale!.languageCode=="ar"?"طلبات الدم":
  'Blood Requests'];
  // List taps=['Login' ,'Sign up'];
    List bloodTaps=[
      
       Get.locale!.languageCode=="ar"?"تلقي دم":
      'Blood Requests' 
    ,
    
     Get.locale!.languageCode=="ar"?"التبرع بالدم":
    'Blood Donation Requests'];

       List status=[
         
       Get.locale!.languageCode=="ar"?
       "الكل"   :
         
         'All' ,
          Get.locale!.languageCode=="ar"?
          "قيد التوصيل"
:         
         'Underway' ,
          Get.locale!.languageCode=="ar"?
          "مكتمل":
         
         'Completed' ,
          Get.locale!.languageCode=="ar"?
          "ملغي":
         
         
         'Canceled'];
int selectedBloodTap=0;
int selectedStatus=0;

int selectedTap=0;
int selectedPage=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey1,
      body: SafeArea(
        child: Padding(
          
          padding:   EdgeInsets.only(
        
        left: 30,right: 30
              ),
          child: Column(children: [
              
              
              Padding(padding: EdgeInsets.only(
        
       top: 30
              ),
              
              child: Center(
          child:   Container(
            height: 46,
            width: 315,
          
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
          color: AppColors.TEXT_FILLED_COLOR,
          ),
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: titles.map((e) => 
          GestureDetector(
            onTap: (){
              
          selectedTap=titles.lastIndexOf(e);
          setState(() {
            
          });
            },
            child: AnimatedContainer(
           curve: Curves.easeInCubic,
           width:315/2,
              height: 45,
          duration: 
            
            Duration(milliseconds: 350),
            
            decoration: BoxDecoration(
              
          color: e==titles[selectedTap]?
          Theme.of(context).primaryColor:AppColors.ONBACKGROUND,
              borderRadius:  e==titles[selectedTap]?BorderRadius.circular(10):null
            ),
            child: Center(
          child: Text(e,style: TextStyle(
              
            color:  e==titles[selectedTap]?Colors.white:Colors.black,

            fontSize: 14 ,fontWeight: FontWeight.w600
              
          ),),
            ),
            ),
          )
          
          
          ).toList(),
          
            )),
              ),
              
              ),
              
              SizedBox(height: 24,),
              
              
              Builder(
          builder: (context){
              
            if (selectedTap==1) {
             
          return Padding(
            padding: EdgeInsets.all(10),
              
              child: Center(
          child:   Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: bloodTaps.map((e) => 
          GestureDetector(
          onTap: (){
              
            selectedBloodTap=bloodTaps.lastIndexOf(e);
            setState(() {
          
            });
          },
          child: AnimatedContainer(
            margin: EdgeInsets.all(5),
             curve: Curves.elasticInOut,
            //  width:( MediaQuery.of(context).size.width*2/3)/2,
            height: 33,
            padding: EdgeInsets.symmetric(
              horizontal: 17,vertical: 8
            ),
            duration: 
          
          Duration(milliseconds: 350),
          
          decoration: BoxDecoration(
              
            color: e==bloodTaps[selectedBloodTap]?
            Theme.of(context).primaryColor:AppColors.ONBACKGROUND,
              borderRadius:  BorderRadius.circular(50)
          ),
          child: Center(
            child: Text(e,style: TextStyle(
              
          color:  e==bloodTaps[selectedBloodTap]?Colors.white:Colors.black,
              
            ),),
          ),
          ),
          )
          
          
          ).toList(),
          
          ),
              ),
              
              );
          
          
            }
          else{
              
           return Center(
          child:   Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // scrollDirection: Axis.horizontal,
          children: status.map((e) => 
          GestureDetector(
          onTap: (){
           
            selectedStatus=status.lastIndexOf(e);
            setState(() {
          
            });
          },
          child: AnimatedContainer(
            margin: EdgeInsets.all(5),
             curve: Curves.easeInCubic,
            //  width:( MediaQuery.of(context).size.width*2/3)/2,
            height: MediaQuery.of(context).size.height*.05,
            padding: EdgeInsets.symmetric(
              vertical: 8 ,horizontal: 13
            ),
            duration: 
          
          Duration(milliseconds: 350),
          
          decoration: BoxDecoration(
           
            color: e==status[selectedStatus]?
            Theme.of(context).primaryColor:
          AppColors.ONBACKGROUND,
           borderRadius: BorderRadius.circular(50)
           
            // e==status[selectedStatus]?BorderRadius.circular(50):null
          ),
          child: Center(
            child: Text(e,style: TextStyle(
           
          color:  e==status[selectedStatus]?Colors.white:Colors.black,
          fontSize: 14,fontWeight: FontWeight.w400
           
            ),),
          ),
          ),
          )
          
          
          ).toList(),
          
          ),
           );
          
          }
          },
              ),
              
              
              Builder(builder: (_){
              
              
          if (selectedTap==1) {
            
            
            if (selectedBloodTap==0) {
          //TAP0
             return 
             
           
           
           
           
            VolunteerRequestsPage();
             
             
          
            } else {
             
            
            return
            DonationRequestsPage();
            
            
            
            
            
            
            
            
             return Expanded(
              child: ListView.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return    
            
            Container
            (
          margin: EdgeInsets.all(10),
            // margin: EdgeInsets.only(right: 30),
              height: MediaQuery.of(context).size.height/3,
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
            offset: Offset(-0.5 ,0)
          )
              ]
          ),
              
              
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              
              Row(
          children: [
            Container(
          padding: EdgeInsets.all(10),
            
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[200]
          ),
          
          child: Center(
            child: Icon(Icons.location_on ,
            color: Theme.of(context).primaryColor,
            
            ),
          ),),
          
          SizedBox(
            width: 5,
          ) ,
              
          Text('AL khartoum North ,AL Amal' ,
          
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
          
          ) ,
              
              
          SizedBox(
            width: 5,
          ) ,
              
              
              
              
              GestureDetector(
          onTap: (){},
              
              
          child: Container(
            padding: EdgeInsets.all(10),
            width: 80,
              
            decoration: BoxDecoration(
          color: Colors.green ,
              
          borderRadius: BorderRadius.circular(50)
            ),
            child: Center(
          child: Text('Edit' , style: TextStyle(
            color: Colors.white
          ),),
            ),
          ),
              ) ,
              
              
               SizedBox(
            width: 5,
          ) ,
              
              
              
              
              GestureDetector(
          onTap: (){
              
              
            showDialog(context: context, builder: (_){
              
          return DecisionAlert(
            alertType: AlertType.DELETE,
          // onCance: (){
          //   Get.back();
          // },
          onYes: ()async{
              
          },
              title: 'Delete the blood transfusion request',
              body: 'Are you sure to delete the request? the request will perminantly deleted'
          ,);
            });
          },
              
              
          child: Container(
            padding: EdgeInsets.all(10),
            width: 80,
              
            decoration: BoxDecoration(
          color: Colors.red ,
              
          borderRadius: BorderRadius.circular(50)
            ),
            child: Center(
          child: Text('Delete' , style: TextStyle(
            color: Colors.white
          ),),
            ),
          ),
              )
          
          ],
              )
              
              ,
              SizedBox(height: 15,),
              Row(
          children: [
              
              
            Container(
          padding: EdgeInsets.all(10),
            
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[200]
          ),
          
          child: Center(
            child: Icon(Icons.local_hospital ,
            color: Theme.of(context).primaryColor,
            
            ),
          ),),
              SizedBox(width: 5,),
              
          Text.rich(
            TextSpan(
              text: 'Hostpital: ' ,
              style: TextStyle(
                color: Colors.grey
              ),
              children: [
                 TextSpan(
              text: 'Hostpital Name' ,
              style: TextStyle(
                color: Colors.black
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
          children: [
              
              
            Container(
          padding: EdgeInsets.all(10),
            
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[200]
          ),
          
          child: Center(
            child: Icon(Icons.phone ,
            color: Theme.of(context).primaryColor,
            
            ),
          ),),
              SizedBox(width: 5,),
              
          Text.rich(
            TextSpan(
              text: 'Phone Number: ' ,
              style: TextStyle(
                color: Colors.grey
              ),
              children: [
                 TextSpan(
              text: '0966302389' ,
              style: TextStyle(
                color: Colors.black
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
          children: [
              
              
            Container(
          padding: EdgeInsets.all(10),
            
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[200]
          ),
          
          child: Center(
            child: Icon(Icons.bloodtype_outlined ,
            color: Theme.of(context).primaryColor,
            
            ),
          ),),
              SizedBox(width: 5,),
          Text.rich(
            TextSpan(
              text: '2 bottle' ,
              style: TextStyle(
                color: Colors.black
              ),
              children: [
                 TextSpan(
              text: '| A+' ,
              style: TextStyle(
                color: Colors.black
                // color: Colors.grey
              ),
                 )
              ]
            ),
              
          )
          
              
          ])
              
              
              
            ]),
            )
            
            ;
          },
              ),
             );
           
           
            }
          }else {
          
           if (selectedStatus==0) {
//all

return 
AllDrugRquestsPage2();

           }else if (selectedStatus==1) {
//processing

return 
PendingDrugRquestsPage();

           }
        else if (selectedStatus==2) {
//competed

return 
ConfirmedDrugRquestsPage();
        }else {

return 
CancelledDrugRquestsPage();
//cancelled
        }
        
         
           
          }
              })
              
              
              
              
              
              
              
              
              
              
          ],),
        ),
      ),
      
    );
  }
}
import 'dart:convert';
import 'dart:developer';

import 'package:aafia/base/base.dart';
import 'package:aafia/utils/colors.dart';
import 'package:aafia/widgets/decision_alert.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:skeletons/skeletons.dart';
import '../data/models/base/page_mode.dart';
import '../data/models/response/blood_tranfer_pagination.dart' as blood;
import '../.././utils/global.dart' as global;
import 'add_bloodtransition_dontation.dart';

class VolunteerRequestsPage extends BaseRoute {
   VolunteerRequestsPage({ Key? key }) : super(r: 'VolunteerRequestsPage');

  @override
  _DonationRequestsPageState createState() => _DonationRequestsPageState();
}

class _DonationRequestsPageState extends BaseRouteState {

    ScrollController _scrollBloodTransferController = new ScrollController();

var bloodTranferUrl='${global.url}user/blood-transfare-requests/receiver';
deleteBloodRequest(drugRequest_id)async{


  try {
    showOnlyLoaderDialog();
    apiHelper.deleteBloodRequest(drugRequest_id)
    .then((result) {
hideLoader();
if (result.data!=null) {
  showSnackBar2(
                    
                    snackBarMessage:
                    'Your Request deleted successfully' ,isSuccess: true);
} else {
  showSnackBar2(
                    
                    snackBarMessage:
                    result.message.toString() ,isSuccess: false);
}


    });


  } catch (e) {
     showSnackBar2(
                    
                    snackBarMessage:
                    e.toString() ,isSuccess: false);
  }
}

  var bloodTranferLoadCompleted = false;

    List<blood.Data> bloodTraferList = [];
bool _isBloodRequestRequestLoading=false;
Future<List<blood.Data>>
   getBloodonationData(uri) async {
    final response = await http.get(Uri.parse(uri) ,
    
    headers: {
      'Authorization':'Bearer ${global.currentUser!.token}',
      'Content-Type':'application/json',
      'Accept':'application/json'
    }
    ).timeout(Duration(seconds: 15))
    
    ;
    if (response.statusCode == 200  ||  response.statusCode == 201) {
      var testJson = json.decode(response.body);
      // log(testJson.toString());
      var data = testJson['data'];
      if (testJson['next_page_url'] != null) {
        nextReceiverUrl = testJson['next_page_url'];
      } else {
        bloodTranferLoadCompleted = true;
        
      }
      for (var item in data) {
        try {
          blood.Data test =
             blood.Data.fromJson(item);
            
        bloodTraferList.add(test);
        } catch (e) {
          log(e.toString());
        }
      }
      setState(() {
        
      });
      return bloodTraferList;
    } else {
      throw Exception('Failed to load Test');
    }
  }

void bloodTrsferScrollindecator() {
    _scrollBloodTransferController.addListener(
      () {
        if (_scrollBloodTransferController.offset >=
                _scrollBloodTransferController.position.maxScrollExtent &&
            !_scrollBloodTransferController.position.outOfRange) {
          print('reach to bottom botton');
          if (!bloodTranferLoadCompleted) {
            setState(() {
              //add more data to list
              bloodTranferData = getBloodonationData(nextReceiverUrl);
            });
          }
        }
      },
    );
  }


  
  
  var nextReceiverUrl;


  Future<List<blood.Data>>? bloodTranferData;
@override
void initState() { 
  super.initState();
    bloodTranferData=getBloodonationData(bloodTranferUrl);
        bloodTrsferScrollindecator();

}

@override
  void dispose() {
    _scrollBloodTransferController.dispose();
    
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
      return 
             
             Expanded(
               child: SingleChildScrollView(
                     controller: _scrollBloodTransferController,
                     child:


                    FutureBuilder(
                      future: bloodTranferData,
                      builder: (BuildContext context, AsyncSnapshot<List<blood.Data>> snapshot) {
                        if (!snapshot.hasData) {
                          return 
                           ListView.builder(
                            physics: ScrollPhysics(),
                              shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return    
            
     Container(
      height: MediaQuery.of(context).size.height/6.5,
      margin: EdgeInsets.only(
        left: 15,right: 15 ,bottom: 15
      ),
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(

        color: Colors.white,borderRadius: BorderRadius.circular(20)
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
      
          children: [

Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [

          Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.notifications ,
      
      color:  Theme.of(context).primaryColor,
      ),
      SizedBox(width: 10,),
         SkeletonLine(
             style: SkeletonLineStyle(
               width: 120 ,height: 30 ,borderRadius: BorderRadius.circular(10)
             ),
           )
        ],
          ),
       SkeletonLine(
             style: SkeletonLineStyle(
               width: 10 ,height: 5 ,borderRadius: BorderRadius.circular(10)
             ),
           )
  ],
)



,

     SkeletonLine(
             style: SkeletonLineStyle(
               width: double.infinity ,height: 100 ,borderRadius: BorderRadius.circular(10)
             ),
           ) ,
      
     
      
      
      
          ],
        ),
      ),
    );
 
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
             SkeletonAvatar(
              style: SkeletonAvatarStyle(
                    width: 25,height: 25
              ),
            ),
          SizedBox(
            width: 5,
          ) ,
              
          SkeletonLine(
             style: SkeletonLineStyle(
               width: 50 ,height: 10 ,borderRadius: BorderRadius.circular(10)
             ),
           ) ,
              
              
          SizedBox(
            width: 5,
          ) ,
              
              
              
           SkeletonLine(
             style: SkeletonLineStyle(
               width: 70 ,height: 50 ,borderRadius: BorderRadius.circular(50)
             ),
           ) ,
              
               SizedBox(
            width: 5,
          ) ,
              
              
              
              
              SkeletonLine(
             style: SkeletonLineStyle(
               width: 70 ,height: 50 ,borderRadius: BorderRadius.circular(50)
             ),
           ) ,
          ],
              )
              
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
            ),
              SizedBox(width: 5,),
              
               
           SkeletonLine(
             style: SkeletonLineStyle(
               width: 50 ,height: 10 ,borderRadius: BorderRadius.circular(10)
             ),
           ) ,
          ])
              
              
              
              
            ]),
            )
            
            ;
          },
              );
            
            
                        } else {
        
        
                          if (snapshot.data!.length<1) {
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('No Data'),
                              ],
                            );
                          }
                          //if (snapshot.connectionState == ConnectionState.done) {
                          return 
                          
                          ListView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext contex, int index) {
                                if (index == snapshot.data!.length - 1 &&
                                    !bloodTranferLoadCompleted) {
                                  return Center(
                                    child: new Opacity(
                                      opacity: 1.0,
                                      child: new CircularProgressIndicator(),
                                    ),
                                  );
                                } else {
                                  return
                                  
                                  
                                   DropShadow(
                                      color: AppColors.SHADOW_COLOR,
            blurRadius: 7,
            // spreadRadius: 1,
            offset: Offset(0 ,0),
                                     child: Container
                                               (
                                             // margin: EdgeInsets.all(10),
                                           
                                               margin: EdgeInsets.only(bottom: 18),
                                                 // height: 205,
                                                 width: double.infinity,
                                                 padding: EdgeInsets.zero,
                                             decoration: BoxDecoration(
                                                 color: Colors.white,
                                                 borderRadius: BorderRadius.circular(10),
                                                 
                                                 boxShadow: [
                                             // BoxShadow(
                                             //   color: AppColors.SHADOW_COLOR,
                                             //   blurRadius: 7,
                                             //   // spreadRadius: 1,
                                             //   offset: Offset(0 ,0)
                                             // )
                                                 ]
                                             ),
                                                 
                                                 
                                             child: Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children: [
                                                 
                                                 
                                                 Container(
                                                   padding: EdgeInsets.all(15),
                                                   decoration: BoxDecoration(
                                                     color: Colors.white,
                                                     borderRadius: BorderRadius.circular(10),
                                                     boxShadow: [
                                                       BoxShadow(
                                                         offset: Offset(0, 0) ,color: AppColors.SHADOW_COLOR,
                                                         blurRadius: 7,
                                   
                                                       )
                                                     ]
                                                   ),
                                                   child: Row(
                                                           children: [
                                                             Container(
                                                              //  height: 30,
                                                              //  width: 30,
                                                           padding: EdgeInsets.all(10),
                                                             
                                                           decoration: BoxDecoration(
                                                             shape: BoxShape.circle,
                                                             color: AppColors.ONBACKGROUND
                                                           ),
                                                           
                                                           child: Center(
                                                             child: Icon(Icons.location_on ,
                                                             color: Theme.of(context).primaryColor,
                                                             
                                                             ),
                                                           ),),
                                                           
                                                           SizedBox(
                                                             width: 5,
                                                           ) ,
                                                   
                                                           SizedBox(
                                                             width: 125,
                                                             child: Text(
                                                               snapshot.data![index].hospital!.name!
                                                               
                                                               // 'AL khartoum North ,AL Amal' 
                                                               ,
                                                               overflow: TextOverflow.ellipsis,
                                                             
                                                             style: TextStyle(
                                                               fontWeight: FontWeight.w400 ,
                                                               fontSize: 14
                                                             ),
                                                             
                                                             ),
                                                           ) ,
                                                   
                                                   
                                                           SizedBox(
                                                             width: 5,
                                                           ) ,
                                                   
                                                   
                                                   
                                                   
                                                   GestureDetector(
                                                           onTap: (){

                                                             Get.to(()=>
                                                             
                                                             AddBloodTransitionDonation(snapshot.data![index].transfareType,
                                                             pageMode: PageMode.EDIT,
                                                             data:snapshot.data![index]
                                                              ,
                                                             
                                                             
                                                             
                                                             )
                                                             );
                                                           },
                                                   
                                                   
                                                           child: Container(
                                                             padding: EdgeInsets.symmetric(

                                                               vertical: 8,horizontal: 6
                                                             ),
                                                             width: 80,
                                                            //  height: 27,
                                                   
                                                             decoration: BoxDecoration(
                                                           color: Colors.green ,
                                                   
                                                           borderRadius: BorderRadius.circular(50)
                                                             ),
                                                             child: Center(
                                                           child: Text('Edit' , style: TextStyle(
                                                             color: Colors.white ,fontSize: 13,fontWeight: FontWeight.w500
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
                                                   await deleteBloodRequest( snapshot.data![index].id.toString());
                                                           bloodTraferList=[];
    bloodTranferData=getBloodonationData(nextReceiverUrl);
                                                            setState(() {
                                                              
                                                            });
                                                           
                                                           },

                                                     title: '${tr('delete_blood_request_title')}',
                                                   body: '${tr('delete_blood_request_message')}'        
                                                           
                                                           
                                                           ,);
                                                             });
                                                          
                                                          
                                                          
                                                           },
                                                   
                                                   
                                                           child: Container(
                                                        padding: EdgeInsets.symmetric(
                                                   
                                                               vertical: 8,horizontal: 6
                                                             ),
                                                             width: 80,
                                                   
                                                             decoration: BoxDecoration(
                                                           color: Colors.red ,
                                                   
                                                           borderRadius: BorderRadius.circular(50)
                                                             ),
                                                             child: Center(
                                                           child: Text('Delete' , style: TextStyle(
                                                             color: Colors.white ,fontSize: 13,fontWeight: FontWeight.w500
                                                           ),),
                                                             ),
                                                           ),
                                                   )
                                                           
                                                           ],
                                                   ),
                                                 )
                                                 
                                                 ,
                                                 SizedBox(height: 15,),

                                                 Container(
                                                          padding: EdgeInsets.all(15),
                                                          child: Column(children: [

                                              Row(
                                             children: [
                                                 
                                                 
                                               Container(
                                        padding: EdgeInsets.all(10),
                                                             
                                                           decoration: BoxDecoration(
                                                             shape: BoxShape.circle,
                                                             color: AppColors.ONBACKGROUND
                                                           ),
                                             
                                             child: Center(
                                               child: Icon(Icons.local_hospital ,
                                               color: Theme.of(context).primaryColor,
                                               
                                               ),
                                             ),),
                                                 SizedBox(width: 5,),
                                                 
                                             Text.rich(
                                               TextSpan(
                                                 text: 'Hostpital ' ,
                                                 style: TextStyle(
                                                       color: Color(0xFF020202),fontSize: 13,fontWeight: FontWeight.w400
                                                 ),
                                                 children: [
                                                        TextSpan(
                                                 text:    ":"+ snapshot.data![index].hospital!.name! ,
                                                 style: TextStyle(
                                                       color: Colors.black
 ,
 
 fontSize: 14,fontWeight: FontWeight.w400                                                       // color: Colors.grey
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
                                                             color: AppColors.ONBACKGROUND
                                                           ),
                                             child: Center(
                                               child: Icon(Icons.phone ,
                                               color: Theme.of(context).primaryColor,
                                               
                                               ),
                                             ),),
                                                 SizedBox(width: 5,),
                                                 
                                             Text.rich(
                                               TextSpan(
                                                 text: 'Phone Number ' ,
                                                   style: TextStyle(
                                                       color: Color(0xFF020202),fontSize: 13,fontWeight: FontWeight.w400
                                                 ),
                                                 children: [
                                                        TextSpan(
                                                 text: ":"+'${snapshot.data![index].followUpPhone!}' ,
                                                 style: TextStyle(
                                                       color: Colors.black,
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
                                                 text: '${snapshot.data![index].bottelsCount} bottle' ,
                                                 style: TextStyle(
                                                       color: Colors.black ,
                                                       fontSize: 14,fontWeight: FontWeight.w400
                                                 ),
                                                 children: [


                                                   TextSpan(
                                                     text: '|' ,style: TextStyle(
                                                       color: Theme.of(context).primaryColor
                                                     )
                                                   ),
                                                        TextSpan(
                                                 text: ' ${snapshot.data![index].bloodType}' ,
                                                 style: TextStyle(
                                                       color: Colors.black,
                                                     fontSize: 14,fontWeight: FontWeight.w400
                                                 ),
                                                        )
                                                 ]
                                               ),
                                                 
                                             )
                                             
                                                 
                                             ])
                                                 
                                                 
                                                 

                                                          ],),
                                                 )
   
                                               ]),
                                               ),
                                   )
            
            ;
                                }
                              }
                              //  },
                              );
                        }
                      },
                    ),
                   
                   
                   ),
             );
        
             
  }
}
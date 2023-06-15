import 'dart:convert';
import 'dart:developer';

import 'package:aafia/base/base.dart';
import 'package:aafia/data/models/base/page_mode.dart';
import 'package:aafia/pages/medical_request.dart';
import 'package:aafia/widgets/decision_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/response/drugResponsePagination.dart' as drug;

import 'package:http/http.dart' as http;
import '../.././utils/global.dart' as global;
import '../widgets/my_request_container.dart';

class CancelledDrugRquestsPage extends BaseRoute {
   CancelledDrugRquestsPage({ Key? key }) : super(r: 'CancelledDrugRquestsPage');

  @override
  _PendingDrugRquestsPageState createState() => _PendingDrugRquestsPageState();
}

class _PendingDrugRquestsPageState extends BaseRouteState {

  var cancelledUri = '${global.url}user/drug-requests/cancelled';

    var nextCancelledurl;

  Future<List<drug.Data>>? cancelledData;

  ScrollController _cancelledScrollController = new ScrollController();


  List<drug.Data> cancelledList = [];
    var canelledCompleted = false;

Future<List<drug.Data>>
   getCancelledData(uri) async {
    final response = await http.get(Uri.parse(cancelledUri) ,
    
    headers: {
      'Authorization':'Bearer ${global.currentUser!.token}',
      'Content-Type':'application/json',
      'Accept':'application/json'
    }
    ).timeout(Duration(seconds: 15))
    
    ;
    if (response.statusCode == 200  ||  response.statusCode == 201) {
      var testJson = json.decode(response.body);
      log(testJson.toString());
      var data = testJson['data'];
      if (testJson['next_page_url'] != null) {
        nextCancelledurl = testJson['next_page_url'];
      } else {
        canelledCompleted = true;
        
      }
      for (var item in data) {
        try {
          drug.Data test =
             drug.Data.fromJson(item);
            
        cancelledList.add(test);
        } catch (e) {
          log(e.toString());
        }
      }
      setState(() {
        
      });
      return cancelledList;
    } else {
      throw Exception('Failed to load Test');
    }
  }


    // var nextConfirmedurl;

 
 void scrollCancelledindecator() {
    _cancelledScrollController.addListener(
      () {
        if (_cancelledScrollController.offset >=
                _cancelledScrollController.position.maxScrollExtent &&
            !_cancelledScrollController.position.outOfRange) {
          print('reach to bottom botton');
          if (!canelledCompleted) {
            setState(() {
              //add more data to list
              cancelledData = getCancelledData(nextCancelledurl);
            });
          }
        }
      },
    );
  }

 @override
  void dispose() {
    _cancelledScrollController.dispose();
    super.dispose();
  }



deleteMedicalRequest(drugRequest_id)async{


  try {
    showOnlyLoaderDialog();
    apiHelper.deleteDrugRequest(drugRequest_id)
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






  // Future<List<drug.Data>>? data;





@override
void initState() { 
  super.initState();
    cancelledData = getCancelledData(cancelledUri);
  scrollCancelledindecator();

}
  @override
  Widget build(BuildContext context) {
    return    
        
        
        
        
          Expanded(
            child: SingleChildScrollView(
            controller: _cancelledScrollController,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FutureBuilder(
                  future: cancelledData,
                  builder: (BuildContext context, AsyncSnapshot<List<drug.Data>> snapshot) {
                    if (!snapshot.hasData) {
              return       ListView.builder(  physics: ScrollPhysics(),
                          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return    
            
          MedicationRequestContainerShimmer(
          
          );
          });
              
                    } else {
                      if (snapshot.data!.length<1) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height/2,
                              child: Column(
                                // mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('${tr('no_data')}' ),
                                ],
                              ),
                            );
                          }
                      return ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length ,
                          itemBuilder: (BuildContext contex, int index) {
                            if (index == snapshot.data!.length - 1 &&
                                !canelledCompleted) {
                              return Center(
                                child: new Opacity(
                                  opacity: 1.0,
                                  child: new CircularProgressIndicator(),
                                ),
                              );
                            } else {
                              return
                              
                              
                                 MedicationRequestContainer(
            medicineName: 'My drug name',
            requestStatus: RequestStatus.Completed,
            drugData: snapshot.data![index],
onEdit: (data){
  Get.to(()=>MedicalRequestPage(
    pageMode: PageMode.EDIT,
    drugData: data,
  ));
},
            onDelete: (id)async{
    showDialog(context: context, builder: (_){
                                                   
                                                           return DecisionAlert(
                                                             alertType: AlertType.DELETE,
                                                           // onCance: (){
                                                           //   Get.back();
                                                           // },
                                                           onYes: ()async{
                                                             cancelledList=[];
                                                   await deleteMedicalRequest( id.toString());
                                                           
                                                            cancelledData = getCancelledData(nextCancelledurl
                                                            );
                                                            setState(() {
                                                              
                                                            });
                                                           
                                                           },
                                                   title: '${tr('delete_medical_request_title')}',
                                                   body: '${tr('delete_blood_request_message')}'
                                                           ,);
                                                             });
                                                          
            },
          );;
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
          );
         
         
  }
}
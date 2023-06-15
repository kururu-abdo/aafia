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

class PendingDrugRquestsPage extends BaseRoute {
   PendingDrugRquestsPage({ Key? key }) : super(r: 'Pending');

  @override
  _PendingDrugRquestsPageState createState() => _PendingDrugRquestsPageState();
}

class _PendingDrugRquestsPageState extends BaseRouteState {

  var pendingUri = '${global.url}user/drug-requests/pending';
    var nextPendingurl;

  Future<List<drug.Data>>? pendingData;

  ScrollController _pendingScrollController = new ScrollController();
  List<drug.Data> pendingList = [];
    var pendingCompleted = false;
Future<List<drug.Data>>
   getPendingData(uri) async {
    final response = await http.get(Uri.parse(pendingUri) ,
    
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
        nextPendingurl = testJson['next_page_url'];
      } else {
        pendingCompleted = true;
        
      }
      for (var item in data) {
        try {
          drug.Data test =
             drug.Data.fromJson(item);
            
        pendingList.add(test);
        } catch (e) {
          log(e.toString());
        }
      }
      setState(() {
        
      });
      return pendingList;
    } else {
      throw Exception('Failed to load Test');
    }
  }


 void scrollPendingindecator() {
    _pendingScrollController.addListener(
      () {
        if (_pendingScrollController.offset >=
                _pendingScrollController.position.maxScrollExtent &&
            !_pendingScrollController.position.outOfRange) {
          print('reach to bottom botton');
          if (!pendingCompleted) {
            setState(() {
              //add more data to list
              pendingData = getPendingData(nextPendingurl);
            });
          }
        }
      },
    );
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








 @override
  void dispose() {
    _pendingScrollController.dispose();
    super.dispose();
  }




@override
void initState() { 
  super.initState();
  pendingData=  getPendingData(pendingUri);
  scrollPendingindecator();

}
  @override
  Widget build(BuildContext context) {
    return    
        
        
        
        
          Expanded(
            child: SingleChildScrollView(
            controller: _pendingScrollController,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FutureBuilder(
                  future: pendingData,
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
                                !pendingCompleted) {
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
                                                             pendingList=[];
                                                   await deleteMedicalRequest( id.toString());
                                                           
                                                            pendingData = getPendingData(nextPendingurl);
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
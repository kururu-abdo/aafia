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

class ConfirmedDrugRquestsPage extends BaseRoute {
   ConfirmedDrugRquestsPage({ Key? key }) : super(r: 'ConfirmedDrugRquestsPage');

  @override
  _PendingDrugRquestsPageState createState() => _PendingDrugRquestsPageState();
}

class _PendingDrugRquestsPageState extends BaseRouteState {

 var uri = '${global.url}user/drug-requests';
    // var nexturl;

  Future<List<drug.Data>>? confirmedData;
  var confirmedUri = '${global.url}user/drug-requests/confirmed';

  ScrollController _confirmedScrollController = new ScrollController();
  List<drug.Data> confirmedList = [];
    var confirmedCompleted = false;
Future<List<drug.Data>>
   getConfirmedData(uri) async {
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
      log(testJson.toString());
      var data = testJson['data'];
      if (testJson['next_page_url'] != null) {
        nextConfirmedurl = testJson['next_page_url'];
      } else {
        confirmedCompleted = true;
        
      }
      for (var item in data) {
        try {
          drug.Data test =
             drug.Data.fromJson(item);
            
        confirmedList.add(test);
        } catch (e) {
          log(e.toString());
        }
      }
      setState(() {
        
      });
      return confirmedList;
    } else {
      throw Exception('Failed to load Test');
    }
  }


    var nextConfirmedurl;

 
 void scrollConfirmedindecator() {
    _confirmedScrollController.addListener(
      () {
        if (_confirmedScrollController.offset >=
                _confirmedScrollController.position.maxScrollExtent &&
            !_confirmedScrollController.position.outOfRange) {
          print('reach to bottom botton');
          if (!confirmedCompleted) {
            setState(() {
              //add more data to list
              confirmedData = getConfirmedData(nextConfirmedurl);
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
    _confirmedScrollController.dispose();
    super.dispose();
  }





@override
void initState() { 
  super.initState();
    confirmedData = getConfirmedData(uri);
  scrollConfirmedindecator();

}
  @override
  Widget build(BuildContext context) {
    return    
        
        
        
        
          Expanded(
            child: SingleChildScrollView(
            controller: _confirmedScrollController,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FutureBuilder(
                  future: confirmedData,
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
                                !confirmedCompleted) {
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
                                                             confirmedList=[];
                                                   await deleteMedicalRequest( id.toString());
                                                           
                                                            confirmedData = getConfirmedData(nextConfirmedurl
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
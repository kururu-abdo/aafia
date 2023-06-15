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

class AllDrugRquestsPage2 extends BaseRoute {
   AllDrugRquestsPage2({ Key? key }) : super(r: 'all_drugs');

  @override
  _PendingDrugRquestsPageState createState() => _PendingDrugRquestsPageState();
}

class _PendingDrugRquestsPageState extends BaseRouteState {

 var uri = '${global.url}user/drug-requests';
    var nexturl;

  // Future<List<drug.Data>>? pendingData;

  ScrollController _scrollController = new ScrollController();
  List<drug.Data> tempList = [];
  var loadCompleted = false;
 Future<List<drug.Data>>
   getData(uri) async {
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
        nexturl = testJson['next_page_url'];
      } else {
        loadCompleted = true;
        
      }
      for (var item in data) {
        try {
          drug.Data test =
             drug.Data.fromJson(item);
            
        tempList.add(test);
        } catch (e) {
          log(e.toString());
        }
      }
      setState(() {
        
      });
      return tempList;
    } else {
      throw Exception('Failed to load Test');
    }
  }


void scrollindecator() {
    _scrollController.addListener(
      () {
        if (_scrollController.offset >=
                _scrollController.position.maxScrollExtent &&
            !_scrollController.position.outOfRange) {
          print('reach to bottom botton');
          if (!loadCompleted) {
            setState(() {
              //add more data to list
              data = getData(nexturl);
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
    _scrollController.dispose();
    super.dispose();
  }





  Future<List<drug.Data>>? data;





@override
void initState() { 
  super.initState();
    data = getData(uri);
  scrollindecator();

}
  @override
  Widget build(BuildContext context) {
    return    
        
        
        
        
          Expanded(
            child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FutureBuilder(
                  future: data,
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
                                !loadCompleted) {
                              return Center(
                                child: new Opacity(
                                  opacity: 1.0,
                                  child: new CircularProgressIndicator(),
                                ),
                              );
                            } else {
                              return
                              
                              
                                 MedicationRequestContainer(
            medicineName: 
             Get.locale!.languageCode=="en"?
            
            'My drug name':"اسم الدواء",
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
                                                             tempList=[];
                                                   await deleteMedicalRequest( id.toString());
                                                           
                                                            data = getData(nexturl);
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
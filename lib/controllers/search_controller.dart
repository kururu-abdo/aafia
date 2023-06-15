import 'package:aafia/data/models/base/api_helper.dart';
import 'package:aafia/data/models/response/hospital_model.dart';
import 'package:get/get.dart';

import '../data/models/response/driver_model.dart';

class SearchController extends GetxController {


var isAmbulanceResultAvalable=false.obs;

var isAmbulanceLoading=false;
List<DriverModel> driver=[];
var _ambulanceLat=0.0;
double get  ambulanceLat=>_ambulanceLat;

var _ambulanceLng=0.0;
double get ambulanceLng=>_ambulanceLng;

ApiHelper apiHelper = ApiHelper();
var lat=0.0.obs;
var lng=0.0.obs;
var location=''.obs;
sateLatLng(lat,lng){
  this.lat.value=lat;
    this.lng.value=lng;

}

sateAmbulanceLatLng(lat,lng){
  this._ambulanceLat=lat;
    this._ambulanceLng=lng;

}
Rx<HospitalModel>?  hospital;
setLocation(HospitalModel hospitalModel){
this.hospital!.value=hospitalModel;
}
searchForAmbulance()async{
try {
  isAmbulanceLoading=true;
  update();
  
var result = await apiHelper.searchAmbulances(_ambulanceLat, _ambulanceLng);

if (result.data!= null) {
  driver = result.data;
  update();
} else {
}
 isAmbulanceLoading=false;
  update();

} catch (e) {

  isAmbulanceLoading=false;
  update();
}
}

}
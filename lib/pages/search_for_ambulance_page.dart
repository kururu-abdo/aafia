import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:aafia/base/base.dart';
import 'package:aafia/controllers/search_controller.dart';
import 'package:aafia/data/models/response/driver_model.dart';
import 'package:aafia/data/models/response/hospital_model.dart';
import 'package:aafia/utils/app_constants.dart';
import 'package:aafia/utils/colors.dart';
import 'package:aafia/utils/image_to_marker.dart';
import 'package:aafia/widgets/dropdown_field.dart';
import 'package:aafia/widgets/my_Button.dart';
import 'package:aafia/widgets/my_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/place_picker.dart';

class SearchFormAmbulancePage extends BaseRoute {
   SearchFormAmbulancePage({ Key? key }) : super(r: 'Ambulance');

  @override
  _SearchFormAmbulancePageState createState() => _SearchFormAmbulancePageState();
}

class _SearchFormAmbulancePageState extends BaseRouteState {
List<LatLng> polylineCoordinates = [];
PolylinePoints polylinePoints = PolylinePoints();

Map<PolylineId, Polyline> polylines = {};


//start end 
LatLng startLocation = LatLng(27.6683619, 85.3101895);  
LatLng endLocation = LatLng(27.6688312, 85.3077329); 
// final Set<Marker> markers = new Set();
// final Set<Marker> dontationMarkers = new Set();

updatePolyLine()async{
  PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    AppConstants.GOOGLE_MAP_KEY!,
    PointLatLng(startLocation.latitude, startLocation.longitude),
    PointLatLng(endLocation.latitude, endLocation.longitude),
    travelMode: TravelMode.driving,
);

if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
} else {
    print(result.errorMessage);
}

addPolyLine(polylineCoordinates);
}

addPolyLine(List<LatLng> polylineCoordinates) {
  PolylineId id = PolylineId("poly");
  Polyline polyline = Polyline(
    polylineId: id,
    color:
    AppColors.PRIMARY_COLOR,
    points: polylineCoordinates,
    width: 8,
  );
  polylines[id] = polyline;
  setState(() {});
}





  final Set<Marker> markers = new Set();
final Set<Marker> dontationMarkers = new Set();

 final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();


 CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(16.43296265331129, 32.08832357078792),
    zoom: 5.4746,
        tilt: 59.440717697143555,
      // zoom: 19.151926040649414
  );

  


/*

 _setMarker(Amb bloodTransferResponse)async{
     final Uint8List markerIcon = await getBytesFromCanvas(150, 150 ,_image!,
     
     bloodTransferResponse.bloodType.toString()
     );
     markers.add(
       Marker(icon: BitmapDescriptor.fromBytes(markerIcon) ,markerId:
       MarkerId('${bloodTransferResponse.id}')
       ,position: LatLng(double.parse(bloodTransferResponse.requestLatitude.toString()), double.parse(bloodTransferResponse.requestLongitude.toString())) ,onTap: (){
         log('I love coding');
       }
       
       ),


     );

     
     setState(() {
       
     });
  }
  
  
  _setDontationMarker(BloodTransferResponse bloodTransferResponse)async{
     final Uint8List markerIcon = await getBytesFromCanvas(150, 150 ,_image!,
     
     bloodTransferResponse.bloodType.toString()
     );
     dontationMarkers.add(
       Marker(icon: BitmapDescriptor.fromBytes(markerIcon) ,markerId:
       MarkerId('${bloodTransferResponse.id}')
       ,position: LatLng(double.parse(bloodTransferResponse.requestLatitude.toString())
       ,double.parse(bloodTransferResponse.requestLongitude.toString())
       ) ,onTap: (){
         log('I love coding');
       }
       
       ),


     );

    
    
     setState(() {
       
     });
  }
  
  
  _init()async{
    var image=await loadImage('assets/images/png/bloodIcon-1.png');
    _image=image;
    setState(() {
      
    });
    bloodDataController.getDontationRequests().then((result){

result.forEach((request){

    _setDontationMarker(
      request
    );

    });
    });
   
    bloodDataController.getBloodRequests().then((result){

result.forEach((request){

    _setMarker(
      request
    );

    });
    });
   
  }



ui.Image?  _image;

*/


_setMyLocationMarker(lat, lng)async{
     final Uint8List markerIcon = await getMyLocationMarker(80, 80 
     
     );

     log(markerIcon.toString());
     dontationMarkers.add(
       Marker(icon: BitmapDescriptor.fromBytes(markerIcon) ,markerId:
       MarkerId('myLocation')
       ,position: LatLng(double.parse(lat.toString())
       ,double.parse(lng.toString())
       ) ,onTap: (){
              //  openBotomSheet(context ,  bloodTransferResponse: bloodTransferResponse);

       }
       
       ),


     );

    
    
     setState(() {
       
     });
  }
  



_setDontationMarker(DriverModel bloodTransferResponse)async{
     final Uint8List markerIcon = await getMyLocationMarker(150, 150 
     
     );
     dontationMarkers.add(
       Marker(icon: BitmapDescriptor.fromBytes(markerIcon) ,markerId:
       MarkerId('${bloodTransferResponse.id}')
       ,position: LatLng(double.parse(bloodTransferResponse.latitude.toString())
       ,double.parse(bloodTransferResponse.longitude.toString())
       ) ,onTap: (){
              //  openBotomSheet(context ,  bloodTransferResponse: bloodTransferResponse);

       }
       
       ),


     );

    
    
     setState(() {
       
     });
  }
  


_customMarker(String assets, Color color ,  String?  bloodTyp ,{
  DriverModel? bloodTransferResponse
}) {
    return Stack(
      alignment: Alignment.center,
      children: [
    
    //  Container(
    //             width: 40,
    //             height: 40,
    //             decoration: BoxDecoration(
    //                 color: Colors.white,
    //                  borderRadius: BorderRadius.circular(10)
    //                  ,
    //                  image: DecorationImage(image: AssetImage(assets) ,fit: BoxFit.fill)
                 
    //                  ),
    //             // child: Center(child: Image.asset(assets ,
    //             // fit: BoxFit.cover,
    //             // ),
    //             // ),
            
    //             )
    
    //  Icon(
    //           Icons.location_on,
    //           color: Colors.red[900],
    //           size: 50,
    //         ),
            GestureDetector(
              onTap: (){
                //  openBottomSheet(context);
              },
              child: Image.asset(assets ,
              // width: 50,
              height: 40,
              fit: BoxFit.cover,
              scale: .4,
              ),
            )
            ,
    
    Align(alignment: Alignment.center ,
    child: Center(child: Text('${bloodTyp}' ,style: TextStyle(
    color: Colors.white
    ),),)
    
    ,)
    
    
        // Icon(
        //   Icons.add_location,
        //   color: color,
        //   size: 50,
        // ),
        // Positioned(
        //   left: 15,
        //   top: 8,
        //   child: Container(
        //     width: 20,
        //     height: 20,
        //     decoration: BoxDecoration(
        //         color: Colors.white, borderRadius: BorderRadius.circular(10)),
        //     child: Center(child: Image.asset(assets ,
        //     fit: BoxFit.cover,
        //     )),
        //   ),
        // )
     
     
      ],
    );
  }





  GlobalKey<ScaffoldState>? _scaffoldKey;

List<DriverModel>  drivers=[];
@override
void initState() { 
  super.initState();
//  _getHospitals();

 updatePolyLine();
}
List<HospitalModel> _hopsitals=[];
HospitalModel?  _hospitalModel;

_getHospitals()async{
  
  try {
    apiHelper.getHospitals()
    .then((result) {
if (result!=null) {

  
  // if (result.data.length>0) {
    _hopsitals=result.data;
    setState(() {
      
    });

log(_hopsitals.length.toString());

  
  // }
}
    });
  } catch (e) {
    log(e.toString());
  }
}

double?  lat;
double? lng;
List<String> _workLocations =[
  
'khartoum' ,'omdurman','bahri'
];

// List ambulances =[
//   '+249966302389' ,  '+249966302389' ,'+249966302389', '+249966302389' ,'+249966302389','+249966302389'
// ];

String? _workLocation;
bool? resultAvailable=false;

toogleResult(){
  // resultAvailable=!resultAvailable!;
  // setState(() {
    
  // });


  try {


    if (lat==null || lng==null) {
      
   }else{

showOnlyLoaderDialog();
apiHelper.searchAmbulances(lat!, lng!).then((result) {
hideLoader();
if (result.data.length>0) {
log('NNNNNNNNNNNNNNNNNNNNNNNNNN');
  // showSnackBar(
  //                   key: _scaffoldKey,
  //                   snackBarMessage:
  //                   tr('order_send') ,
                    
  //                   isSuccess: true
  //                   );
                    // Get.back();
drivers.addAll(result.data) ;

log(drivers.length.toString());
resultAvailable=true;
setState(() {
  
});
drivers.forEach((element) {
  
  _setDontationMarker(element);
});
} else {
showSnackBar(
                    key: _scaffoldKey,
                    snackBarMessage:
                    result.message.toString() ,
                    
                    );
}




});



    }
    
  } catch (e) {
    showSnackBar(
                    key: _scaffoldKey,
                    snackBarMessage:
                    e.toString() ,
                    
                    );
  }
}

var searchController= Get.put(SearchController());




var _pLocationCOntroller=TextEditingController();
var _pLocationFocus= FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      body: SizedBox.expand(
        child: Container(
         
  child:        
GoogleMap(    initialCameraPosition: _kGooglePlex, 

myLocationButtonEnabled: true,
myLocationEnabled: true,

  markers: dontationMarkers, polylines: Set<Polyline>.of(polylines.values),
     mapType: MapType.normal, //map type
                    onMapCreated: (controller) { //method called when map is created
                      // setState(() {
                      //   mapController = controller; 
                      // });
                    },
  
  
   //markers to show on map
)

        ),
      ),

      // bottomSheet: ,
      bottomSheet: 
      
      // Obx(
      //   ()=> 
        
      
          // child:
           Builder(builder: (_){
              
  //       if (!resultAvailable!) {
  //         return ClipRRect(
  //             borderRadius: BorderRadius.vertical(
  //                   top: Radius.circular(30)
  //                 ),
  //             // padding: const EdgeInsets.all(8.0),
  //             child:
  // Container(
  //               height: MediaQuery.of(context).size.height*.45,
  //               padding: EdgeInsets.symmetric(
        
  //                 horizontal: 30,
  //                 vertical: 32
  //               ),
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.vertical(
  //                   top: Radius.circular(30)
  //                 ),
                  
  //               ),
              
  //               child: Form(child: Column(
  //                 children: [
        
        
  //             FractionallySizedBox(
  //         widthFactor: 0.2, // width of top divider bar
  //         child: Container(
  //           margin: const EdgeInsets.symmetric( // margin of top divider bar
  //             vertical: 12.0,
  //           ),
  //           child: Container(
  //             height: 8.0,
  //             decoration: BoxDecoration(
  //               color: Colors.grey.withOpacity(.5), // color of top divider bar
  //               borderRadius: const BorderRadius.all(Radius.circular(2.5)),
  //             ),
  //           ),
  //         ),
  //           ),
           
  //          SizedBox(height: 30,),
           
  //           // Spacer(),
  //           Center(
  //         child: Text('Search for Ambulance',
          
          
  //         style: TextStyle(
  //           fontSize: 15 ,
        
  //           fontWeight: FontWeight.w600
  //         ),
  //         )
  //           ),
  //                   SizedBox(height: 25,), 
  //         GestureDetector(
  //           onTap: ()async{
  //           LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
  //               builder: (context) =>
  //                   PlacePicker(AppConstants.GOOGLE_MAP_KEY!,
                              
          
          
          
  //                               )));
          
          
          
  //             searchController.lat.value=result.latLng!.latitude;
  //                         searchController.lng.value=result.latLng!.latitude;
  //       searchController.sateLatLng(result.latLng!.latitude ,result.latLng!.longitude);
  //             setState(() {
  //               lat =result.latLng!.latitude;
  //               lng = result.latLng!.longitude;
  //             });
  //             List<Placemark> placemarks = await placemarkFromCoordinates(lat!, lng!);
        
        
  //                       _pLocationCOntroller.text =  "${placemarks.first.country} ,  ${placemarks.first.locality}  ,   ${placemarks.first.name}";
        
        
        
  //           },
  //           child:   BoxTextField(label: 'Location',
            
  //           controller: _pLocationCOntroller,
  //           enabled: false,
  //           suffix: IconButton(onPressed: (){
  //         // log('sdfdsf');
  //           }, icon:  Icon(Icons.location_on,
  //           color: Theme.of(context).primaryColor,
  //           )
            
  //           ),
            
  //           ),
  //         ),
  //         SizedBox(height: 10,),
  //             // AppDropdownInput<HospitalModel>(
  //             //     options: _hopsitals,
  //             //     hintText: 'Hopsital',
  //             //     value: _hospitalModel,
  //             //     getLabel: (str)=>str.name!,
  //             //     onChanged: (str){
  //             //   setState(() {
                  
  //             //     _hospitalModel =str!;
  //             //   });
  //             //                     searchController.setLocation(_hospitalModel!);
        
  //             //     },
                
  //             //   ),
                    
                    
  //         Spacer(),
              
  //           // Obx(
  //           //   () {
  //               // return 
  //               MyButton(
  //               title: 'Search',
  //               isLoading: false,
  //               onTap: (){
  //                 toogleResult();
  //                 //  _onSignup();
  //               },
  //         )
  //           //   }
  //           // )
          
  //                 ],
  //               )),
  //             ),
           
              
  //         );
  //       } else {


  //         return ClipRRect(
  //             borderRadius: BorderRadius.vertical(
  //                   top: Radius.circular(30)
  //                 ),
  //             // padding: const EdgeInsets.all(8.0),
  //             child:

  // Container(
  //               height: MediaQuery.of(context).size.height*.60,
  //               padding: EdgeInsets.all(20),
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.vertical(
  //                   top: Radius.circular(30)
  //                 ),
                  
  //               ),
              
  //               child: Column(
  //                 children: [

                    
  //             FractionallySizedBox(
  //         widthFactor: 0.2, // width of top divider bar
  //         child: Container(
  //           margin: const EdgeInsets.symmetric( // margin of top divider bar
  //             vertical: 12.0,
  //           ),
  //           child: Container(
  //             height: 8.0,
  //             decoration: BoxDecoration(
  //               color: Colors.grey.withOpacity(.5), // color of top divider bar
  //               borderRadius: const BorderRadius.all(Radius.circular(2.5)),
  //             ),
  //           ),
  //         ),
  //           ),
           
           
           
  //           Center(
  //         child: Text('Ambulances',style: TextStyle(color: Theme.of(context).primaryColor),)
  //           ),
  //                   SizedBox(height: 10,), 
              
  //          Expanded(child: 
  //          ListView(
  //            children: drivers.map((e) => AmbulanceWidget(
  //              number: e.phone,
  //              onTap: (){
  //                toogleResult();
              
  //              },
  //            )).toList() ,
  //          )
           
  //          )    
               
  //                 ],
  //               ),
  //             ),
           
               
  //         );
  //       }
              
            return ClipRRect(
              borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30)
                  ),
              // padding: const EdgeInsets.all(8.0),
              child:
              
              
                AnimatedCrossFade(firstChild: 
              Container(
                height: MediaQuery.of(context).size.height*.45,
                padding: EdgeInsets.symmetric(
        
                  horizontal: 30,
                  vertical: 32
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30)
                  ),
                  
                ),
              
                child: Form(child: Column(
                  children: [
        
        
              FractionallySizedBox(
          widthFactor: 0.2, // width of top divider bar
          child: Container(
            margin: const EdgeInsets.symmetric( // margin of top divider bar
              vertical: 12.0,
            ),
            child: Container(
              height: 8.0,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.5), // color of top divider bar
                borderRadius: const BorderRadius.all(Radius.circular(2.5)),
              ),
            ),
          ),
            ),
           
           SizedBox(height: 30,),
           
            // Spacer(),
            Center(
          child: Text('Search for Ambulance',
          
          
          style: TextStyle(
            fontSize: 15 ,
        
            fontWeight: FontWeight.w600
          ),
          )
            ),
                    SizedBox(height: 25,), 
          GestureDetector(
            onTap: ()async{
            LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    PlacePicker(AppConstants.GOOGLE_MAP_KEY!,
                              
          
          
          
                                )));
          
          
          
              searchController.lat.value=result.latLng!.latitude;
                          searchController.lng.value=result.latLng!.latitude;
        searchController.sateLatLng(result.latLng!.latitude ,result.latLng!.longitude);
              setState(() {
                lat =result.latLng!.latitude;
                lng = result.latLng!.longitude;
              });
              List<Placemark> placemarks = await placemarkFromCoordinates(lat!, lng!);
        
        
                        _pLocationCOntroller.text =  "${placemarks.first.country} ,  ${placemarks.first.locality}  ,   ${placemarks.first.name}";
        
        




        _setMyLocationMarker(lat, lng);
        
            },
            child:   BoxTextField(label: 'Location',
            
            controller: _pLocationCOntroller,
            enabled: false,
            suffix: IconButton(onPressed: (){
          // log('sdfdsf');
            }, icon:  Icon(Icons.location_on,
            color: Theme.of(context).primaryColor,
            )
            
            ),
            
            ),
          ),
          SizedBox(height: 10,),
              // AppDropdownInput<HospitalModel>(
              //     options: _hopsitals,
              //     hintText: 'Hopsital',
              //     value: _hospitalModel,
              //     getLabel: (str)=>str.name!,
              //     onChanged: (str){
              //   setState(() {
                  
              //     _hospitalModel =str!;
              //   });
              //                     searchController.setLocation(_hospitalModel!);
        
              //     },
                
              //   ),
                    
                    
          Spacer(),
              
            // Obx(
            //   () {
                // return 
                MyButton(
                title: 'Search',
                isLoading: false,
                onTap: (){
                  toogleResult();
                  //  _onSignup();
                },
          )
            //   }
            // )
          
                  ],
                )),
              ),
           
              
              
               secondChild:
               Container(
                height: MediaQuery.of(context).size.height*.60,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30)
                  ),
                  
                ),
              
                child: Column(
                  children: [

                    
              FractionallySizedBox(
          widthFactor: 0.2, // width of top divider bar
          child: Container(
            margin: const EdgeInsets.symmetric( // margin of top divider bar
              vertical: 12.0,
            ),
            child: Container(
              height: 8.0,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.5), // color of top divider bar
                borderRadius: const BorderRadius.all(Radius.circular(2.5)),
              ),
            ),
          ),
            ),
           
           
           
            Center(
          child: Text('Ambulances',style: TextStyle(color: Theme.of(context).primaryColor),)
            ),
                    SizedBox(height: 10,), 
              
           Expanded(child: 
           ListView(
             children: drivers.map((e) => AmbulanceWidget(
               number: e.phone,
               onTap: (){
                 toogleResult();
              
               },
             )).toList() ,
           )
           
           )    
               
                  ],
                ),
              ),
           
               
               
               
                 crossFadeState: 
              resultAvailable! ? 
               CrossFadeState.showSecond:
              CrossFadeState.showFirst
             
              
              , duration: Duration(
                milliseconds: 500
              ))
              
               
           
           
           
            );
            
            
            
            
          }),
        
      
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
        child: AppBar(



            shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20)
        )
      ),
      title: Text('Search for an Ambulance' ,
      
      
      style: TextStyle(
        color: Colors.black ,fontSize: 16,fontWeight: FontWeight.w500
      ),
      ),
      // elevation: 0.0,
      backgroundColor: Colors.white,
      centerTitle: true,
          leading: IconButton(onPressed: (){
            Get.back();
          }, icon: Icon(Icons.arrow_back_ios,    color: Colors.black )),
        ),

        
      ),

    );
  }
}

class AmbulanceWidget extends StatelessWidget {
  final String? number;
  final Function()? onTap;
  const AmbulanceWidget({ Key? key, this.number, this.onTap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration:BoxDecoration(


        border: Border(bottom: BorderSide(
          width: .8,color: Colors.grey.withOpacity(.5)
        ))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min
            ,
            children: [
Image.asset('assets/images/png/Ambulance2.png'),
SizedBox(width: 6,) ,
Text(number!)



            ],
          ),



          GestureDetector(
            onTap: ()async{
              onTap!();
            },
            child: Container(
              padding: EdgeInsets.all(15),
          
              decoration: BoxDecoration(
          
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1,color: Theme.of(context).primaryColor
                )
              ),
              child: Center(child: Icon(Icons.call ,color: Theme.of(context).primaryColor,),),
            ),
          )
        ],
      ),
    );
  }
}
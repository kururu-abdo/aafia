import 'dart:async';
import 'dart:collection';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:aafia/base/base.dart';
import 'package:aafia/controllers/blood_controllers.dart';
import 'package:aafia/data/models/response/blood_transfer_response.dart';
import 'package:aafia/pages/add_bloodtransition_dontation.dart';
import 'package:aafia/pages/blood_transition.dart';
import 'package:aafia/services/map_services.dart';
import 'package:aafia/utils/app_constants.dart';
import 'package:aafia/utils/colors.dart';
import 'package:aafia/utils/image_to_marker.dart';
import 'package:aafia/utils/sizes.dart';
import 'package:aafia/widgets/my_Button.dart';
import 'package:aafia/widgets/my_buttom_blood.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:aafia/utils/global.dart' as global;

class BloodTransitionPage extends BaseRoute {
   BloodTransitionPage({ Key? key }) : super(r: 'BloodRequestMap');

  @override
  _BloodTransitionPageState createState() => _BloodTransitionPageState();
}

class _BloodTransitionPageState extends BaseRouteState {
List<LatLng> polylineCoordinates = [];
PolylinePoints polylinePoints = PolylinePoints();
Map<PolylineId, Polyline> polylines = {};

BloodTransferResponse? bloodTransferResponse;
//start end 
LatLng startLocation = LatLng(27.6683619, 85.3101895);  
LatLng endLocation = LatLng(27.6688312, 85.3077329); 
  Set<Polygon> _polygon = HashSet<Polygon>();
  List<LatLng> points = [
    LatLng(19.0759837, 72.8776559),
    LatLng(28.679079, 77.069710),
    LatLng(26.850000, 80.949997),
    LatLng(19.0759837, 72.8776559),
  ];
updatePolyLine(encondedPoly)async{
//   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//     AppConstants.GOOGLE_MAP_KEY!,
//     PointLatLng(startLocation.latitude, startLocation.longitude),
//     PointLatLng(endLocation.latitude, endLocation.longitude),
//     travelMode: TravelMode.driving,
// );
polylineCoordinates.clear();
var data=
 convertToLatLng(decodePoly(encondedPoly));
log('${startLocation.latitude}  ${startLocation.longitude}');
log('${endLocation.latitude}  ${endLocation.longitude}');
// log('${result.errorMessage}');
if (data.isNotEmpty) {
      data.forEach(( point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
} else {
    log('sfsdf');
}

addPolyLine(polylineCoordinates);
setState(() {
  
});

log('NO EXCEPTION');
}

addPolyLine(List<LatLng> polylineCoordinates) {
  PolylineId id = PolylineId("poly");
  Polyline polyline = Polyline(
    polylineId: id,
    color: AppColors.PRIMARY_COLOR,
    points: polylineCoordinates,
    width: 8,
  );
  polylines[id] = polyline;
  setState(() {});
}


 Set<Marker> markers = new Set();
final Set<Marker> dontationMarkers = new Set();

// markers.add(Marker( //add first marker
//   markerId: MarkerId(showLocation.toString()),
//   position: showLocation, //position of marker
//   infoWindow: InfoWindow( //popup info 
//     title: 'My Custom Title ',
//     snippet: 'My Custom Subtitle',
//   ),
//   icon: BitmapDescriptor.defaultMarker, //Icon for Marker
// ));
GlobalKey<ScaffoldState>?  scaffoldKey;
 final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();


 CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(16.43296265331129, 32.08832357078792),
    zoom: 5.4746,
        tilt: 59.440717697143555,
      // zoom: 19.151926040649414
  );
  CameraPosition _kGoogleDonationPlex = CameraPosition(
    target: LatLng(16.43296265331129, 32.08832357078792),
    zoom: 5.4746,
        tilt: 59.440717697143555,
      // zoom: 19.151926040649414
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(16.43296265331129, 32.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
// final locations = const [  
//   LatLng(37.42796133580664, -122.085749655962),  
//   LatLng(37.41796133580664, -122.085749655962),  
// ];  


_customMarker(String assets, Color color ,  String?  bloodTyp ,{
  BloodTransferResponse? bloodTransferResponse
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
                 openBottomSheet(context);
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




bool visibleBottomSheet=false;


BloodDataController bloodDataController = Get.put(BloodDataController()); // Rather Controller controller = Controller();
  List taps=['تلقي دم' 
  ,'تبرع بالدم'];
  int selectedTap=0;
@override
  void initState() {
    // TODO: implement initState
    super.initState();

// bloodDataController.getRequests().then((data){

// _init();
// });
_init();

  
  }
  
  _setMarker(BloodTransferResponse bloodTransferResponse)async{
     final Uint8List markerIcon = await getBytesFromCanvas(150, 150 ,_image!,
     
     bloodTransferResponse.bloodType.toString()
     );
//      markers ={};
// setState(() {
  
// });
     markers.add(
       Marker(icon: BitmapDescriptor.fromBytes(markerIcon) ,markerId:
       MarkerId('${bloodTransferResponse.id}')
       ,position: LatLng(double.parse(bloodTransferResponse.requestLatitude.toString()), double.parse(bloodTransferResponse.requestLongitude.toString())) ,onTap: ()async{
       getCurrentPosition();

// addPolyLine(polylineCoordinates)
 startLocation = LatLng(global.lat!, global.lng!);  
 endLocation = LatLng(double.parse(bloodTransferResponse.requestLatitude.toString()),double.parse(bloodTransferResponse.requestLongitude.toString()));
 setState(() {
   
 });
_setMyLocationMarker(global.lat!, global.lng!);

var results=await getRoutePoints(  startLocation,endLocation);

updatePolyLine(results);


               // ignore: use_build_context_synchronously
              //  openBottomSheet(context ,  bloodTransferResponse: bloodTransferResponse);
this.bloodTransferResponse =  bloodTransferResponse;
visibleBottomSheet=true;
setState(() {
  
});

        //  openBottomSheet(context ,  bloodTransferResponse: bloodTransferResponse);
       }
       
       ),


     );

     
     setState(() {
       
     });
  }
  _setMyLocationMarker(lat, lng)async{
     final Uint8List markerIcon = await getMyLocationMarker(80, 80 
     
     );

     log(markerIcon.toString());
     if (selectedTap==0) {
        markers.add(
       Marker(icon: BitmapDescriptor.fromBytes(markerIcon) ,markerId:
       MarkerId('myLocation')
       ,position: LatLng(double.parse(lat.toString())
       ,double.parse(lng.toString())
       ) ,onTap: (){
              //  openBotomSheet(context ,  bloodTransferResponse: bloodTransferResponse);

       }
       
       ),


     );

     }else {

        dontationMarkers.add(
       Marker(icon: BitmapDescriptor.fromBytes(markerIcon) ,markerId:
       MarkerId('myLocation')
       ,position: LatLng(double.parse(lat.toString())
       ,double.parse(lng.toString())
       ) ,onTap: (){
              //  openBotomSheet(context ,  bloodTransferResponse: bloodTransferResponse);

       }
       
       ));

     }
    
    
    
     setState(() {
       
     });
  }
  

// void createRoute(String encondedPoly) {
//     polylines.ad(Polyline(
//         polylineId: PolylineId(latLng.toString()),
//         width: 4,
//         visible: true,
//         points: convertToLatLng(decodePoly(encondedPoly)),
//         color: Colors.blue));
//   }
  
  _setDontationMarker(BloodTransferResponse bloodTransferResponse)async{
     final Uint8List markerIcon = await getBytesFromCanvas(150, 150 ,_image!,
     
     bloodTransferResponse.bloodType.toString()
     );
//          markers ={};
// setState(() {
  
// });
     dontationMarkers
    //  markers
     .add(
       Marker(icon: BitmapDescriptor.fromBytes(markerIcon) ,markerId:
       MarkerId('${bloodTransferResponse.id}')
       ,position: LatLng(double.parse(bloodTransferResponse.requestLatitude.toString())
       ,double.parse(bloodTransferResponse.requestLongitude.toString())
       ) ,onTap: ()async{
      //  await  getCurrentLocation();
//draw poly line

await getCurrentPosition();

// addPolyLine(polylineCoordinates)
 startLocation = LatLng(global.lat!, global.lng!);  
 endLocation = LatLng(double.parse(bloodTransferResponse.requestLatitude.toString()),double.parse(bloodTransferResponse.requestLongitude.toString()));

// log(results);

 setState(() {
   
 });
await _setMyLocationMarker(startLocation.latitude, startLocation.longitude);
var results=await getRoutePoints(  startLocation,endLocation);

updatePolyLine(results);
this.bloodTransferResponse =  bloodTransferResponse;
visibleBottomSheet=true;
setState(() {
  
});

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




  @override
  Widget build(BuildContext context) {


    return Scaffold(
      key: scaffoldKey,
// extendBodyBehindAppBar: true,
  appBar: PreferredSize(
    preferredSize: Size.fromHeight(80),
    child: AppBar(
      
      centerTitle: true,
      title: Center(child: Text('خدمات نقل الدم')),
backgroundColor: Theme.of(context).primaryColor,
leading: IconButton(onPressed: (){

  Get.back();
}, icon: Icon(Icons.arrow_back_ios ,color: Colors.white,)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20)
        )
      ),
    ),
  ),  
  body: SizedBox.expand(
    child: Stack(
      children: [

        //mapHere
        Container(
        child:Builder(builder: (bloodDataController){
// if (bloodDataController.isLoading) {
//   return Center(child: CircularProgressIndicator(),);
// } else {

if (selectedTap==0) {
  //donations

  return        
GoogleMap(    initialCameraPosition: _kGooglePlex,  
  markers: dontationMarkers,  
        polylines: Set<Polyline>.of(polylines.values),     mapType: MapType.normal, //map type
                    onMapCreated: (controller) { //method called when map is created
                      // setState(() {
                      //   mapController = controller; 
                      // });
                    },
  
  
   //markers to show on map
);
}else{

  
  return        
GoogleMap(    initialCameraPosition: _kGooglePlex,  
  markers: markers,    polylines: Set<Polyline>.of(polylines.values), 
     mapType: MapType.normal, //map type
                    onMapCreated: (controller) { //method called when map is created
                      // setState(() {
                      //   mapController = controller; 
                      // });
                    },
  
  
   //markers to show on map
);


}




    
// }


        }),
        ),




        Align(
          alignment: Alignment.topCenter,
child: Container(
  margin: EdgeInsets.only(top:70 ),
  child: Container(
    width: 420,
    height: 60,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white
    ),

    child: 

     Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: taps.map((e) => 
  GestureDetector(
    onTap: (){
polylines ={};
visibleBottomSheet=false;
      selectedTap=taps.lastIndexOf(e);
      setState(() {
        
      });
    },
    child: AnimatedContainer(
       curve: Curves.easeInCubic,
       width: 420/2,
    height: 60,
      duration: 
    
    Duration(milliseconds: 350),
    
    decoration: BoxDecoration(

      color: e==taps[selectedTap]?
      Theme.of(context).primaryColor:Colors.transparent,
borderRadius:  e==taps[selectedTap]?BorderRadius.circular(10):null
    ),
    child: Center(
      child: Text(e,style: TextStyle(
fontSize: 14,fontWeight: FontWeight.w600,
        color:  e==taps[selectedTap]?Colors.white:Colors.black,

      ),),
    ),
    ),
  )
  
  
  ).toList(),
  
    )
  ),

),

        ),


        Align(
          alignment: Alignment.bottomCenter,
          child: 
          
          GestureDetector(
            onTap: (){

if (    selectedTap==1) {
  Get.to(
  ()=> 
 AddBloodTransitionDonation(
  'volunteer'
  ));
} else {
 Get.to(
  ()=>   AddBloodTransition(
  'receiver'
  ));
}


//               Get.to(
//   ()=> AddBloodTransition(
//     selectedTap==0?'volunteer':'receiver'
//   )
// );  
              //  openBottomSheet(context);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(30),
              height: 50,
              // MediaQuery.of(context).size.height/3,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // borderRadius: BorderRadius.vertical(
                //   top: Radius.circular(25)
                // ),
                color: Theme.of(context).primaryColor
              ),
              child: 
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center
                ,
                  children: [
                    Icon(Icons.add ,color: Colors.white,) ,
                    SizedBox(width: 5,),
                    Text(
                      'اضافة طلب جديد' ,
                      style: TextStyle(
                        color: Colors.white
                      ),
                    )
                  ],
                ),
              )
              
            
            
            ),
          ),
        )
      ],
    ),

  ),
 bottomSheet: Visibility(
   visible: visibleBottomSheet,
   child: 
       Container(
     height: 450,
     padding: EdgeInsets.all(30),
     child: Builder(builder: (context){
if (bloodTransferResponse!.transfareType=='volunteer') {

  return 

  Container(
    padding: EdgeInsets.symmetric(horizontal: 21),
    child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
          IconButton(onPressed: (){
            visibleBottomSheet=false;
            polylines ={};
visibleBottomSheet=false;
            setState(() {
              
            });
          }, icon: Icon(Icons.close)),
              SizedBox(height: 2,),
        Center(
          child: FractionallySizedBox(
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
        ),
           
           
          SizedBox(height: 10,),
  Center(
    child: Text(   tr('donat_blood_data')  , style: TextStyle(
      fontWeight: FontWeight.bold
    ),),
  ) ,
  
  
  ListTile(
    leading:
     ClipOval(
  child: 
  
  bloodTransferResponse!.user!.image == null || bloodTransferResponse!.user!.image.length<2?
  Image.asset('assets/images/png/placeholder.jpg' , fit: BoxFit.cover,
    width: 40.0,
    height: 40.0,):
  
  
  
  
  Image.network(
    global.configModel.imagesUrl!+"/"+bloodTransferResponse!.user!.image,
    fit: BoxFit.cover,
    width: 40.0,
    height: 40.0,
  )
),
    
    
    
    //  Container(
    //   width: 40,
    //   decoration: BoxDecoration(
    //     color: AppColors.SECONDARY_COLOE,
    //     shape: BoxShape.circle
    //   ),
  
    // ),
    title: Text('${bloodTransferResponse!.user!.name}' ,
    
    style: TextStyle(
      fontSize: 15,fontWeight: FontWeight.w500
    ),
    ),
  
  subtitle: Text('${bloodTransferResponse!.user!.address}',
    style: TextStyle(
      fontSize: 12,fontWeight: FontWeight.w400
    ),
  
  ), 
  
  trailing:
  
   Row(
     mainAxisSize: MainAxisSize.min,
     crossAxisAlignment: CrossAxisAlignment.center,
     children: [
       ImageIcon
       (
  //        Icons.bloodtype_rounded ,
  
  
  
  color: Colors.red,
  
  AssetImage('assets/images/png/bottle3.png')
  ),
  
  
  
  SizedBox(
    height: 35,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('${bloodTransferResponse!.bottelsCount} ',style: TextStyle(
        fontSize: 14,fontWeight: FontWeight.w500
      ),),
        Text('Bottle' ,  style: TextStyle(
        fontSize: 14,fontWeight: FontWeight.w500
      ),)
      ],
    ),
  )
     ],
   )
  
  
  
  ),
    SizedBox(height: 12,),
  
  
   
  SizedBox(
    height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
       
          
                Container(
          height: 30,
            width: 30,
            padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.ONBACKGROUND
              ),
              
              child: Center(
                child: ImageIcon
         (
      //        Icons.bloodtype_rounded ,
      
      
      
      color: Theme.of(context).primaryColor,
      
      AssetImage('assets/images/png/hospital3.png')
      ),
              ),),
      
              SizedBox(width: 6,),
      
      Text('${bloodTransferResponse!.hospital!.name}' , style: TextStyle(
         fontSize: 14,fontWeight: FontWeight.w400
      ),)
        ],
      ),
    ),
  
   SizedBox(height: 14,),
  
  
  
  
  
   Row(
      mainAxisSize: MainAxisSize.min,
      children: [
   
        
              Container(
        height: 30,
          width: 30,
          padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.ONBACKGROUND
            ),
            
            child: Center(
              child: ImageIcon
       (
  //        Icons.bloodtype_rounded ,
  
  
  
  color: Theme.of(context).primaryColor,
  
  AssetImage('assets/images/png/calendar3.png')
  ),
            ),),
  
            SizedBox(width: 6,),
  
  Text('${bloodTransferResponse!.createdAt}' , style: TextStyle(
       fontSize: 14,fontWeight: FontWeight.w400
    ),)
      ],
    ),
  
   SizedBox(height: 14,),
  
  
  Row(
      mainAxisSize: MainAxisSize.min,
      children: [
   
        
              Container(
        height: 30,
          width: 30,
          padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.ONBACKGROUND
            ),
            
            child: Center(
              child: Icon
       (
         Icons.call ,
  
  
  
  color: Theme.of(context).primaryColor
  
  // AssetImage('assets/images/png/calendar3.png')
  ),
            ),),
  
            SizedBox(width: 6,),
  
  Text('${bloodTransferResponse!.followUpPhone}' , style: TextStyle(
       fontSize: 14,fontWeight: FontWeight.w400
    ),)
      ],
    ),
  
   SizedBox(height: 14,),
  
  
  
  //  Row(
  //      mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //      children: [
  //  SizedBox(width: MediaQuery.of(context).size.width/3,
  //      child: Row(children:[
  // Container(
  //   padding: EdgeInsets.all(8)
  //   ,
  //   decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       color: Colors.black.withOpacity(.09)
  //   ),
  //   child: Center(child: Icon(Icons.local_hospital,
  //   color: Theme.of(context).primaryColor,))) ,
  // SizedBox(width: 5,),
  //   Text('مستشفى الشفاء' , style: TextStyle(
  //       color: Colors.black.withOpacity(.9)
  //   ),)
  
  //      ]) 
       
  //      ) ,
  
  // SizedBox(width: MediaQuery.of(context).size.width/3,
  //      child:  Row(children:[
  // Container(
  //   padding: EdgeInsets.all(8)
  //   ,
  //   decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       color: Colors.black.withOpacity(.09)
  //   ),
  //   child: Center(child: Icon(Icons.calendar_today_rounded,
  //   color: Theme.of(context).primaryColor,
    
  //      ))) ,
  // SizedBox(width: 5,),
  //   Text('2/Jun/2012' , style: TextStyle(
  //       color: Colors.black.withOpacity(.9)
  //   ),)
  
  //      ]) 
       
  //       ) ,
  
  //      ],
  //  ) ,
  
  //  Row(
  //      mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //      children: [
  //  SizedBox(width: MediaQuery.of(context).size.width/3,
  //      child: Row(children:[
  // Container(
  //   padding: EdgeInsets.all(8)
  //   ,
  //   decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       color: Colors.black.withOpacity(.09)
  //   ),
  //   child: Center(child: Icon(Icons.hourglass_bottom,
  //   color: Theme.of(context).primaryColor,))) ,
  // SizedBox(width: 5,),
  //   Text('2 زجاجة ' , style: TextStyle(
  //       color: Colors.black.withOpacity(.9)
  //   ),)
  
  //      ]) 
       
  //      ) ,
  
  // SizedBox(width: MediaQuery.of(context).size.width/3,
  //      child:  Row(children:[
  // Container(
  //   padding: EdgeInsets.all(8)
  //   ,
  //   decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       color: Colors.black.withOpacity(.09)
  //   ),
  //   child: Center(child: Icon(Icons.call_rounded,
  //   color: Theme.of(context).primaryColor,
    
  //      ))) ,
  // SizedBox(width: 5,),
  //   Text('012912839' , style: TextStyle(
  //       color: Colors.black.withOpacity(.9)
  //   ),)
  
  //      ]) 
       
  //       ) ,
  
  //      ],
  //  ) ,
  
  // Spacer(),
  MyButtonBlood(
    // ignore: prefer_interpolation_to_compose_strings
    title:
    RichText(text: TextSpan(
      text:     '${tr('call')} ',
      style: TextStyle(
            color: Colors.white ,fontWeight: FontWeight.w500,

            fontSize: Sizes.FontSizeMainButton
          ),

          children: [
            TextSpan(
              text: String.fromCharCode(0xe126) ,
              style: TextStyle(  color: Colors.white)
            )
          ]
    ))
    
    
    ,
    onTap: (){
  
    },
  
    
  )
    ],),
  );



}else {




  return 
  
  Container(
    padding: EdgeInsets.symmetric(horizontal: 21),
    child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
          IconButton(onPressed: (){
            visibleBottomSheet=false;
            polylines ={};
visibleBottomSheet=false;
            setState(() {
              
            });
          }, icon: Icon(Icons.close)),
              SizedBox(height: 2,),
        Center(
          child: FractionallySizedBox(
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
        ),
           
           
          SizedBox(height: 10,),
  Center(
    child: Text(   tr('donat_blood_data')  , style: TextStyle(
      fontWeight: FontWeight.bold
    ),),
  ) ,
  
  
  ListTile(
    leading:
     ClipOval(
  child: 
  
  bloodTransferResponse!.user!.image == null || bloodTransferResponse!.user!.image.length<2?
  Image.asset('assets/images/png/placeholder.jpg' , fit: BoxFit.cover,
    width: 40.0,
    height: 40.0,):
  
  
  
  
  Image.network(
    global.configModel.imagesUrl!+"/"+bloodTransferResponse!.user!.image,
    fit: BoxFit.cover,
    width: 40.0,
    height: 40.0,
  )
),
    
    
    
    //  Container(
    //   width: 40,
    //   decoration: BoxDecoration(
    //     color: AppColors.SECONDARY_COLOE,
    //     shape: BoxShape.circle
    //   ),
  
    // ),
    title: Text('${bloodTransferResponse!.user!.name}' ,
    
    style: TextStyle(
      fontSize: 15,fontWeight: FontWeight.w500
    ),
    ),
  
  subtitle: Text('${bloodTransferResponse!.user!.address}',
    style: TextStyle(
      fontSize: 12,fontWeight: FontWeight.w400
    ),
  
  ), 
  
  trailing:
  
   Row(
     mainAxisSize: MainAxisSize.min,
     crossAxisAlignment: CrossAxisAlignment.center,
     children: [
       ImageIcon
       (
  //        Icons.bloodtype_rounded ,
  
  
  
  color: Colors.red,
  
  AssetImage('assets/images/png/bottle3.png')
  ),
  
  
  
  SizedBox(
    height: 35,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('${bloodTransferResponse!.bottelsCount} ',style: TextStyle(
        fontSize: 14,fontWeight: FontWeight.w500
      ),),
        Text('Bottle' ,  style: TextStyle(
        fontSize: 14,fontWeight: FontWeight.w500
      ),)
      ],
    ),
  )
     ],
   )
  
  
  
  ),
    SizedBox(height: 12,),
  
  
   
  SizedBox(
    height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
       
          
                Container(
          height: 30,
            width: 30,
            padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.ONBACKGROUND
              ),
              
              child: Center(
                child: ImageIcon
         (
      //        Icons.bloodtype_rounded ,
      
      
      
      color: Theme.of(context).primaryColor,
      
      AssetImage('assets/images/png/hospital3.png')
      ),
              ),),
      
              SizedBox(width: 6,),
      
      Text('${bloodTransferResponse!.hospital!.name}' , style: TextStyle(
         fontSize: 14,fontWeight: FontWeight.w400
      ),)
        ],
      ),
    ),
  
   SizedBox(height: 14,),
  
  
  
  
  
   Row(
      mainAxisSize: MainAxisSize.min,
      children: [
   
        
              Container(
        height: 30,
          width: 30,
          padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.ONBACKGROUND
            ),
            
            child: Center(
              child: ImageIcon
       (
  //        Icons.bloodtype_rounded ,
  
  
  
  color: Theme.of(context).primaryColor,
  
  AssetImage('assets/images/png/calendar3.png')
  ),
            ),),
  
            SizedBox(width: 6,),
  
  Text('${bloodTransferResponse!.createdAt}' , style: TextStyle(
       fontSize: 14,fontWeight: FontWeight.w400
    ),)
      ],
    ),
  
   SizedBox(height: 14,),
  
  
  Row(
      mainAxisSize: MainAxisSize.min,
      children: [
   
        
              Container(
        height: 30,
          width: 30,
          padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.ONBACKGROUND
            ),
            
            child: Center(
              child: Icon
       (
         Icons.call ,
  
  
  
  color: Theme.of(context).primaryColor
  
  // AssetImage('assets/images/png/calendar3.png')
  ),
            ),),
  
            SizedBox(width: 6,),
  
  Text('${bloodTransferResponse!.followUpPhone}' , style: TextStyle(
       fontSize: 14,fontWeight: FontWeight.w400
    ),)
      ],
    ),
  
   SizedBox(height: 14,),
  
  
  
  //  Row(
  //      mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //      children: [
  //  SizedBox(width: MediaQuery.of(context).size.width/3,
  //      child: Row(children:[
  // Container(
  //   padding: EdgeInsets.all(8)
  //   ,
  //   decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       color: Colors.black.withOpacity(.09)
  //   ),
  //   child: Center(child: Icon(Icons.local_hospital,
  //   color: Theme.of(context).primaryColor,))) ,
  // SizedBox(width: 5,),
  //   Text('مستشفى الشفاء' , style: TextStyle(
  //       color: Colors.black.withOpacity(.9)
  //   ),)
  
  //      ]) 
       
  //      ) ,
  
  // SizedBox(width: MediaQuery.of(context).size.width/3,
  //      child:  Row(children:[
  // Container(
  //   padding: EdgeInsets.all(8)
  //   ,
  //   decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       color: Colors.black.withOpacity(.09)
  //   ),
  //   child: Center(child: Icon(Icons.calendar_today_rounded,
  //   color: Theme.of(context).primaryColor,
    
  //      ))) ,
  // SizedBox(width: 5,),
  //   Text('2/Jun/2012' , style: TextStyle(
  //       color: Colors.black.withOpacity(.9)
  //   ),)
  
  //      ]) 
       
  //       ) ,
  
  //      ],
  //  ) ,
  
  //  Row(
  //      mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //      children: [
  //  SizedBox(width: MediaQuery.of(context).size.width/3,
  //      child: Row(children:[
  // Container(
  //   padding: EdgeInsets.all(8)
  //   ,
  //   decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       color: Colors.black.withOpacity(.09)
  //   ),
  //   child: Center(child: Icon(Icons.hourglass_bottom,
  //   color: Theme.of(context).primaryColor,))) ,
  // SizedBox(width: 5,),
  //   Text('2 زجاجة ' , style: TextStyle(
  //       color: Colors.black.withOpacity(.9)
  //   ),)
  
  //      ]) 
       
  //      ) ,
  
  // SizedBox(width: MediaQuery.of(context).size.width/3,
  //      child:  Row(children:[
  // Container(
  //   padding: EdgeInsets.all(8)
  //   ,
  //   decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       color: Colors.black.withOpacity(.09)
  //   ),
  //   child: Center(child: Icon(Icons.call_rounded,
  //   color: Theme.of(context).primaryColor,
    
  //      ))) ,
  // SizedBox(width: 5,),
  //   Text('012912839' , style: TextStyle(
  //       color: Colors.black.withOpacity(.9)
  //   ),)
  
  //      ]) 
       
  //       ) ,
  
  //      ],
  //  ) ,
  
  // Spacer(),
  MyButton(
    // ignore: prefer_interpolation_to_compose_strings
    title: '${tr('call')} '
     +String.fromCharCode(0xe126)
    ,
    onTap: (){
  
    },
  
    
  )
    ],),
  );


}



              }),
   )
),
      
    );
  }





  void openBottomSheet(context ,{BloodTransferResponse? bloodTransferResponse}) {
   
   try {
     
    showModalBottomSheet<dynamic>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20)
        )
      ),
      context: context,
      builder: (BuildContext context) {
       
   return     
   
       Container(
     height: 417,
     padding: EdgeInsets.all(30),
     child: Builder(builder: (context){
if (bloodTransferResponse!.transfareType=='volunteer') {

  return 

  Container(
    padding: EdgeInsets.symmetric(horizontal: 21),
    child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
              SizedBox(height: 12,),
        Center(
          child: FractionallySizedBox(
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
        ),
           
           
          SizedBox(height: 12,),
  Center(
    child: Text(   tr('donat_blood_data')  , style: TextStyle(
      fontWeight: FontWeight.bold
    ),),
  ) ,
  
  
  ListTile(
    leading:
     ClipOval(
  child: 
  
  bloodTransferResponse.user!.image == null || bloodTransferResponse.user!.image.length<2?
  Image.asset('assets/images/png/placeholder.jpg' , fit: BoxFit.cover,
    width: 40.0,
    height: 40.0,):
  
  
  
  
  Image.network(
    global.configModel.imagesUrl!+"/"+bloodTransferResponse.user!.image,
    fit: BoxFit.cover,
    width: 40.0,
    height: 40.0,
  )
),
    
    
    
    //  Container(
    //   width: 40,
    //   decoration: BoxDecoration(
    //     color: AppColors.SECONDARY_COLOE,
    //     shape: BoxShape.circle
    //   ),
  
    // ),
    title: Text('${bloodTransferResponse.user!.name}' ,
    
    style: TextStyle(
      fontSize: 15,fontWeight: FontWeight.w500
    ),
    ),
  
  subtitle: Text('${bloodTransferResponse.user!.address}',
    style: TextStyle(
      fontSize: 12,fontWeight: FontWeight.w400
    ),
  
  ), 
  
  trailing:
  
   Row(
     mainAxisSize: MainAxisSize.min,
     crossAxisAlignment: CrossAxisAlignment.center,
     children: [
       ImageIcon
       (
  //        Icons.bloodtype_rounded ,
  
  
  
  color: Colors.red,
  
  AssetImage('assets/images/png/bottle3.png')
  ),
  
  
  
  SizedBox(
    height: 35,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('${bloodTransferResponse.bottelsCount} ',style: TextStyle(
        fontSize: 14,fontWeight: FontWeight.w500
      ),),
        Text('Bottle' ,  style: TextStyle(
        fontSize: 14,fontWeight: FontWeight.w500
      ),)
      ],
    ),
  )
     ],
   )
  
  
  
  ),
    SizedBox(height: 12,),
  
  
   
  SizedBox(
    height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
       
          
                Container(
          height: 30,
            width: 30,
            padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.ONBACKGROUND
              ),
              
              child: Center(
                child: ImageIcon
         (
      //        Icons.bloodtype_rounded ,
      
      
      
      color: Theme.of(context).primaryColor,
      
      AssetImage('assets/images/png/hospital3.png')
      ),
              ),),
      
              SizedBox(width: 6,),
      
      Text('${bloodTransferResponse.hospital!.name}' , style: TextStyle(
         fontSize: 14,fontWeight: FontWeight.w400
      ),)
        ],
      ),
    ),
  
   SizedBox(height: 14,),
  
  
  
  
  
   Row(
      mainAxisSize: MainAxisSize.min,
      children: [
   
        
              Container(
        height: 30,
          width: 30,
          padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.ONBACKGROUND
            ),
            
            child: Center(
              child: ImageIcon
       (
  //        Icons.bloodtype_rounded ,
  
  
  
  color: Theme.of(context).primaryColor,
  
  AssetImage('assets/images/png/calendar3.png')
  ),
            ),),
  
            SizedBox(width: 6,),
  
  Text('${bloodTransferResponse.createdAt}' , style: TextStyle(
       fontSize: 14,fontWeight: FontWeight.w400
    ),)
      ],
    ),
  
   SizedBox(height: 14,),
  
  
  Row(
      mainAxisSize: MainAxisSize.min,
      children: [
   
        
              Container(
        height: 30,
          width: 30,
          padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.ONBACKGROUND
            ),
            
            child: Center(
              child: Icon
       (
         Icons.call ,
  
  
  
  color: Theme.of(context).primaryColor
  
  // AssetImage('assets/images/png/calendar3.png')
  ),
            ),),
  
            SizedBox(width: 6,),
  
  Text('${bloodTransferResponse.followUpPhone}' , style: TextStyle(
       fontSize: 14,fontWeight: FontWeight.w400
    ),)
      ],
    ),
  
   SizedBox(height: 14,),
  
  
  
  //  Row(
  //      mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //      children: [
  //  SizedBox(width: MediaQuery.of(context).size.width/3,
  //      child: Row(children:[
  // Container(
  //   padding: EdgeInsets.all(8)
  //   ,
  //   decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       color: Colors.black.withOpacity(.09)
  //   ),
  //   child: Center(child: Icon(Icons.local_hospital,
  //   color: Theme.of(context).primaryColor,))) ,
  // SizedBox(width: 5,),
  //   Text('مستشفى الشفاء' , style: TextStyle(
  //       color: Colors.black.withOpacity(.9)
  //   ),)
  
  //      ]) 
       
  //      ) ,
  
  // SizedBox(width: MediaQuery.of(context).size.width/3,
  //      child:  Row(children:[
  // Container(
  //   padding: EdgeInsets.all(8)
  //   ,
  //   decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       color: Colors.black.withOpacity(.09)
  //   ),
  //   child: Center(child: Icon(Icons.calendar_today_rounded,
  //   color: Theme.of(context).primaryColor,
    
  //      ))) ,
  // SizedBox(width: 5,),
  //   Text('2/Jun/2012' , style: TextStyle(
  //       color: Colors.black.withOpacity(.9)
  //   ),)
  
  //      ]) 
       
  //       ) ,
  
  //      ],
  //  ) ,
  
  //  Row(
  //      mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //      children: [
  //  SizedBox(width: MediaQuery.of(context).size.width/3,
  //      child: Row(children:[
  // Container(
  //   padding: EdgeInsets.all(8)
  //   ,
  //   decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       color: Colors.black.withOpacity(.09)
  //   ),
  //   child: Center(child: Icon(Icons.hourglass_bottom,
  //   color: Theme.of(context).primaryColor,))) ,
  // SizedBox(width: 5,),
  //   Text('2 زجاجة ' , style: TextStyle(
  //       color: Colors.black.withOpacity(.9)
  //   ),)
  
  //      ]) 
       
  //      ) ,
  
  // SizedBox(width: MediaQuery.of(context).size.width/3,
  //      child:  Row(children:[
  // Container(
  //   padding: EdgeInsets.all(8)
  //   ,
  //   decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       color: Colors.black.withOpacity(.09)
  //   ),
  //   child: Center(child: Icon(Icons.call_rounded,
  //   color: Theme.of(context).primaryColor,
    
  //      ))) ,
  // SizedBox(width: 5,),
  //   Text('012912839' , style: TextStyle(
  //       color: Colors.black.withOpacity(.9)
  //   ),)
  
  //      ]) 
       
  //       ) ,
  
  //      ],
  //  ) ,
  
  // Spacer(),
  MyButton(
    // ignore: prefer_interpolation_to_compose_strings
    title: '${tr('call')} '
     +String.fromCharCode(0xe126)
    ,
    onTap: (){
  
    },
  
    
  )
    ],),
  );



}else {




  return 
  
  Container(
    padding: EdgeInsets.symmetric(horizontal: 21),
    child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
              SizedBox(height: 12,),
        Center(
          child: FractionallySizedBox(
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
        ),
           
           
          SizedBox(height: 12,),
  Center(
    child: Text(   tr('donat_blood_data')  , style: TextStyle(
      fontWeight: FontWeight.bold
    ),),
  ) ,
  
  
  ListTile(
    leading:
     ClipOval(
  child: 
  
  bloodTransferResponse.user!.image == null || bloodTransferResponse.user!.image.length<2?
  Image.asset('assets/images/png/placeholder.jpg' , fit: BoxFit.cover,
    width: 40.0,
    height: 40.0,):
  
  
  
  
  Image.network(
    global.configModel.imagesUrl!+"/"+bloodTransferResponse.user!.image,
    fit: BoxFit.cover,
    width: 40.0,
    height: 40.0,
  )
),
    
    
    
    //  Container(
    //   width: 40,
    //   decoration: BoxDecoration(
    //     color: AppColors.SECONDARY_COLOE,
    //     shape: BoxShape.circle
    //   ),
  
    // ),
    title: Text('${bloodTransferResponse.user!.name}' ,
    
    style: TextStyle(
      fontSize: 15,fontWeight: FontWeight.w500
    ),
    ),
  
  subtitle: Text('${bloodTransferResponse.user!.address}',
    style: TextStyle(
      fontSize: 12,fontWeight: FontWeight.w400
    ),
  
  ), 
  
  trailing:
  
   Row(
     mainAxisSize: MainAxisSize.min,
     crossAxisAlignment: CrossAxisAlignment.center,
     children: [
       ImageIcon
       (
  //        Icons.bloodtype_rounded ,
  
  
  
  color: Colors.red,
  
  AssetImage('assets/images/png/bottle3.png')
  ),
  
  
  
  SizedBox(
    height: 35,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('${bloodTransferResponse.bottelsCount} ',style: TextStyle(
        fontSize: 14,fontWeight: FontWeight.w500
      ),),
        Text('Bottle' ,  style: TextStyle(
        fontSize: 14,fontWeight: FontWeight.w500
      ),)
      ],
    ),
  )
     ],
   )
  
  
  
  ),
    SizedBox(height: 12,),
  
  
   
  SizedBox(
    height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
       
          
                Container(
          height: 30,
            width: 30,
            padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.ONBACKGROUND
              ),
              
              child: Center(
                child: ImageIcon
         (
      //        Icons.bloodtype_rounded ,
      
      
      
      color: Theme.of(context).primaryColor,
      
      AssetImage('assets/images/png/hospital3.png')
      ),
              ),),
      
              SizedBox(width: 6,),
      
      Text('${bloodTransferResponse.hospital!.name}' , style: TextStyle(
         fontSize: 14,fontWeight: FontWeight.w400
      ),)
        ],
      ),
    ),
  
   SizedBox(height: 14,),
  
  
  
  
  
   Row(
      mainAxisSize: MainAxisSize.min,
      children: [
   
        
              Container(
        height: 30,
          width: 30,
          padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.ONBACKGROUND
            ),
            
            child: Center(
              child: ImageIcon
       (
  //        Icons.bloodtype_rounded ,
  
  
  
  color: Theme.of(context).primaryColor,
  
  AssetImage('assets/images/png/calendar3.png')
  ),
            ),),
  
            SizedBox(width: 6,),
  
  Text('${bloodTransferResponse.createdAt}' , style: TextStyle(
       fontSize: 14,fontWeight: FontWeight.w400
    ),)
      ],
    ),
  
   SizedBox(height: 14,),
  
  
  Row(
      mainAxisSize: MainAxisSize.min,
      children: [
   
        
              Container(
        height: 30,
          width: 30,
          padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.ONBACKGROUND
            ),
            
            child: Center(
              child: Icon
       (
         Icons.call ,
  
  
  
  color: Theme.of(context).primaryColor
  
  // AssetImage('assets/images/png/calendar3.png')
  ),
            ),),
  
            SizedBox(width: 6,),
  
  Text('${bloodTransferResponse.followUpPhone}' , style: TextStyle(
       fontSize: 14,fontWeight: FontWeight.w400
    ),)
      ],
    ),
  
   SizedBox(height: 14,),
  
  
  
  //  Row(
  //      mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //      children: [
  //  SizedBox(width: MediaQuery.of(context).size.width/3,
  //      child: Row(children:[
  // Container(
  //   padding: EdgeInsets.all(8)
  //   ,
  //   decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       color: Colors.black.withOpacity(.09)
  //   ),
  //   child: Center(child: Icon(Icons.local_hospital,
  //   color: Theme.of(context).primaryColor,))) ,
  // SizedBox(width: 5,),
  //   Text('مستشفى الشفاء' , style: TextStyle(
  //       color: Colors.black.withOpacity(.9)
  //   ),)
  
  //      ]) 
       
  //      ) ,
  
  // SizedBox(width: MediaQuery.of(context).size.width/3,
  //      child:  Row(children:[
  // Container(
  //   padding: EdgeInsets.all(8)
  //   ,
  //   decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       color: Colors.black.withOpacity(.09)
  //   ),
  //   child: Center(child: Icon(Icons.calendar_today_rounded,
  //   color: Theme.of(context).primaryColor,
    
  //      ))) ,
  // SizedBox(width: 5,),
  //   Text('2/Jun/2012' , style: TextStyle(
  //       color: Colors.black.withOpacity(.9)
  //   ),)
  
  //      ]) 
       
  //       ) ,
  
  //      ],
  //  ) ,
  
  //  Row(
  //      mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //      children: [
  //  SizedBox(width: MediaQuery.of(context).size.width/3,
  //      child: Row(children:[
  // Container(
  //   padding: EdgeInsets.all(8)
  //   ,
  //   decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       color: Colors.black.withOpacity(.09)
  //   ),
  //   child: Center(child: Icon(Icons.hourglass_bottom,
  //   color: Theme.of(context).primaryColor,))) ,
  // SizedBox(width: 5,),
  //   Text('2 زجاجة ' , style: TextStyle(
  //       color: Colors.black.withOpacity(.9)
  //   ),)
  
  //      ]) 
       
  //      ) ,
  
  // SizedBox(width: MediaQuery.of(context).size.width/3,
  //      child:  Row(children:[
  // Container(
  //   padding: EdgeInsets.all(8)
  //   ,
  //   decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       color: Colors.black.withOpacity(.09)
  //   ),
  //   child: Center(child: Icon(Icons.call_rounded,
  //   color: Theme.of(context).primaryColor,
    
  //      ))) ,
  // SizedBox(width: 5,),
  //   Text('012912839' , style: TextStyle(
  //       color: Colors.black.withOpacity(.9)
  //   ),)
  
  //      ]) 
       
  //       ) ,
  
  //      ],
  //  ) ,
  
  // Spacer(),
  MyButton(
    // ignore: prefer_interpolation_to_compose_strings
    title: '${tr('call')} '
     +String.fromCharCode(0xe126)
    ,
    onTap: (){
  
    },
  
    
  )
    ],),
  );


}



              }),
   );



      },
    );
  
  
   } catch (e) {
     log(e.toString());
   }
  }

}
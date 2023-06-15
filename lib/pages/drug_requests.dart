import 'dart:async';

import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DrugRequests extends StatefulWidget {
  const DrugRequests({ Key? key }) : super(key: key);

  @override
  _DrugRequestsState createState() => _DrugRequestsState();
}

class _DrugRequestsState extends State<DrugRequests> {


 final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
final locations = const [  
  LatLng(37.42796133580664, -122.085749655962),  
  LatLng(37.41796133580664, -122.085749655962),  
];  



_customMarker(String assets, Color color) {
    return Stack(
      children: [
        Icon(
          Icons.add_location,
          color: color,
          size: 50,
        ),
        Positioned(
          left: 15,
          top: 8,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Center(child: Image.asset(assets ,
            fit: BoxFit.cover,
            )),
          ),
        )
      ],
    );
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
      
      
CustomGoogleMapMarkerBuilder(  
  customMarkers: [  
  MarkerData(  
        marker: Marker(  markerId: const MarkerId('id-1'), position: locations[0]),  
		child: _customMarker('assets/images/png/medicine2.png', Colors.black)),  
  MarkerData(  
        marker: Marker(  markerId: const MarkerId('id-2'), position: locations[1]),  
		child: _customMarker('assets/images/png/medicine2.png', Colors.red)),    
  ],  
  builder: (BuildContext context, Set<Marker>? markers) {  
    if (markers == null) {  
      return const Center(child: CircularProgressIndicator());  
  }  
    return GoogleMap(  
      initialCameraPosition: const CameraPosition(  
        target: LatLng(37.42796133580664, -122.085749655962),  
  zoom: 14.4746,  
  ),  
  markers: markers,  
  onMapCreated: (GoogleMapController controller) { },  
  );  
  },  
)
    
    
    
      ),
    );
  }
}
import 'package:json_annotation/json_annotation.dart';

class NewDrugRequest {

String?  drug_name;

 double? latitude;
 double? longitude;
 double?  distance;
 String? image;
 String? insuranceCompany;
 String? insuranceImage;
  NewDrugRequest({this.drug_name ,this.distance ,this.image ,this.latitude ,this.longitude  , this.insuranceCompany ,this.insuranceImage });
 

NewDrugRequest.formJson(Map<String, dynamic> json){
    drug_name: json['drug_name'] as String?;
      distance: (json['distance'] as num?)?.toDouble();
      image: json['image'] as String?;
      latitude: (json['latitude'] as num?)?.toDouble();
      longitude: (json['longitude'] as num?)?.toDouble();
insuranceCompany=json['insurance_company'];
insuranceImage =json['insurance_image'];
    
}

Map<String ,dynamic>  toJson()=>{
      'drug_name': drug_name,
      'latitude': latitude,
      'longitude': longitude,
      'distance': distance,
      'image': image,
      'insurance_image':insuranceImage ,
      'insurance_company':insuranceCompany


    };

}
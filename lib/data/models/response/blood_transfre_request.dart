import 'package:json_annotation/json_annotation.dart';
class NewBloodTransferRquest {
   String?  transfare_type;
   String?  blood_type;
   num?  bottels_count;
 String?  hospital_id;
 String?  transfare_time;
 String?  operation_type ;
 String? operation_type_detail;
   num?  request_latitude;
   num?  request_longitude;
 String?  follow_up_phone ;
   num?  distance;

  NewBloodTransferRquest({this.transfare_type, this.blood_type, this.bottels_count, this.hospital_id, this.transfare_time, this.operation_type, this.operation_type_detail, this.request_latitude, this.request_longitude, this.follow_up_phone, this.distance});
  
NewBloodTransferRquest.fromJSon(
        Map<String, dynamic> json) {
  
      json['transfare_type'] as String?;
      json['blood_type'] as String?;
      json['bottels_count'] as num?;
      json['hospital_id'] as String?;
      json['transfare_time'] as String?;
      json['operation_type'] as String?;
      json['operation_type_detail'] as String?;
      json['request_latitude'] as num?;
      json['request_longitude'] as num?;
      json['follow_up_phone'] as String?;
      json['distance'] as num?;
        }


Map<String, dynamic> toJson(
      ) =>
    <String, dynamic>{
      'transfare_type': transfare_type,
      'blood_type': blood_type,
      'bottels_count': bottels_count,
      'hospital_id': hospital_id,
      'transfare_time': transfare_time,
      'operation_type': operation_type,
      'operation_type_detail': operation_type_detail,
      'request_latitude': request_latitude,
      'request_longitude': request_longitude,
      'follow_up_phone': follow_up_phone,
      'distance': distance,
    };
}

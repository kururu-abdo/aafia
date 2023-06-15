
import 'package:json_annotation/json_annotation.dart';
part 'new_user.g.dart';
@JsonSerializable()
class NewUser {
  
 String? name;
 String? phone;
 String? password;
 String? password_confirm;

 String? email;
 String? gender;
 String? bloodtype;

 String?  usertype;
 String?  address;


 String?   birthdate;

 double? latitude;
 double?  longitude;
 String? image;
 String? worklocation;

 
  
 factory NewUser.fromJson(Map<String, dynamic> json) => _$NewUserFromJson(json);

  NewUser({this.name, this.phone, this.password, this.password_confirm, this.email, this.gender, this.bloodtype, this.usertype, this.address, this.birthdate, this.latitude, this.longitude, this.image, this.worklocation});
  Map<String, dynamic> toJson() => _$NewUserToJson(this);

}
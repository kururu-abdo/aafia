class DrugResponse {
  dynamic id;
  String? type;
  String? drugName;
  String? image;
  dynamic latitude;
 dynamic longitude;
 dynamic distance;
  String? key;
  String? createdAt;
  // Relationships? relationships;

  DrugResponse(
      {this.id,
      this.type,
      this.drugName,
      this.image,
      this.latitude,
      this.longitude,
      this.distance,
      this.key,
      this.createdAt,
      // this.relationships
      
      });

  DrugResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    drugName = json['drug_name'];
    image = json['image'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    distance = json['distance'];
    key = json['key'];
    createdAt = json['created_at'];
    // relationships = json['relationships'] != null
    //     ? new Relationships.fromJson(json['relationships'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['drug_name'] = this.drugName;
    data['image'] = this.image;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['distance'] = this.distance;
    data['key'] = this.key;
    data['created_at'] = this.createdAt;
    // if (this.relationships != null) {
    //   data['relationships'] = this.relationships!.toJson();
    // }
    return data;
  }
}

// class Relationships {
//   User? user;

//   Relationships({this.user});

//   Relationships.fromJson(Map<String, dynamic> json) {
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     return data;
//   }
// }

// class User {
//   int? id;
//   String? type;
//   String? name;
//   String? phone;
//   String? gender;
//   String? bloodtype;
//   String? usertype;
//   String? birthdate;
//   String? address;
//   bool? isPaid;
//   bool? isActive;
//   bool? isVerified;
//   Null? latitude;
//   Null? longitude;
//   Null? image;
//   Null? worklocation;
//   String? key;
//   String? createdAt;
//   Null? token;

//   User(
//       {this.id,
//       this.type,
//       this.name,
//       this.phone,
//       this.gender,
//       this.bloodtype,
//       this.usertype,
//       this.birthdate,
//       this.address,
//       this.isPaid,
//       this.isActive,
//       this.isVerified,
//       this.latitude,
//       this.longitude,
//       this.image,
//       this.worklocation,
//       this.key,
//       this.createdAt,
//       this.token});

//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     type = json['type'];
//     name = json['name'];
//     phone = json['phone'];
//     gender = json['gender'];
//     bloodtype = json['bloodtype'];
//     usertype = json['usertype'];
//     birthdate = json['birthdate'];
//     address = json['address'];
//     isPaid = json['isPaid'];
//     isActive = json['isActive'];
//     isVerified = json['isVerified'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     image = json['image'];
//     worklocation = json['worklocation'];
//     key = json['key'];
//     createdAt = json['created_at'];
//     token = json['token'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['type'] = this.type;
//     data['name'] = this.name;
//     data['phone'] = this.phone;
//     data['gender'] = this.gender;
//     data['bloodtype'] = this.bloodtype;
//     data['usertype'] = this.usertype;
//     data['birthdate'] = this.birthdate;
//     data['address'] = this.address;
//     data['isPaid'] = this.isPaid;
//     data['isActive'] = this.isActive;
//     data['isVerified'] = this.isVerified;
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     data['image'] = this.image;
//     data['worklocation'] = this.worklocation;
//     data['key'] = this.key;
//     data['created_at'] = this.createdAt;
//     data['token'] = this.token;
//     return data;
//   }
// }

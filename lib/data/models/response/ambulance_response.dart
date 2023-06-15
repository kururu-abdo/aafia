class AmbulanceResponse {
  int? id;
  String? type;
  double? requestLatitude;
  double? requestLongitude;
  String? location;
  String? createdAt;
  // Drivers? drivers;
  Relationship? relationship;

  AmbulanceResponse(
      {this.id,
      this.type,
      this.requestLatitude,
      this.requestLongitude,
      this.location,
      this.createdAt,
      // this.drivers,
      this.relationship});

  AmbulanceResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    requestLatitude = json['request_latitude'];
    requestLongitude = json['request_longitude'];
    location = json['location'];
    createdAt = json['created_at'];
    // drivers =
    //     json['drivers'] != null ? new Drivers.fromJson(json['drivers']) : null;
    relationship = json['relationship'] != null
        ? new Relationship.fromJson(json['relationship'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['request_latitude'] = this.requestLatitude;
    data['request_longitude'] = this.requestLongitude;
    data['location'] = this.location;
    data['created_at'] = this.createdAt;
    // if (this.drivers != null) {
    //   data['drivers'] = this.drivers!.toJson();
    // }
    if (this.relationship != null) {
      data['relationship'] = this.relationship!.toJson();
    }
    return data;
  }
}

// class Drivers {
//   List<Null>? user;

//   Drivers({this.user});

//   Drivers.fromJson(Map<String, dynamic> json) {
//     if (json['user'] != null) {
//       user = <Null>[];
//       json['user'].forEach((v) {
//         user!.add(new Null.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.user != null) {
//       data['user'] = this.user!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class Relationship {
  User? user;

  Relationship({this.user});

  Relationship.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? type;
  String? name;
  String? phone;
  String? gender;
  String? bloodtype;
  String? usertype;
  String? birthdate;
  String? address;
  bool? isPaid;
  bool? isActive;
  bool? isVerified;
  Null? latitude;
  Null? longitude;
  Null? image;
  Null? worklocation;
  String? key;
  String? createdAt;
  Null? token;

  User(
      {this.id,
      this.type,
      this.name,
      this.phone,
      this.gender,
      this.bloodtype,
      this.usertype,
      this.birthdate,
      this.address,
      this.isPaid,
      this.isActive,
      this.isVerified,
      this.latitude,
      this.longitude,
      this.image,
      this.worklocation,
      this.key,
      this.createdAt,
      this.token});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    phone = json['phone'];
    gender = json['gender'];
    bloodtype = json['bloodtype'];
    usertype = json['usertype'];
    birthdate = json['birthdate'];
    address = json['address'];
    isPaid = json['isPaid'];
    isActive = json['isActive'];
    isVerified = json['isVerified'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    image = json['image'];
    worklocation = json['worklocation'];
    key = json['key'];
    createdAt = json['created_at'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['bloodtype'] = this.bloodtype;
    data['usertype'] = this.usertype;
    data['birthdate'] = this.birthdate;
    data['address'] = this.address;
    data['isPaid'] = this.isPaid;
    data['isActive'] = this.isActive;
    data['isVerified'] = this.isVerified;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['image'] = this.image;
    data['worklocation'] = this.worklocation;
    data['key'] = this.key;
    data['created_at'] = this.createdAt;
    data['token'] = this.token;
    return data;
  }
}

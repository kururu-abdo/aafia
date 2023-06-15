class BloodTransferResponse {
dynamic id;
dynamic userId;
  dynamic acceptedById;
  String? transfareType;
  String? bloodType;
 dynamic bottelsCount;
 dynamic hospitalId;
dynamic transfareTime;
 dynamic operationType;
dynamic operationTypeDetail;
 dynamic requestLatitude;
 dynamic requestLongitude;
  dynamic distance;
  String? followUpPhone;
  dynamic deletedAt;
  String? key;
  String? createdAt;
  String? updatedAt;
  Hospital? hospital;
  User? user;
dynamic acceptedby;

  BloodTransferResponse(
      {this.id,
      this.userId,
      this.acceptedById,
      this.transfareType,
      this.bloodType,
      this.bottelsCount,
      this.hospitalId,
      this.transfareTime,
      this.operationType,
      this.operationTypeDetail,
      this.requestLatitude,
      this.requestLongitude,
      this.distance,
      this.followUpPhone,
      this.deletedAt,
      this.key,
      this.createdAt,
      this.updatedAt,
      this.hospital,
      this.user,
      this.acceptedby});

  BloodTransferResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    acceptedById = json['accepted_by_id'];
    transfareType = json['transfare_type'];
    bloodType = json['blood_type'];
    bottelsCount = json['bottels_count'];
    hospitalId = json['hospital_id'];
    transfareTime = json['transfare_time'];
    operationType = json['operation_type'];
    operationTypeDetail = json['operation_type_detail'];
    requestLatitude = json['request_latitude'];
    requestLongitude = json['request_longitude'];
    distance = json['distance'];
    followUpPhone = json['follow_up_phone'].toString();
    deletedAt = json['deleted_at'];
    key = json['key'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    hospital = json['hospital'] != null
        ? new Hospital.fromJson(json['hospital'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    acceptedby = json['acceptedby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['accepted_by_id'] = this.acceptedById;
    data['transfare_type'] = this.transfareType;
    data['blood_type'] = this.bloodType;
    data['bottels_count'] = this.bottelsCount;
    data['hospital_id'] = this.hospitalId;
    data['transfare_time'] = this.transfareTime;
    data['operation_type'] = this.operationType;
    data['operation_type_detail'] = this.operationTypeDetail;
    data['request_latitude'] = this.requestLatitude;
    data['request_longitude'] = this.requestLongitude;
    data['distance'] = this.distance;
    data['follow_up_phone'] = this.followUpPhone;
    data['deleted_at'] = this.deletedAt;
    data['key'] = this.key;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.hospital != null) {
      data['hospital'] = this.hospital!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['acceptedby'] = this.acceptedby;
    return data;
  }
}

class Hospital {
 dynamic id;
  String? name;
  String? location;
  dynamic deletedAt;
  String? key;
  String? createdAt;
  String? updatedAt;

  Hospital(
      {this.id,
      this.name,
      this.location,
      this.deletedAt,
      this.key,
      this.createdAt,
      this.updatedAt});

  Hospital.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
    deletedAt = json['deleted_at'];
    key = json['key'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['location'] = this.location;
    data['deleted_at'] = this.deletedAt;
    data['key'] = this.key;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class User {
dynamic id;
  String? name;
dynamic email;
dynamic emailVerifiedAt;
  String? phone;
 dynamic gender;
dynamic bloodtype;
  String? usertype;
 dynamic birthdate;
 dynamic address;
  bool? isPaid;
  bool? isActive;
  bool? isVerified;
 dynamic image;
  String? worklocation;
 dynamic latitude;
dynamic longitude;
 

  User(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.phone,
      this.gender,
      this.bloodtype,
      this.usertype,
      this.birthdate,
      this.address,
      this.isPaid,
      this.isActive,
      this.isVerified,
      this.image,
      this.worklocation,
      this.latitude,
      this.longitude,
   });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    phone = json['phone'];
    gender = json['gender'];
    bloodtype = json['bloodtype'];
    usertype = json['usertype'];
    birthdate = json['birthdate'];
    address = json['address'];
    isPaid = json['isPaid'];
    isActive = json['isActive'];
    isVerified = json['isVerified'];
    image = json['image'];
    worklocation = json['worklocation'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['bloodtype'] = this.bloodtype;
    data['usertype'] = this.usertype;
    data['birthdate'] = this.birthdate;
    data['address'] = this.address;
    data['isPaid'] = this.isPaid;
    data['isActive'] = this.isActive;
    data['isVerified'] = this.isVerified;
    data['image'] = this.image;
    data['worklocation'] = this.worklocation;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
  
    return data;
  }
}

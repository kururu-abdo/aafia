class BloodTransferResponsePagination {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  Null? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

  BloodTransferResponsePagination(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  BloodTransferResponsePagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data {
dynamic id;
dynamic userId;
 dynamic acceptedById;
  String? transfareType;
  String? bloodType;
 dynamic bottelsCount;
  dynamic hospitalId;
  String? transfareTime;
  String? operationType;
  String? operationTypeDetail;
  String? requestLatitude;
  String? requestLongitude;
 dynamic distance;
  dynamic followUpPhone;
dynamic deletedAt;
  String? key;
  String? createdAt;
  String? updatedAt;
  Hospital? hospital;
  AcceptedBy? acceptedBy;

  Data(
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
      this.acceptedBy});

  Data.fromJson(Map<String, dynamic> json) {
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
    followUpPhone = json['follow_up_phone'];
    deletedAt = json['deleted_at'];
    key = json['key'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    hospital = json['hospital'] != null
        ? new Hospital.fromJson(json['hospital'])
        : null;
    acceptedBy = json['accepted_by'] != null
        ? new AcceptedBy.fromJson(json['accepted_by'])
        : null;
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
    if (this.acceptedBy != null) {
      data['accepted_by'] = this.acceptedBy!.toJson();
    }
    return data;
  }
}

class Hospital {
  int? id;
  String? name;
  Null? deletedAt;
  String? key;
  String? createdAt;
  String? updatedAt;

  Hospital(
      {this.id,
      this.name,
      this.deletedAt,
      this.key,
      this.createdAt,
      this.updatedAt});

  Hospital.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    deletedAt = json['deleted_at'];
    key = json['key'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['deleted_at'] = this.deletedAt;
    data['key'] = this.key;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class AcceptedBy {
  int? id;
  String? name;
  Null? email;
  Null? emailVerifiedAt;
  String? phone;
  Null? gender;
  String? bloodtype;
  String? usertype;
  String? birthdate;
  String? address;
  bool? isPaid;
  bool? isActive;
  bool? isVerified;
  Null? image;
  Null? worklocation;
  double? latitude;
  double? longitude;
  String? key;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

  AcceptedBy(
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
      this.key,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  AcceptedBy.fromJson(Map<String, dynamic> json) {
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
    key = json['key'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['key'] = this.key;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}

class NotificationPaginationResponse {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

  NotificationPaginationResponse(
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

  NotificationPaginationResponse.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? type;
  String? notifiableType;
  int? notifiableId;
  NotificationData? data;
  String? readAt;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.type,
      this.notifiableType,
      this.notifiableId,
      this.data,
      this.readAt,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    notifiableType = json['notifiable_type'];
    notifiableId = json['notifiable_id'];
    data = json['data'] != null ? new NotificationData.fromJson(json['data']) : null;
    readAt = json['read_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['notifiable_type'] = this.notifiableType;
    data['notifiable_id'] = this.notifiableId;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['read_at'] = this.readAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class NotificationData {
  Messages? messages;
  DrugRequest? drugRequest;
  User? user;

  NotificationData({this.messages, this.drugRequest, this.user});

  NotificationData.fromJson(Map<String, dynamic> json) {
    messages = json['messages'] != null
        ? new Messages.fromJson(json['messages'])
        : null;
    drugRequest = json['drug_request'] != null
        ? new DrugRequest.fromJson(json['drug_request'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.messages != null) {
      data['messages'] = this.messages!.toJson();
    }
    if (this.drugRequest != null) {
      data['drug_request'] = this.drugRequest!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Messages {
  String? ar;
  String? en;

  Messages({this.ar, this.en});

  Messages.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ar'] = this.ar;
    data['en'] = this.en;
    return data;
  }
}

class DrugRequest {
  int? id;
  int? userId;
  String? drugName;
  String? latitude;
  String? longitude;
  String? distance;
  String? status;
  String? image;
  String? insuranceCompany;
  String? insuranceImage;
  String? key;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  User? user;

  DrugRequest(
      {this.id,
      this.userId,
      this.drugName,
      this.latitude,
      this.longitude,
      this.distance,
      this.status,
      this.image,
      this.insuranceCompany,
      this.insuranceImage,
      this.key,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.user});

  DrugRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    drugName = json['drug_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    distance = json['distance'];
    status = json['status'];
    image = json['image'];
    insuranceCompany = json['insurance_company'];
    insuranceImage = json['insurance_image'];
    key = json['key'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['drug_name'] = this.drugName;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['distance'] = this.distance;
    data['status'] = this.status;
    data['image'] = this.image;
    data['insurance_company'] = this.insuranceCompany;
    data['insurance_image'] = this.insuranceImage;
    data['key'] = this.key;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  Null? email;
  Null? emailVerifiedAt;
  String? phone;
  Null? gender;
  String? bloodtype;
  String? usertype;
  String? birthdate;
  Null? address;
  bool? isPaid;
  bool? isActive;
  bool? isVerified;
  String? image;
  Null? worklocation;
  double? latitude;
  double? longitude;
  String? key;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

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
      this.key,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

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

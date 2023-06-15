class CurrentUser {
  int? id;
  String? type;
  String? name;
  dynamic phone;
  String? gender;
  String? bloodtype;
  String? usertype;
  String? birthdate;
  String? address;
  bool? isPaid;
  bool? isActive;
  dynamic isVerified;
  dynamic latitude;
 dynamic longitude;
 dynamic image;
  dynamic worklocation;
  String? key;
  String? createdAt;
  dynamic token;

  CurrentUser(
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

  CurrentUser.fromJson(Map<String, dynamic> json) {
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

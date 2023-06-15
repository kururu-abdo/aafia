class DriverModel {
  int? id;
  String? name;
  String? phone;
  double? latitude;
  double? longitude;
  String? address;
  String? deviceToken;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  DriverModel(
      {this.id,
      this.name,
      this.phone,
      this.latitude,
      this.longitude,
      this.address,
      this.deviceToken,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  DriverModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    deviceToken = json['device_token'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['address'] = this.address;
    data['device_token'] = this.deviceToken;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

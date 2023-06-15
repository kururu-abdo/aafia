import 'dart:developer';

class HospitalModel {
  int? id;
  String? name;
  String? deletedAt;
  String? key;
  String? createdAt;
  String? updatedAt;

  HospitalModel(
      {this.id,
      this.name,
      this.deletedAt,
      this.key,
      this.createdAt,
      this.updatedAt});

  HospitalModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id']??'';
    name = json['name'];
    deletedAt = json['deleted_at']??'';
    key = json['key'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    } catch (e) {
      log(e.toString());
    }
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

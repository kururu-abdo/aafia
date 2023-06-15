class ConfigModel {
  String? baseUrl;
  String? apiUrl;
  String? imagesUrl;

  ConfigModel({this.baseUrl, this.apiUrl, this.imagesUrl});

  ConfigModel.fromJson(Map<String, dynamic> json) {
    baseUrl = json['base_url'];
    apiUrl = json['api_url'];
    imagesUrl = json['images_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base_url'] = this.baseUrl;
    data['api_url'] = this.apiUrl;
    data['images_url'] = this.imagesUrl;
    return data;
  }
}

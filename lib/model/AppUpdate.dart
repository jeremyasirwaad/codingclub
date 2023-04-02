class appupdate {
  UpdateData? data;

  appupdate({this.data});

  appupdate.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new UpdateData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UpdateData {
  int? id;
  Attributes? attributes;

  UpdateData({this.id, this.attributes});

  UpdateData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.toJson();
    }
    return data;
  }
}

class Attributes {
  String? version;
  String? apklink;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;

  Attributes(
      {this.version,
      this.apklink,
      this.createdAt,
      this.updatedAt,
      this.publishedAt});

  Attributes.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    apklink = json['apklink'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['version'] = this.version;
    data['apklink'] = this.apklink;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['publishedAt'] = this.publishedAt;
    return data;
  }
}
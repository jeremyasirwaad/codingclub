class NewsModel {
  List<NewsData>? data;

  NewsModel({this.data});

  NewsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <NewsData>[];
      json['data'].forEach((v) {
        data!.add(new NewsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewsData {
  int? id;
  Attributes? attributes;

  NewsData({this.id, this.attributes});

  NewsData.fromJson(Map<String, dynamic> json) {
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
  String? appTitle;
  String? appDesc;
  String? appFlyer;
  String? appData;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;

  Attributes(
      {this.appTitle,
      this.appDesc,
      this.appFlyer,
      this.appData,
      this.createdAt,
      this.updatedAt,
      this.publishedAt});

  Attributes.fromJson(Map<String, dynamic> json) {
    appTitle = json['AppTitle'];
    appDesc = json['AppDesc'];
    appFlyer = json['AppFlyer'];
    appData = json['AppData'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AppTitle'] = this.appTitle;
    data['AppDesc'] = this.appDesc;
    data['AppFlyer'] = this.appFlyer;
    data['AppData'] = this.appData;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['publishedAt'] = this.publishedAt;
    return data;
  }
}

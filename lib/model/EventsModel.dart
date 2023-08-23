import 'dart:ffi';

class EventsModel {
  List<EventData>? data;

  EventsModel({this.data});

  EventsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <EventData>[];
      json['data'].forEach((v) {
        data!.add(new EventData.fromJson(v));
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

class EventData {
  int? id;
  Attributes? attributes;

  EventData({this.id, this.attributes});

  EventData.fromJson(Map<String, dynamic> json) {
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
  String? appEventDate;
  String? appShortDescription;
  String? appResgisterationGformLink;
  String? appEventData;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;
  String? appPoster;
  bool? isOpen;

  Attributes(
      {this.appTitle,
      this.appEventDate,
      this.appShortDescription,
      this.appResgisterationGformLink,
      this.appEventData,
      this.createdAt,
      this.updatedAt,
      this.publishedAt,
      this.appPoster,
      this.isOpen});

  Attributes.fromJson(Map<String, dynamic> json) {
    appTitle = json['AppTitle'];
    appEventDate = json['AppEventDate'];
    appShortDescription = json['AppShortDescription'];
    appResgisterationGformLink = json['App_Resgisteration_Gform_Link'];
    appEventData = json['App_Event_Data'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    appPoster = json['App_Poster'];
    isOpen = json['isOpen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AppTitle'] = this.appTitle;
    data['AppEventDate'] = this.appEventDate;
    data['AppShortDescription'] = this.appShortDescription;
    data['App_Resgisteration_Gform_Link'] = this.appResgisterationGformLink;
    data['App_Event_Data'] = this.appEventData;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['publishedAt'] = this.publishedAt;
    data['App_Poster'] = this.appPoster;
    data['isOpen'] = this.isOpen;
    return data;
  }
}

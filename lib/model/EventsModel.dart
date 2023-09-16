
class EventsModel {
  List<EventData>? data;

  EventsModel({this.data});

  EventsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <EventData>[];
      json['data'].forEach((v) {
        data!.add(EventData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
        ? Attributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (attributes != null) {
      data['attributes'] = attributes!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AppTitle'] = appTitle;
    data['AppEventDate'] = appEventDate;
    data['AppShortDescription'] = appShortDescription;
    data['App_Resgisteration_Gform_Link'] = appResgisterationGformLink;
    data['App_Event_Data'] = appEventData;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['publishedAt'] = publishedAt;
    data['App_Poster'] = appPoster;
    data['isOpen'] = isOpen;
    return data;
  }
}

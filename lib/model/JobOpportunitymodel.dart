class JobOpportunity {
  List<JobOpportunityData>? data;

  JobOpportunity({this.data});

  JobOpportunity.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <JobOpportunityData>[];
      json['data'].forEach((v) {
        data!.add(JobOpportunityData.fromJson(v));
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

class JobOpportunityData {
  int? id;
  Attributes? attributes;

  JobOpportunityData({this.id, this.attributes});

  JobOpportunityData.fromJson(Map<String, dynamic> json) {
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
  String? jobTitle;
  String? postingDate;
  String? jobShortDescription;
  String? jobPoster;
  String? eventData;
  String? contactlink;

  Attributes(
      {this.jobTitle,
      this.postingDate,
      this.jobShortDescription,
      this.jobPoster,
      this.eventData,
      this.contactlink});

  Attributes.fromJson(Map<String, dynamic> json) {
    jobTitle = json['JobTitle'];
    postingDate = json['PostingDate'];
    jobShortDescription = json['JobShortDescription'];
    jobPoster = json['Job_Poster'];
    eventData = json['Event_data'];
    contactlink = json['contactlink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['JobTitle'] = jobTitle;
    data['PostingDate'] = postingDate;
    data['JobShortDescription'] = jobShortDescription;
    data['Job_Poster'] = jobPoster;
    data['Event_data'] = eventData;
    data['contactlink'] = contactlink;
    return data;
  }
}

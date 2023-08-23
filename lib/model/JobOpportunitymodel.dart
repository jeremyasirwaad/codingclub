class JobOpportunity {
  List<JobOpportunityData>? data;

  JobOpportunity({this.data});

  JobOpportunity.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <JobOpportunityData>[];
      json['data'].forEach((v) {
        data!.add(new JobOpportunityData.fromJson(v));
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

class JobOpportunityData {
  int? id;
  Attributes? attributes;

  JobOpportunityData({this.id, this.attributes});

  JobOpportunityData.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['JobTitle'] = this.jobTitle;
    data['PostingDate'] = this.postingDate;
    data['JobShortDescription'] = this.jobShortDescription;
    data['Job_Poster'] = this.jobPoster;
    data['Event_data'] = this.eventData;
    data['contactlink'] = this.contactlink;
    return data;
  }
}

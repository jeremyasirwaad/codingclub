class GctSchedulesmodel {
  List<Data>? data;

  GctSchedulesmodel({this.data});

  GctSchedulesmodel.fromJson(List json) {
    data = <Data>[];
    for (var v in json) {
      data!.add(Data.fromJson(v));
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

class Data {
  int? id;
  String? eventname;
  String? starttime;
  String? endtime;
  String? location;

  Data({this.id, this.eventname, this.starttime, this.endtime, this.location});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventname = json['eventname'];
    starttime = json['starttime'];
    endtime = json['endtime'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['eventname'] = this.eventname;
    data['starttime'] = this.starttime;
    data['endtime'] = this.endtime;
    data['location'] = this.location;
    return data;
  }
}

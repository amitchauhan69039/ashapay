import 'dart:convert';
FamilyActivityModel familyActivityModelFromJson(String str) => FamilyActivityModel.fromJson(json.decode(str));

String familyActivityModelToJson(FamilyActivityModel data) => json.encode(data.toJson());

class FamilyActivityModel {
  String? status;
  FamilyActivityData? data;
  String? message;

  FamilyActivityModel({this.status, this.data, this.message});

  FamilyActivityModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new FamilyActivityData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class FamilyActivityData {
  List<Activities>? activities;

  FamilyActivityData({this.activities});

  FamilyActivityData.fromJson(Map<String, dynamic> json) {
    if (json['activities'] != null) {
      activities = <Activities>[];
      json['activities'].forEach((v) {
        activities!.add(new Activities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.activities != null) {
      data['activities'] = this.activities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Activities {
  int? activityId;
  String? activityName;
  List<Members>? members;

  Activities({this.activityId, this.activityName, this.members});

  Activities.fromJson(Map<String, dynamic> json) {
    activityId = json['activityId'];
    activityName = json['activityName'];
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(new Members.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activityId'] = this.activityId;
    data['activityName'] = this.activityName;
    if (this.members != null) {
      data['members'] = this.members!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Members {
  String? memberId;
  String? memberName;
  String? spousename;
  String? dob;
  String? gender;
  String? lmpDate;
  String? regdate;
  String? deathDate;
  List<Vaccinations>? vaccinations;

  Members(
      {this.memberId,
        this.memberName,
        this.spousename,
        this.dob,
        this.gender,
        this.lmpDate,
        this.regdate,
        this.deathDate,
        this.vaccinations});

  Members.fromJson(Map<String, dynamic> json) {
    memberId = json['memberId'];
    memberName = json['memberName'];
    spousename = json['spousename'];
    dob = json['dob'];
    gender = json['gender'];
    lmpDate = json['lmpDate'];
    regdate = json['regdate'];
    deathDate = json['deathDate'];
    if (json['vaccinations'] != null) {
      vaccinations = <Vaccinations>[];
      json['vaccinations'].forEach((v) {
        vaccinations!.add(new Vaccinations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['memberId'] = this.memberId;
    data['memberName'] = this.memberName;
    data['spousename'] = this.spousename;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['lmpDate'] = this.lmpDate;
    data['regdate'] = this.regdate;
    data['deathDate'] = this.deathDate;
    if (this.vaccinations != null) {
      data['vaccinations'] = this.vaccinations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vaccinations {
  String? ageStage;
  List<Vaccines>? vaccines;

  Vaccinations({this.ageStage, this.vaccines});

  Vaccinations.fromJson(Map<String, dynamic> json) {
    ageStage = json['ageStage'];
    if (json['vaccines'] != null) {
      vaccines = <Vaccines>[];
      json['vaccines'].forEach((v) {
        vaccines!.add(new Vaccines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ageStage'] = this.ageStage;
    if (this.vaccines != null) {
      data['vaccines'] = this.vaccines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vaccines {
  int? vacID;
  String? name;
  String? action;
  String? date;

  Vaccines({this.vacID, this.name, this.action, this.date});

  Vaccines.fromJson(Map<String, dynamic> json) {
    vacID = json['vacID'];
    name = json['name'];
    action = json['action'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vacID'] = this.vacID;
    data['name'] = this.name;
    data['action'] = this.action;
    data['date'] = this.date;
    return data;
  }
}
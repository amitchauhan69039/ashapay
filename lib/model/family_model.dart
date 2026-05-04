import 'dart:convert';

List<FamilyData> familyModelFromJson(String str) => List<FamilyData>.from(json.decode(str).map((x) => FamilyData.fromJson(x)));

String familyModelToJson(List<FamilyData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FamilyModel {
  String? status;
  int? hodCount;
  List<FamilyData>? data;

  FamilyModel({this.status, this.hodCount, this.data});

  FamilyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    hodCount = json['hodCount'];
    if (json['data'] != null) {
      data = <FamilyData>[];
      json['data'].forEach((v) {
        data!.add(new FamilyData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['hodCount'] = this.hodCount;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FamilyData {
  String? familyId;
  Hod? hod;
  List<Members>? members;

  FamilyData({this.familyId, this.hod, this.members});

  FamilyData.fromJson(Map<String, dynamic> json) {
    familyId = json['familyId'];
    hod = json['hod'] != null ? new Hod.fromJson(json['hod']) : null;
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(new Members.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['familyId'] = this.familyId;
    if (this.hod != null) {
      data['hod'] = this.hod!.toJson();
    }
    if (this.members != null) {
      data['members'] = this.members!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hod {
  String? familyId;
  String? headName;
  String? memberId;
  String? createdDate;

  Hod({this.familyId, this.headName, this.memberId, this.createdDate});

  Hod.fromJson(Map<String, dynamic> json) {
    familyId = json['familyId'];
    headName = json['headName'];
    memberId = json['memberId'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['familyId'] = this.familyId;
    data['headName'] = this.headName;
    data['memberId'] = this.memberId;
    data['createdDate'] = this.createdDate;
    return data;
  }
}

class Members {
  int? id;
  String? familyId;
  String? memberId;
  String? memberName;
  String? dob;
  String? gender;
  String? abhaId;
  String? addharId;
  int? createdUser;
  String? createdDate;
  String? updateDate;
  int? isActive;

  Members(
      {this.id,
        this.familyId,
        this.memberId,
        this.memberName,
        this.dob,
        this.gender,
        this.abhaId,
        this.addharId,
        this.createdUser,
        this.createdDate,
        this.updateDate,
        this.isActive});

  Members.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    familyId = json['familyId'];
    memberId = json['memberId'];
    memberName = json['memberName'];
    dob = json['dob'];
    gender = json['gender'];
    abhaId = json['abhaId'];
    addharId = json['addharId'];
    createdUser = json['createdUser'];
    createdDate = json['createdDate'];
    updateDate = json['updateDate'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['familyId'] = this.familyId;
    data['memberId'] = this.memberId;
    data['memberName'] = this.memberName;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['abhaId'] = this.abhaId;
    data['addharId'] = this.addharId;
    data['createdUser'] = this.createdUser;
    data['createdDate'] = this.createdDate;
    data['updateDate'] = this.updateDate;
    data['isActive'] = this.isActive;
    return data;
  }
}

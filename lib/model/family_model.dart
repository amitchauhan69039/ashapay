import 'dart:convert';

List<FamilyData> familyModelFromJson(String str) => List<FamilyData>.from(json.decode(str).map((x) => FamilyData.fromJson(x)));

String familyModelToJson(List<FamilyData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FamilyModel {
  String? status;
  List<FamilyData>? data;

  FamilyModel({this.status, this.data});

  FamilyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
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
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FamilyData {
  String? familyId;
  List<Members>? members;

  FamilyData({this.familyId, this.members});

  FamilyData.fromJson(Map<String, dynamic> json) {
    familyId = json['familyId'];
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
    if (this.members != null) {
      data['members'] = this.members!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Members {
  int? id;
  String? familyId;
  String? memberId;
  String? memberName;
  int? age;
  dynamic dob;
  String? gender;
  dynamic relation;
  String? abhaId;
  String? addharId;
  int? createdUser;
  String? createdDate;
  dynamic updateDate;
  int? isActive;

  Members(
      {this.id,
        this.familyId,
        this.memberId,
        this.memberName,
        this.age,
        this.dob,
        this.gender,
        this.relation,
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
    age = json['age'];
    dob = json['dob'];
    gender = json['gender'];
    relation = json['relation'];
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
    data['age'] = this.age;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['relation'] = this.relation;
    data['abhaId'] = this.abhaId;
    data['addharId'] = this.addharId;
    data['createdUser'] = this.createdUser;
    data['createdDate'] = this.createdDate;
    data['updateDate'] = this.updateDate;
    data['isActive'] = this.isActive;
    return data;
  }
}


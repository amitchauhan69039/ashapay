import 'dart:convert';

GetMotherChildModel getMotherChildModelFromJson(String str) => GetMotherChildModel.fromJson(json.decode(str));

class GetMotherChildModel {
  String? status;
  Data? data;

  GetMotherChildModel({this.status, this.data});

  GetMotherChildModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? familyId;
  List<PregnantWomens>? pregnantWomens;
  List<Children>? children;

  Data({this.familyId, this.pregnantWomens, this.children});

  Data.fromJson(Map<String, dynamic> json) {
    familyId = json['familyId'];
    if (json['pregnantWomens'] != null) {
      pregnantWomens = <PregnantWomens>[];
      json['pregnantWomens'].forEach((v) {
        pregnantWomens!.add(new PregnantWomens.fromJson(v));
      });
    }
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(new Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['familyId'] = this.familyId;
    if (this.pregnantWomens != null) {
      data['pregnantWomens'] =
          this.pregnantWomens!.map((v) => v.toJson()).toList();
    }
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PregnantWomens {
  String? memberId;
  String? name;
  String? age;
  String? lmpWeeks;
  List<VaccinationDetail>? vaccinationDetail;

  PregnantWomens(
      {this.memberId,
        this.name,
        this.age,
        this.lmpWeeks,
        this.vaccinationDetail});

  PregnantWomens.fromJson(Map<String, dynamic> json) {
    memberId = json['memberId'];
    name = json['name'];
    age = json['age'];
    lmpWeeks = json['lmpWeeks'];
    if (json['vaccinationDetail'] != null) {
      vaccinationDetail = <VaccinationDetail>[];
      json['vaccinationDetail'].forEach((v) {
        vaccinationDetail!.add(new VaccinationDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['memberId'] = this.memberId;
    data['name'] = this.name;
    data['age'] = this.age;
    data['lmpWeeks'] = this.lmpWeeks;
    if (this.vaccinationDetail != null) {
      data['vaccinationDetail'] =
          this.vaccinationDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VaccinationDetail {
  String? vacStatus;
  int? vaccinationId;
  String? vaccinationName;
  Null? vaccinationDate;

  VaccinationDetail(
      {this.vacStatus,
        this.vaccinationId,
        this.vaccinationName,
        this.vaccinationDate});

  VaccinationDetail.fromJson(Map<String, dynamic> json) {
    vacStatus = json['vacStatus'];
    vaccinationId = json['vaccinationId'];
    vaccinationName = json['vaccinationName'];
    vaccinationDate = json['vaccinationDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vacStatus'] = this.vacStatus;
    data['vaccinationId'] = this.vaccinationId;
    data['vaccinationName'] = this.vaccinationName;
    data['vaccinationDate'] = this.vaccinationDate;
    return data;
  }
}

class Children {
  String? memberId;
  String? name;
  String? dob;
  String? age;
  String? gender;
  String? status;
  List<VaccinationDetail>? vaccinationDetail;

  Children(
      {this.memberId,
        this.name,
        this.dob,
        this.age,
        this.gender,
        this.status,
        this.vaccinationDetail});

  Children.fromJson(Map<String, dynamic> json) {
    memberId = json['memberId'];
    name = json['name'];
    dob = json['dob'];
    age = json['age'];
    gender = json['gender'];
    status = json['status'];
    if (json['vaccinationDetail'] != null) {
      vaccinationDetail = <VaccinationDetail>[];
      json['vaccinationDetail'].forEach((v) {
        vaccinationDetail!.add(new VaccinationDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['memberId'] = this.memberId;
    data['name'] = this.name;
    data['dob'] = this.dob;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['status'] = this.status;
    if (this.vaccinationDetail != null) {
      data['vaccinationDetail'] =
          this.vaccinationDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
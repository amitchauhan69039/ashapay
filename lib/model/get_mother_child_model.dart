import 'dart:convert';

GetMotherChildModel getMotherChildModelFromJson(String str) =>
    GetMotherChildModel.fromJson(json.decode(str));

String motherChildModelToJson(GetMotherChildModel data) =>
    json.encode(data.toJson());

class GetMotherChildModel {
  String? status;
  Data? data;
  String? message;

  GetMotherChildModel({
    this.status,
    this.data,
    this.message,
  });

  GetMotherChildModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    data = json['data'] != null ? Data.fromJson(json['data']) : null;

    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['status'] = status;

    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }

    data['message'] = message;

    return data;
  }
}

class Data {
  String? familyId;

  List<PregnantWomens>? pregnantWomens;

  List<Children>? children;

  Data({
    this.familyId,
    this.pregnantWomens,
    this.children,
  });

  Data.fromJson(Map<String, dynamic> json) {
    familyId = json['familyId'];

    if (json['pregnantWomens'] != null) {
      pregnantWomens = <PregnantWomens>[];

      json['pregnantWomens'].forEach((v) {
        pregnantWomens!.add(
          PregnantWomens.fromJson(v),
        );
      });
    }

    if (json['children'] != null) {
      children = <Children>[];

      json['children'].forEach((v) {
        children!.add(
          Children.fromJson(v),
        );
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['familyId'] = familyId;

    if (pregnantWomens != null) {
      data['pregnantWomens'] = pregnantWomens!.map((v) => v.toJson()).toList();
    }

    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class PregnantWomens {
  String? memberId;
  String? name;
  String? age;
  String? lmpWeeks;
  String? edd;

  List<VaccinationDetail>? vaccinationDetail;

  PregnantWomens({
    this.memberId,
    this.name,
    this.age,
    this.lmpWeeks,
    this.edd,
    this.vaccinationDetail,
  });

  PregnantWomens.fromJson(Map<String, dynamic> json) {
    memberId = json['memberId'];

    name = json['name'];

    age = json['age'];

    lmpWeeks = json['lmpWeeks'];
    edd = json['edd'];

    if (json['vaccinationDetail'] != null) {
      vaccinationDetail = <VaccinationDetail>[];

      json['vaccinationDetail'].forEach((v) {
        vaccinationDetail!.add(
          VaccinationDetail.fromJson(v),
        );
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['memberId'] = memberId;

    data['name'] = name;

    data['age'] = age;

    data['lmpWeeks'] = lmpWeeks;

    data['edd'] = edd;

    if (vaccinationDetail != null) {
      data['vaccinationDetail'] =
          vaccinationDetail!.map((v) => v.toJson()).toList();
    }

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

  Children({
    this.memberId,
    this.name,
    this.dob,
    this.age,
    this.gender,
    this.status,
    this.vaccinationDetail,
  });

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
        vaccinationDetail!.add(
          VaccinationDetail.fromJson(v),
        );
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['memberId'] = memberId;

    data['name'] = name;

    data['dob'] = dob;

    data['age'] = age;

    data['gender'] = gender;

    data['status'] = status;

    if (vaccinationDetail != null) {
      data['vaccinationDetail'] =
          vaccinationDetail!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class VaccinationDetail {
  String? vacStatus;
  int? vaccinationId;
  String? vaccinationName;
  String? vaccinationDate;

  VaccinationDetail({
    this.vacStatus,
    this.vaccinationId,
    this.vaccinationName,
    this.vaccinationDate,
  });

  VaccinationDetail.fromJson(Map<String, dynamic> json) {
    vacStatus = json['vacStatus'];

    vaccinationId = json['vaccinationId'];

    vaccinationName = json['vaccinationName'];

    vaccinationDate = json['vaccinationDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['vacStatus'] = vacStatus;

    data['vaccinationId'] = vaccinationId;

    data['vaccinationName'] = vaccinationName;

    data['vaccinationDate'] = vaccinationDate;

    return data;
  }
}

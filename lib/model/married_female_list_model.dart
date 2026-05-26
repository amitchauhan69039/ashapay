import 'dart:convert';
MarriedFemaleListModel marriedFemaleListModelFromJson(String str) => MarriedFemaleListModel.fromJson(json.decode(str));

String marriedFemaleListModelToJson(MarriedFemaleListModel data) => json.encode(data.toJson());

class MarriedFemaleListModel {
  String? status;
  Data? data;

  MarriedFemaleListModel({this.status, this.data});

  MarriedFemaleListModel.fromJson(Map<String, dynamic> json) {
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
  List<MariedWomens>? mariedWomens;

  Data({this.familyId, this.mariedWomens});

  Data.fromJson(Map<String, dynamic> json) {
    familyId = json['familyId'];
    if (json['mariedWomens'] != null) {
      mariedWomens = <MariedWomens>[];
      json['mariedWomens'].forEach((v) {
        mariedWomens!.add(new MariedWomens.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['familyId'] = this.familyId;
    if (this.mariedWomens != null) {
      data['mariedWomens'] = this.mariedWomens!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MariedWomens {
  String? memberId;
  String? name;
  int? age;
  String? husbandName;

  MariedWomens({this.memberId, this.name, this.age, this.husbandName});

  MariedWomens.fromJson(Map<String, dynamic> json) {
    memberId = json['memberId'];
    name = json['name'];
    age = json['age'];
    husbandName = json['husbandName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['memberId'] = this.memberId;
    data['name'] = this.name;
    data['age'] = this.age;
    data['husbandName'] = this.husbandName;
    return data;
  }
}
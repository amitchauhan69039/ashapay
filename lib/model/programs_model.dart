import 'package:asha_pay/asha_pay.dart';

List<ProgramsData> programsModelFromJson(String str) => List<ProgramsData>.from(json.decode(str).map((x) => ProgramsData.fromJson(x)));

String programsModelToJson(List<ProgramsData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProgramsModel {
  String? status;
  List<ProgramsData>? data;
  String? message;

  ProgramsModel({this.status, this.data, this.message});

  ProgramsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ProgramsData>[];
      json['data'].forEach((v) {
        data!.add(new ProgramsData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class ProgramsData {
  int? programmeId;
  String? programmeName;

  ProgramsData({this.programmeId, this.programmeName});

  ProgramsData.fromJson(Map<String, dynamic> json) {
    programmeId = json['programmeId'];
    programmeName = json['programmeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['programmeId'] = this.programmeId;
    data['programmeName'] = this.programmeName;
    return data;
  }
}

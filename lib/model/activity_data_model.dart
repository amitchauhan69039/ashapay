import 'dart:convert';
ActivityDataModel activityDataModelFromJson(String str) => ActivityDataModel.fromJson(json.decode(str));

String activityDataModelToJson(ActivityDataModel data) => json.encode(data.toJson());

class ActivityDataModel {
  String? status;
  List<ActivityData>? data;
  String? message;

  ActivityDataModel({this.status, this.data, this.message});

  ActivityDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ActivityData>[];
      json['data'].forEach((v) {
        data!.add(new ActivityData.fromJson(v));
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

class ActivityData {
  int? activityId;
  String? activityName;

  ActivityData({this.activityId, this.activityName});

  ActivityData.fromJson(Map<String, dynamic> json) {
    activityId = json['activityId'];
    activityName = json['activityName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activityId'] = this.activityId;
    data['activityName'] = this.activityName;
    return data;
  }
}
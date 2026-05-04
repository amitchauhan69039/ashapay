import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? status;
  LoginData? data;
  String? message;

  LoginModel({this.status, this.data, this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
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

class LoginData {
  String? token;
  int? id;
  String? username;
  int? roleid;
  String? name;
  String? mobileNo;
  String? gender;

  LoginData(
      {this.token,
        this.id,
        this.username,
        this.roleid,
        this.name,
        this.mobileNo,
        this.gender});

  LoginData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
    username = json['username'];
    roleid = json['roleid'];
    name = json['name'];
    mobileNo = json['mobileNo'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['id'] = this.id;
    data['username'] = this.username;
    data['roleid'] = this.roleid;
    data['name'] = this.name;
    data['mobileNo'] = this.mobileNo;
    data['gender'] = this.gender;
    return data;
  }
}


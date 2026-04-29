import 'package:asha_pay/asha_pay.dart';

List<ApplicationData> applicationsModelFromJson(String str) => List<ApplicationData>.from(json.decode(str).map((x) => ApplicationData.fromJson(x)));

String applicationsModelToJson(List<ApplicationData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ApplicationData {
  dynamic? registerId;
  dynamic? registerYear;
  dynamic? regnNumber;
  dynamic? applicantName;
  dynamic? mobileNo;
  dynamic? victimTrial;
  dynamic? isDemandRaised;
  dynamic? caseStatus;
  dynamic? submitDate;
  dynamic? receivedSource;
  dynamic? receiptNum;
  dynamic? receiptDate;
  dynamic? receivedBy;

  ApplicationData (
      {this.registerId,
        this.registerYear,
        this.regnNumber,
        this.applicantName,
        this.mobileNo,
        this.victimTrial,
        this.isDemandRaised,
        this.caseStatus,
        this.submitDate,
        this.receivedSource,
        this.receiptNum,
        this.receiptDate,
        this.receivedBy});

  ApplicationData.fromJson(Map<String, dynamic> json) {
    registerId = json['register_id'];
    registerYear = json['register_year'];
    regnNumber = json['regn_number'];
    applicantName = json['applicant_name'];
    mobileNo = json['mobile_no'];
    victimTrial = json['victim_trial'];
    isDemandRaised = json['is_demand_raised'];
    caseStatus = json['case_status'];
    submitDate = json['submit_date'];
    receivedSource = json['received_source'];
    receiptNum = json['receipt_num'];
    receiptDate = json['receipt_date'];
    receivedBy = json['received_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['register_id'] = this.registerId;
    data['register_year'] = this.registerYear;
    data['regn_number'] = this.regnNumber;
    data['applicant_name'] = this.applicantName;
    data['mobile_no'] = this.mobileNo;
    data['victim_trial'] = this.victimTrial;
    data['is_demand_raised'] = this.isDemandRaised;
    data['case_status'] = this.caseStatus;
    data['submit_date'] = this.submitDate;
    data['received_source'] = this.receivedSource;
    data['receipt_num'] = this.receiptNum;
    data['receipt_date'] = this.receiptDate;
    data['received_by'] = this.receivedBy;
    return data;
  }
}

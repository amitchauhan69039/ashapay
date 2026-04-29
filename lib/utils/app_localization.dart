import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'package:asha_pay/asha_pay.dart';

class AppLocalization extends Translations {
  @override
  Map<String, Map<String, String>> get keys {
    return {
      'en_US': enUs,
    };
  }

  Map<String, String> enUs = {
    "asha_pay_scheme": "Victim Compensation Scheme",
    "mobile_number": "Mobile Number",
    "get_otp": "Get OTP",
    "mobile_number": "Mobile Number",
    "get_otp": "GET OTP",
    "please_enter_mobile_number": "Please enter Mobile Number",
    "enter_verification_code":"Enter Verification Code",
    "we_have_sent_code":"We have sent a code to +91",
    "resend_otp": "Resend OTP",
    "submit": "Submit",
    "logout": "Logout",
    "cancel" : "Cancel",
    "yes": "Yes",
    "are_you_sure_you_want_to_sign_out": "Are you sure you want to Sign Out?",
    "total_application": "Total Application",
    "new_application": "New Application",
    "trial" : "Trial",
    "without_trial" : "Without Trial",
    "sine_die_application": "Sine Die Application",
    "rejected_application": "Rejected Application",
    "disposed_off_application": "Disposed Off Application",
    "pending_application": "Pending Application",
    "submitted_on": "Submitted On",
    "police_station": "Police Station",
    "district": "District",
    "fir_no_date": "FIR No. & Date",
    "mobile_no": "Mobile No.",
    "applicant_name": "Applicant Name",
    "regn_number": "Regn. Number"


  };
}


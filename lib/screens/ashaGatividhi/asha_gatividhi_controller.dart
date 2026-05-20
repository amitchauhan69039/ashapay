import 'package:asha_pay/asha_pay.dart';
import 'package:asha_pay/model/family_model.dart' hide Members;
import 'package:asha_pay/screens/home/api/programsApi.dart';

import '../../model/family_activity_model.dart';
import '../../model/get_family_activity_model.dart';

class AshaGatividhiController extends GetxController {
  bool loader = false;
  GetFamilyActivityModel? familyActivityModel;
  final TextEditingController searchCtrl = TextEditingController();
  FamilyData? familyData;
  bool isCouple=false;
  bool isLmp=false;
  bool isDeath=false;
  String activityid="";
  List<FamilyMembers> selectedMembers=[];
  List<FamilyMembers> selectedCouplesMembers=[];
  List<String> lmpDates = [];
  List<String> regDates = [];

  @override
  void onInit() {
    super.onInit();

  }

  Future<void> getActivitybyFamilyId(String familyId) async {

    loader = true;
    Map<String,String> body = {
      "familyid": familyId,
      "Programid": "1",
    };
    update(['asha_gatividhi']);
    try {
      GetFamilyActivityModel? model = await ProgramsApi.getActivitybyFamilyId(body);

      if (model != null) {
        if (model.status!.toLowerCase() == "success") {
          familyActivityModel=model;

          for(int i=0;i<familyActivityModel!.data!.activities!.length;i++){
            if(familyActivityModel!.data!.activities![i].activityId==4){
              if(familyActivityModel!.data!.activities![i].members!.isEmpty){
                isCouple=false;

              } else{
                for (var member in familyActivityModel!.data!.activities![i].members!){
                  selectedCouplesMembers.add(FamilyMembers(memberId: member.memberId,memberName: member.memberName,));
                }

                isCouple=true;
              }
            }

            if(familyActivityModel!.data!.activities![i].activityId==1){
              if(familyActivityModel!.data!.activities![i].members!.isEmpty){


                isLmp=false;
              } else{
                isLmp=true;
              }
            }
          }


        } else {
          toastMsg( model.message ?? 'Something went wrong');
        }
      }
    } catch (e) {
      debugPrint("Unexpected response format: ${e.toString()}");
    }

    loader = false;
    update(['asha_gatividhi']);
  }


  Future<void> dataSubmit() async {

    if(activityid!=""){

    loader = true;
    Map<String, dynamic> body= {};

    if(activityid=="4"){
      body = {
        "programId": 1,
        "familyId": familyData!.familyId,
        "activities": [
          {
            "activityId": activityid,
            "members": [
              {
                "memberId":selectedCouplesMembers[0].memberId,
                "memberName": selectedCouplesMembers[0].memberName,
                "spouseName": selectedCouplesMembers[1].memberName,
                "deathDate": "",
                "lmpDate": "",
                "dateOfReg": "",
                "action": "",
                "vaccinations": [
                  {
                    "vaccineType": "",
                    "vaccineName": "",
                    "action": "",
                    "date": ""
                  }
                ]
              }
            ]
          }
        ]
      };
    }else if(activityid=="1"){
      body = {
        "programId": 1,
        "familyId": familyData!.familyId,
        "activities": [
          {
            "activityId": activityid,
            "members": List.generate(
              selectedMembers.length,
                  (index) => {
                "memberId": selectedMembers[index].memberId!,
                "memberName": selectedMembers[index].memberName,
                "spouseName": "",
                "deathDate": "",
                "lmpDate": lmpDates.length > index
                    ? lmpDates[index]
                    : "",
                "dateOfReg": regDates.length > index
                    ? regDates[index]
                    : "",
                "action": "",
                "vaccinations": [
                  {
                    "vaccineType": "",
                    "vaccineName": "",
                    "action": "",
                    "date": ""
                  }
                ]
              },
            ),
          }
        ]
      };
    }

    update(['asha_gatividhi']);
    try {
      final success =  await ProgramsApi.addAshaMembersActivity(body);

      if (success) {
        Get.snackbar(
          "सफल",
          "गतिविधि सफलतापूर्वक जोड़ दिया गया",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );


      } else {
        Get.snackbar(
          "त्रुटि",
          "डेटा सेव नहीं हुआ",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint("Unexpected response format: ${e.toString()}");
    }

    loader = false;
    update(['asha_gatividhi']);

    }
  }

}
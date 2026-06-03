import 'package:asha_pay/asha_pay.dart';
import 'package:asha_pay/screens/BaalSwasthya/childListScreen.dart';
import 'package:asha_pay/screens/IodineTest/iodine_test_screen.dart';
import 'package:asha_pay/screens/home/controller/programs_controller.dart';
import 'package:asha_pay/screens/kushtRogSurvey/kusht_survey_screen.dart';
import 'package:asha_pay/screens/matri%20swasthya/mothers_list_screen.dart';
import 'package:asha_pay/tbSurvey/tb_survey_screen.dart';

import '../../model/family_model.dart';


import 'package:asha_pay/asha_pay.dart';
import 'package:flutter/material.dart';

import '../../model/family_model.dart';
import '../../model/get_family_activity_model.dart';


class AshaGatividhiListScreen extends StatefulWidget {
  final String programmeId;
  final FamilyData familyData;
  AshaGatividhiListScreen({super.key,required this.programmeId,required this.familyData});

  @override
  State<AshaGatividhiListScreen> createState() => _AshaGatividhiListScreenState();
}

class _AshaGatividhiListScreenState extends State<AshaGatividhiListScreen> {
  final AshaGatividhiListController controller = Get.put(AshaGatividhiListController());
  bool selectedNo5 = true;
  bool selectedNo6 = true;
  bool selectedNo7 = true;

  @override
  void initState() {

    super.initState();
    controller.getAshaActivityMaster(widget.programmeId);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xff0f7df2),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'आशा गतिविधि',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body:Column(
          children: [

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),

                // 🔥 GetBuilder
                child: GetBuilder<AshaGatividhiListController>(
                  id: 'asha_gatividhi_list',
                  builder: (controller) {

                    // 🔹 Loader
                    if (controller.loader) {
                      return Center(child: CircularProgressIndicator());
                    }

                    // 🔹 Empty State
                    if (controller.activityDataModel == null ||
                        controller.activityDataModel!.data!.isEmpty) {
                      return Center(child: Text("No Data Found"));
                    }

                    // 🔹 List
                    return Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: ListView.builder(
                        padding: EdgeInsets.all(16),
                        itemCount: controller.activityDataModel!.data!.length,
                        itemBuilder: (context, index) {

                          final item = controller.activityDataModel!.data![index];

                          return InkWell(
                              onTap: () {

                                print("kldnldsn ${widget.programmeId} ${item.activityId}");

                                if(widget.programmeId=="1" ){
                                 if(item.activityId==1){
                                    Get.to(()=> PragnantLadiesScreen(familyData: widget.familyData,programId: widget.programmeId,activityId: item.activityId.toString(), ));
                                  }else if(item.activityId==2){
                                    Get.to(()=> VaccinationListScreen(familyData: widget.familyData));
                                  }else  if(item.activityId==4){
                                  Get.to(()=> CoupleScreen(familyData: widget.familyData,programId: widget.programmeId,activityId: item.activityId.toString(), ));
                                }else if(item.activityId==5){
                                    Get.to(()=> BirthDeathScreen(familyData: widget.familyData,programId: widget.programmeId,activityId: item.activityId.toString(), ));
                                  }
                                }else  if(widget.programmeId=="2" ){
                                  if(item.activityId==9){
                                    Get.to(()=> MothersListScreen(familyData: widget.familyData,
                                      programId: widget.programmeId, activityId: item.activityId.toString(), ));
                                  }
                                }else  if(widget.programmeId=="4" ){
                                  if(item.activityId == 21){
                                    Get.to(()=> ChildListScreen(familyData: widget.familyData,
                                      programId: widget.programmeId, activityId: item.activityId.toString(), ));
                                  }
                                }else if(widget.programmeId=="15" ){
                                  if(item.activityId == 6){
                                    Get.to(()=> MonthlyActivityScreen(activity:"6" ,programId: widget.programmeId, ));
                                  }
                                  if(item.activityId == 7){
                                    Get.to(()=> MonthlyActivityScreen(activity: "7", programId: widget.programmeId,));
                                  }
                                  if(item.activityId == 8){
                                    Get.to(()=> MonthlyActivityScreen( activity: "8",programId: widget.programmeId,));
                                  }
                                }else if(widget.programmeId=="7" ){
                                  if(item.activityId == 37){
                                    Get.to(
                                          ()=> IodineSurveyScreen(
                                        familyData: widget.familyData,
                                        programId: 7,
                                        activityId: 37,
                                      ),
                                    );
                                  }
                                }else if(widget.programmeId=="8" ){
                                  if(item.activityId == 44){
                                    Get.to(()=> KushtSurveyScreen(
                                        familyData: widget.familyData,
                                        programId: 8,
                                        activityId: 44,
                                      ),
                                    );
                                  }else if(item.activityId == 45){
                                    Get.to(()=> KushtSurveyScreen(
                                        familyData: widget.familyData,
                                        programId: 8,
                                        activityId: 45,
                                      ),
                                    );
                                  }else if(item.activityId == 46){
                                    Get.to(()=> KushtSurveyScreen(
                                        familyData: widget.familyData,
                                        programId: 8,
                                        activityId: 46,
                                      ),
                                    );
                                  }
                                }
                              },
                              child: programCard(item.activityName ?? ""),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),

    );
  }


  // 🔹 Card
  Widget programCard(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: Color(0xFF2F7FB6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 24,fontWeight: FontWeight.w700),
            ),
          ),
          appSizedBox(width: 10),
          Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18)
        ],
      ),
    );
  }

}



class AshaGatividhiListScreen2 extends StatefulWidget {
  final String programmeId;
  AshaGatividhiListScreen2({super.key,required this.programmeId,});

  @override
  State<AshaGatividhiListScreen2> createState() => _AshaGatividhiListScreen2State();



}


class _AshaGatividhiListScreen2State extends State<AshaGatividhiListScreen2> {
  final AshaGatividhiListController controller = Get.put(AshaGatividhiListController());
  bool selectedNo5 = true;
  bool selectedNo6 = true;
  bool selectedNo7 = true;

  @override
  void initState() {

    super.initState();
    controller.getAshaActivityMaster(widget.programmeId);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff0f7df2),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'आशा गतिविधि',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body:Column(
        children: [

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),

              // 🔥 GetBuilder
              child: GetBuilder<AshaGatividhiListController>(
                id: 'asha_gatividhi_list',
                builder: (controller) {

                  // 🔹 Loader
                  if (controller.loader) {
                    return Center(child: CircularProgressIndicator());
                  }

                  // 🔹 Empty State
                  if (controller.activityDataModel == null ||
                      controller.activityDataModel!.data!.isEmpty) {
                    return Center(child: Text("No Data Found"));
                  }

                  // 🔹 List
                  return Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: controller.activityDataModel!.data!.length,
                      itemBuilder: (context, index) {

                        final item = controller.activityDataModel!.data![index];

                        return InkWell(
                          onTap: () {

                            print("kldnldsn ${widget.programmeId} ${item.activityId}");

                          if(widget.programmeId=="15" ){
                              if(item.activityId == 6){
                                Get.to(()=> MonthlyActivityScreen(activity:"6" , programId: widget.programmeId,));
                              }
                              if(item.activityId == 7){
                                Get.to(()=> MonthlyActivityScreen(activity: "7", programId: widget.programmeId,));
                              }
                              if(item.activityId == 8){
                                Get.to(()=> MonthlyActivityScreen( activity: "8",programId: widget.programmeId,));
                              }
                            }else if(widget.programmeId=="7" ){
                            if(item.activityId == 37){
                              Get.to(()=> ParivarSelectionScreen(
                                  onFamilyTap: (familyData){
                                    Get.to(
                                          ()=> IodineSurveyScreen(
                                        familyData: familyData,
                                            programId: 7,
                                            activityId: 37,
                                      ),
                                    );

                                  },
                                ),
                              );
                            }
                          }else if(widget.programmeId=="8" ){
                            if(item.activityId == 38){
                              Get.to(
                                    ()=> ParivarSelectionScreen(

                                  onFamilyTap: (familyData){

                                    Get.to(
                                          ()=> TBSurveyScreen(

                                        familyData: familyData,

                                        programId: 8,

                                        activityId: 38,
                                      ),
                                    );

                                  },
                                ),
                              );
                            }
                          }
                          },
                          child: programCard(item.activityName ?? ""),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),

    );
  }

  // 🔹 Card
  Widget programCard(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: Color(0xFF2F7FB6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 24,fontWeight: FontWeight.w700),
            ),
          ),
          appSizedBox(width: 10),
          Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18)
        ],
      ),
    );
  }

}

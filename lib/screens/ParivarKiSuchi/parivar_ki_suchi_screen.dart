import 'package:flutter/material.dart';

import '../../asha_pay.dart';
import '../../model/family_model.dart';

class ParivarKiSuchiScreen extends StatefulWidget {
  final String step;
  final FamilyData familyData;

  const ParivarKiSuchiScreen({
    super.key,
    required this.step,
    required this.familyData,
  });

  @override
  State<ParivarKiSuchiScreen> createState() =>
      _ParivarKiSuchiScreenState();
}

class _ParivarKiSuchiScreenState extends State<ParivarKiSuchiScreen> {

  final ParivarKiSuchiController controller =Get.put(ParivarKiSuchiController());

  /// Dynamic member list with selected status
  final List<Map<String, dynamic>> members = [];

  @override
  void initState() {
    super.initState();


    if(widget.step=="step3"){
      for (var member in widget.familyData.members!) {
        if ((member.age ?? 0) >= 18 && (member.age ?? 0) <= 49) {
          members.add({
            'member': member,
            'name': member.memberName ?? '',
            'selected': false,
          });
        }
      }
    }else{
      for (var member in widget.familyData.members!) {
        members.add({
          'member': member,
          'name': member.memberName ?? '',
          'selected': false,
        });
      }
    }
    /// Create local list from API/member data



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
          'परिवार की सूची',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      body: GetBuilder<AshaGatividhiController>(
        id: 'parivar_suchi',
        builder: (controller) {
          return StackedLoader(
            loading: controller.loader,

            child: SafeArea(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),

                children: [

                  /// Member List
                  ...List.generate(
                    members.length,
                        (index) {
                      return Container(
                        height: 60,
                        margin: const EdgeInsets.only(bottom: 14),

                        decoration: BoxDecoration(
                          color: const Color(0xffe8e6f2),
                          borderRadius: BorderRadius.circular(2),
                        ),

                        child: Row(
                          children: [

                            /// Left Icon Box
                            Container(
                              width: 60,
                              color: const Color(0xff2785d1),

                              child: const Center(
                                child: Icon(
                                  Icons.person_outline,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            /// Member Name
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),

                                child: Text(
                                  members[index]['name'],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),

                            /// Checkbox
                            InkWell(
                              onTap: () {
                                setState(() {
                                  members[index]['selected'] =
                                  !members[index]['selected'];
                                });
                              },

                              child: Container(
                                width: 25,
                                height: 25,
                                margin: const EdgeInsets.only(right: 18),

                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xff0f7df2),
                                    width: 2,
                                  ),
                                ),

                                child: members[index]['selected']
                                    ? const Icon(
                                  Icons.check,
                                  size: 20,
                                )
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 10),

                  /// Button
                  Align(
                    alignment: Alignment.centerRight,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),

                      onPressed: () {

                        /// STEP 1
                        if (widget.step == "step1") {

                         // final List<String> selectedMembers = [];
                          final List<FamilyMembers> selectedMembers = [];

                          for (int i = 0; i < members.length; i++) {
                            if (members[i]['selected'] == true) {
                              selectedMembers.add(
                                members[i]['member'],
                              );
                            }
                          }

                          Get.back(result: selectedMembers);
                        }

                        if (widget.step == "step4") {

                          // final List<String> selectedMembers = [];
                          final List<FamilyMembers> selectedMembers = [];

                          int selected = 0;
                          for (int i = 0; i < members.length; i++) {
                            if (members[i]['selected'] == true) {
                              selected++;
                              selectedMembers.add(
                                members[i]['member'],
                              );
                            }
                          }

                          if (selected != 1) {

                            toastMsg(
                              "Please select only one member",
                            );

                          } else {

                            Get.back(
                              result: selectedMembers,
                            );
                          }



                        }

                        /// STEP 3
                        if (widget.step == "step3") {

                          final List<FamilyMembers> selectedMembers = [];
                          int selected = 0;

                          for (int i = 0; i < members.length; i++) {
                            if (members[i]['selected'] == true) {

                              selected++;


                              selectedMembers.add(
                                members[i]['member'],
                              );

                            }
                          }

                          if (selected != 2) {

                            toastMsg(
                              "Please select only two members",
                            );

                          } else {

                            Get.back(
                              result: selectedMembers,
                            );
                          }
                        }
                      },

                      child: Text(
                        widget.step == "step3"? "परिवार जोड़ें" :widget.step == "step1" ? "महिलाएँ जोड़ें":widget.step == "step4"?"डेटा पोस्ट करें":"परिवार जोड़ें" ,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
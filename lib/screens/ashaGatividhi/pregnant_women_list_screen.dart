import 'package:flutter/material.dart';

import '../../asha_pay.dart';
import '../../model/family_model.dart';
import '../../model/get_mother_child_model.dart';

class PregnantWomenListScreen extends StatefulWidget {
  final FamilyData familyData;

  const PregnantWomenListScreen({super.key,required this.familyData,});

  @override
  State<PregnantWomenListScreen> createState() => _PregnantWomenListScreenState();
}

class _PregnantWomenListScreenState extends State<PregnantWomenListScreen> {

  final ParivarKiSuchiController controller =Get.put(ParivarKiSuchiController());

  /// Dynamic member list with selected status
  final List<Map<String, dynamic>> members = [];

  @override
  void initState() {
    super.initState();


    getPregnantWomen();

  }


  Future<void> getPregnantWomen() async {
    await controller.getMotherChildListWithId(
      widget.familyData.familyId!,
    );

    members.clear();

    final pregnantWomen = controller.motherChildModel?.data?.pregnantWomens ?? [];

    for (var woman in pregnantWomen) {
      members.add({
        'member': woman,
        'name': woman.name ?? '',
        'selected': false,
      });
    }

    setState(() {});
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
        id: 'asha_gatividhi_list',
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
                        final List<PregnantWomens> selectedMembers = [];

                        for (int i = 0; i < members.length; i++) {
                          if (members[i]['selected'] == true) {
                            selectedMembers.add(
                              members[i]['member'],
                            );
                          }
                        }

                        Get.back(result: selectedMembers);
                      },

                      child: Text(
                        "महिलाएँ जोड़ें" ,
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
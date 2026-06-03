import 'package:asha_pay/common/widget/loaders.dart';
import 'package:asha_pay/model/family_model.dart';
import 'package:asha_pay/screens/IodineTest/iodine_test_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IodineSurveyScreen extends StatelessWidget {

  final FamilyData familyData;
  final int programId;
  final int activityId;

  IodineSurveyScreen({
    super.key,
    required this.familyData,
    required this.programId,
    required this.activityId,
  });

  final IodineSurveyController controller =
  Get.put(IodineSurveyController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xffF8F9FD),

      appBar: AppBar(
        backgroundColor: const Color(0xff2F7DBD),
        elevation: 0,

        title: const Text(
          "आयोडीन सर्वे",
          style: TextStyle(
            color: Colors.white,
          ),
        ),

        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),

      body: GetBuilder<IodineSurveyController>(
        id: "iodine_survey",

        builder: (controller) {

          return StackedLoader(

            loading: controller.loader,

            child: SingleChildScrollView(

              padding: const EdgeInsets.all(16),

              child: Column(
                children: [

                  /// ================= TOP CARD =================

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),

                    decoration: BoxDecoration(
                      color: const Color(0xff2F7DBD),
                      borderRadius:
                      BorderRadius.circular(20),
                    ),

                    child: const Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        Icon(
                          Icons.health_and_safety,
                          color: Colors.white,
                          size: 34,
                        ),

                        SizedBox(height: 12),

                        Text(
                          "आयोडीन युक्त नमक सर्वे",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        SizedBox(height: 8),

                        Text(
                          "परिवार से पूछकर सही विकल्प चुनें",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// ================= FAMILY CARD =================

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),

                    decoration: cardDecoration(),

                    child: Row(
                      children: [

                        Container(
                          padding:
                          const EdgeInsets.all(12),

                          decoration: BoxDecoration(
                            color:
                            const Color(0xffEAF4FF),

                            borderRadius:
                            BorderRadius.circular(14),
                          ),

                          child: const Icon(
                            Icons.family_restroom,
                            color: Color(0xff2F7DBD),
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,

                            children: [

                              const Text(
                                "Family ID",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                familyData.familyId ?? "",

                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight:
                                  FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// ================= QUESTION CARD =================

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),

                    decoration: cardDecoration(),

                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        const Text(
                          "प्रश्न",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 16),

                        const Text(
                          "क्या परिवार आयोडीन युक्त नमक का उपयोग करता है ?",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                          ),
                        ),

                        const SizedBox(height: 22),

                        Obx(() {

                          return Row(
                            children: [

                              Expanded(
                                child: optionCard(
                                  title: "हाँ",
                                  value: "YES",
                                  icon:
                                  Icons.check_circle,

                                  isSelected:
                                  controller.answer.value
                                      == "YES",
                                ),
                              ),

                              const SizedBox(width: 14),

                              Expanded(
                                child: optionCard(
                                  title: "नहीं",
                                  value: "NO",
                                  icon: Icons.cancel,

                                  isSelected:
                                  controller.answer.value
                                      == "NO",
                                ),
                              ),
                            ],
                          );
                        }),

                        const SizedBox(height: 20),

                        TextFormField(
                          controller:
                          controller.remarksController,

                          maxLines: 3,

                          decoration: InputDecoration(

                            hintText:
                            "Remarks (optional)",

                            filled: true,

                            fillColor:
                            const Color(0xffF5F7FA),

                            border: OutlineInputBorder(

                              borderRadius:
                              BorderRadius.circular(14),

                              borderSide:
                              BorderSide.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  /// ================= SUBMIT BUTTON =================

                  SizedBox(
                    width: double.infinity,
                    height: 54,

                    child: Obx(() {

                      return ElevatedButton(

                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          const Color(0xff2F7DBD),

                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(16),
                          ),
                        ),

                        onPressed:
                        controller.answer.value.isEmpty
                            ? null
                            : () {

                          controller.submitSurvey(
                            familyData,
                            programId,
                            activityId,
                          );
                        },

                        child: const Text(
                          "Submit",

                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight:
                            FontWeight.w700,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// ================= OPTION CARD =================

  Widget optionCard({

    required String title,
    required String value,
    required IconData icon,
    required bool isSelected,

  }) {

    return InkWell(

      borderRadius: BorderRadius.circular(16),

      onTap: () {
        controller.answer.value = value;
      },

      child: Container(

        padding:
        const EdgeInsets.symmetric(vertical: 18),

        decoration: BoxDecoration(

          color: isSelected
              ? const Color(0xff2F7DBD)
              : const Color(0xffEEF5FF),

          borderRadius:
          BorderRadius.circular(16),

          border: Border.all(

            color: isSelected
                ? const Color(0xff2F7DBD)
                : Colors.grey.shade300,
          ),
        ),

        child: Column(
          children: [

            Icon(
              icon,

              color: isSelected
                  ? Colors.white
                  : const Color(0xff2F7DBD),

              size: 30,
            ),

            const SizedBox(height: 8),

            Text(
              title,

              style: TextStyle(

                color: isSelected
                    ? Colors.white
                    : const Color(0xff2F7DBD),

                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= CARD DECORATION =================

  BoxDecoration cardDecoration() {

    return BoxDecoration(

      color: Colors.white,

      borderRadius: BorderRadius.circular(20),

      boxShadow: [

        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 12,
          offset: const Offset(0, 5),
        ),
      ],
    );
  }
}
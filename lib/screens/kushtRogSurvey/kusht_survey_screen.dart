import 'package:asha_pay/model/family_model.dart';
import 'package:asha_pay/screens/kushtRogSurvey/kusht_survey_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/widget/loaders.dart';

class KushtSurveyScreen extends StatelessWidget {
  final FamilyData familyData;
  final int programId;
  final int activityId;

  KushtSurveyScreen({
    super.key,
    required this.familyData,
    required this.programId,
    required this.activityId,
  });

  final KushtSurveyController controller =
  Get.put(KushtSurveyController());

  bool get showTreatmentFields =>
      activityId == 45 || activityId == 46;

  @override
  Widget build(BuildContext context) {
    controller.setFamilyMembers(familyData);

    return Scaffold(
      backgroundColor: const Color(0xffF8F9FD),
      appBar: AppBar(
        backgroundColor: const Color(0xff2F7DBD),
        elevation: 0,
        title: const Text(
          "कुष्ठ रोग सर्वे",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GetBuilder<KushtSurveyController>(
        id: "kusht_survey",
        builder: (controller) {
          return StackedLoader(
            loading: controller.loader,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _topCard(),
                  const SizedBox(height: 18),
                  _familyCard(),
                  const SizedBox(height: 18),
                  _questionCard(context),
                  const SizedBox(height: 28),
                  _submitButton(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _topCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xff2F7DBD),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.medical_services, color: Colors.white, size: 34),
          const SizedBox(height: 12),
          Text(
            showTreatmentFields
                ? "कुष्ठ रोग इलाज प्रबंधन"
                : "कुष्ठ रोगी सर्वे",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            showTreatmentFields
                ? "रोगी के इलाज की जानकारी दर्ज करें"
                : "परिवार में कुष्ठ रोगी की जानकारी दर्ज करें",
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _familyCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: cardDecoration(),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xffEAF4FF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.family_restroom,
              color: Color(0xff2F7DBD),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Family ID",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 4),
                Text(
                  familyData.familyId ?? "",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _questionCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "प्रश्न",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),

          Text(
            showTreatmentFields
                ? "कुष्ठ रोगी का चयन करें और इलाज की जानकारी भरें"
                : "क्या परिवार में कोई कुष्ठ रोगी है ?",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 22),

          if (!showTreatmentFields)
            Obx(() {
              return Row(
                children: [
                  Expanded(
                    child: optionCard(
                      title: "हाँ",
                      value: "YES",
                      icon: Icons.check_circle,
                      isSelected: controller.answer.value == "YES",
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: optionCard(
                      title: "नहीं",
                      value: "NO",
                      icon: Icons.cancel,
                      isSelected: controller.answer.value == "NO",
                    ),
                  ),
                ],
              );
            }),

          if (showTreatmentFields)
            Builder(
              builder: (_) {
                controller.answer.value = "YES";
                return const SizedBox();
              },
            ),

          const SizedBox(height: 20),

          Obx(() {
            if (!showTreatmentFields && controller.answer.value != "YES") {
              return const SizedBox();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "रोगी का चयन करें",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const SizedBox(height: 8),

                DropdownButtonFormField<FamilyMembers>(
                  value: controller.selectedMember.value,
                  isExpanded: true,
                  hint: const Text("रोगी चुनें"),
                  items: controller.memberList.map((member) {
                    return DropdownMenuItem<FamilyMembers>(
                      value: member,
                      child: Text(
                        "${member.memberName ?? "Unknown"} (${member.age ?? "-"})",
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    controller.selectedMember.value = value;
                  },
                  decoration: fieldDecoration(),
                ),

                if (showTreatmentFields) ...[
                  const SizedBox(height: 16),

                  const Text(
                    "कुष्ठ रोग का प्रकार",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 8),

                  DropdownButtonFormField<String>(
                    value: controller.diseaseType.value.isEmpty
                        ? null
                        : controller.diseaseType.value,
                    isExpanded: true,
                    hint: const Text("प्रकार चुनें"),
                    items: const [
                      DropdownMenuItem(value: "PB", child: Text("PB")),
                      DropdownMenuItem(value: "MB", child: Text("MB")),
                    ],
                    onChanged: (value) {
                      controller.diseaseType.value = value ?? "";
                    },
                    decoration: fieldDecoration(),
                  ),

                  const SizedBox(height: 16),

                  Obx(() {
                    return dateField(
                      title: "इलाज शुरू होने की तारीख",
                      value: controller.treatmentStartDate.value,
                      onTap: () async {
                        final date = await pickDate(context);
                        if (date != null) {
                          controller.treatmentStartDate.value =
                              date.toIso8601String();
                        }
                      },
                    );
                  }),

                  const SizedBox(height: 16),

                  Obx(() {
                    return dateField(
                      title: "इलाज समाप्त होने की तारीख",
                      value: controller.treatmentEndDate.value,
                      onTap: () async {
                        final date = await pickDate(context);
                        if (date != null) {
                          controller.treatmentEndDate.value =
                              date.toIso8601String();
                        }
                      },
                    );
                  }),

                  const SizedBox(height: 16),

                  const Text(
                    "क्या दवाई ली जा रही है?",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 8),

                  Obx(() {
                    return Row(
                      children: [
                        Expanded(
                          child: smallOptionCard(
                            title: "हाँ",
                            value: "YES",
                            selectedValue: controller.medicineTaken.value,
                            onTap: () {
                              controller.medicineTaken.value = "YES";
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: smallOptionCard(
                            title: "नहीं",
                            value: "NO",
                            selectedValue: controller.medicineTaken.value,
                            onTap: () {
                              controller.medicineTaken.value = "NO";
                            },
                          ),
                        ),
                      ],
                    );
                  }),

                  const SizedBox(height: 16),

                  const Text(
                    "Patient Status",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 8),

                  DropdownButtonFormField<String>(
                    value: controller.patientStatus.value.isEmpty
                        ? null
                        : controller.patientStatus.value,
                    isExpanded: true,
                    hint: const Text("Status चुनें"),
                    items: const [
                      DropdownMenuItem(
                        value: "Treatment Started",
                        child: Text("Treatment Started"),
                      ),
                      DropdownMenuItem(
                        value: "Under Treatment",
                        child: Text("Under Treatment"),
                      ),
                      DropdownMenuItem(
                        value: "Treatment Completed",
                        child: Text("Treatment Completed"),
                      ),
                      DropdownMenuItem(
                        value: "Defaulted",
                        child: Text("Defaulted"),
                      ),
                    ],
                    onChanged: (value) {
                      controller.patientStatus.value = value ?? "";
                    },
                    decoration: fieldDecoration(),
                  ),
                ],

                const SizedBox(height: 16),

                TextFormField(
                  controller: controller.remarksController,
                  maxLines: 3,
                  decoration: fieldDecoration(hint: "Remarks"),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: Obx(() {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff2F7DBD),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: controller.answer.value.isEmpty
              ? null
              : () {
            controller.submitSurvey(
              familyData,
              programId,
              activityId,
              showTreatmentFields,
            );
          },
          child: const Text(
            "Submit",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        );
      }),
    );
  }

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
        if (value == "NO") {
          controller.selectedMember.value = null;
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff2F7DBD) : const Color(0xffEEF5FF),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xff2F7DBD) : Colors.grey.shade300,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : const Color(0xff2F7DBD),
              size: 30,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xff2F7DBD),
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget smallOptionCard({
    required String title,
    required String value,
    required String selectedValue,
    required VoidCallback onTap,
  }) {
    final isSelected = selectedValue == value;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff2F7DBD) : const Color(0xffEEF5FF),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? const Color(0xff2F7DBD) : Colors.grey.shade300,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xff2F7DBD),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  Widget dateField({
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xffF5F7FA),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value.isEmpty ? "तारीख चुनें" : value.split("T").first,
                    style: TextStyle(
                      color: value.isEmpty ? Colors.grey : Colors.black,
                    ),
                  ),
                ),
                const Icon(Icons.calendar_month, color: Color(0xff2F7DBD)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<DateTime?> pickDate(BuildContext context) async {
    return await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
      initialDate: DateTime.now(),
    );
  }

  InputDecoration fieldDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xffF5F7FA),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }

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
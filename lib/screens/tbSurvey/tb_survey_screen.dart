import 'package:asha_pay/common/widget/loaders.dart';
import 'package:asha_pay/model/family_model.dart';
import 'package:asha_pay/screens/tbSurvey/tb_survey_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TBTreatmentScreen extends StatelessWidget {
  final FamilyData familyData;
  final int programId;
  final int activityId;

  TBTreatmentScreen({
    super.key,
    required this.familyData,
    required this.programId,
    required this.activityId,
  });

  final TBTreatmentController controller =
  Get.put(TBTreatmentController());

  @override
  Widget build(BuildContext context) {
    controller.setFamilyMembers(familyData);

    return Scaffold(
      backgroundColor: const Color(0xffF8F9FD),
      appBar: AppBar(
        backgroundColor: const Color(0xff2F7DBD),
        title: const Text(
          "टीबी उपचार",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GetBuilder<TBTreatmentController>(
        id: "tb_treatment",
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
                  _formCard(context),
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.medical_services, color: Colors.white, size: 34),
          SizedBox(height: 12),
          Text(
            "टीबी उपचार विवरण",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "रोगी और उपचार की जानकारी दर्ज करें",
            style: TextStyle(color: Colors.white70, fontSize: 14),
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
      child: Text(
        "Family ID: ${familyData.familyId ?? ""}",
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _formCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label("रोगी का चयन करें"),
          const SizedBox(height: 8),

          Obx(() {
            return DropdownButtonFormField<FamilyMembers>(
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
            );
          }),

          const SizedBox(height: 16),

          label("TB Category"),
          const SizedBox(height: 8),

          Obx(() {
            return DropdownButtonFormField<String>(
              value: controller.tbCategory.value.isEmpty
                  ? null
                  : controller.tbCategory.value,
              isExpanded: true,
              hint: const Text("Category चुनें"),
              items: const [
                DropdownMenuItem(
                  value: "Category 1",
                  child: Text("टी.बी. कैटेगरी 1 का पूर्ण उपचार"),
                ),
                DropdownMenuItem(
                  value: "Category 2",
                  child: Text("टी.बी. कैटेगरी 2 का पूर्ण उपचार"),
                ),
                DropdownMenuItem(
                  value: "MDR 6 Months",
                  child: Text("एम.डी.आर. कैटेगरी 6 महीने"),
                ),
                DropdownMenuItem(
                  value: "MDR 2 Years",
                  child: Text("एम.डी.आर. कैटेगरी 2 वर्ष"),
                ),
              ],
              onChanged: (value) {
                controller.tbCategory.value = value ?? "";
              },
              decoration: fieldDecoration(),
            );
          }),

          const SizedBox(height: 16),

          Obx(() {
            return dateField(
              title: "Treatment Start Date",
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
              title: "Treatment End Date",
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

          label("क्या दवाई ली जा रही है?"),
          const SizedBox(height: 8),

          Obx(() {
            return Row(
              children: [
                Expanded(
                  child: yesNoCard(
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
                  child: yesNoCard(
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

          label("Patient Status"),
          const SizedBox(height: 8),

          Obx(() {
            return DropdownButtonFormField<String>(
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
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff2F7DBD),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: () {
          controller.submitTreatment(
            familyData,
            programId,
            activityId,
          );
        },
        child: const Text(
          "Submit",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget label(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
    );
  }

  Widget yesNoCard({
    required String title,
    required String value,
    required String selectedValue,
    required VoidCallback onTap,
  }) {
    final isSelected = selectedValue == value;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xff2F7DBD)
              : const Color(0xffEEF5FF),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : const Color(0xff2F7DBD),
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
        label(title),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: const Color(0xffF5F7FA),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value.isEmpty
                        ? "तारीख चुनें"
                        : value.split("T").first,
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

  InputDecoration fieldDecoration() {
    return InputDecoration(
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
    );
  }
}
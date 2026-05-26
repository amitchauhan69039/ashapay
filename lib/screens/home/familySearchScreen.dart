import 'package:asha_pay/asha_pay.dart';
import 'package:asha_pay/screens/familyListing/addFamilyScreen.dart';
import 'package:intl/intl.dart';
import '../../model/family_model.dart';
import 'controller/family_controller.dart';

class FamilySearchScreen extends StatelessWidget {
  final controller = Get.put(FamilyController());
  FamilySearchScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFF2F7FB6),

      body: GetBuilder<FamilyController>(
        id: FamilyController.familySearchID,
        builder: (controller) {
          return SafeArea(
            child: Column(
              children: [
                // HEADER
                const CommonHeader(title: "ASHA Worker"),

                // BODY
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),

                    child: Column(
                      children: [
                        // 🔍 SEARCH SECTION
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),

                          child: Column(
                            children: [
                              // FAMILY ID FIELD
                              CommonTextField(
                                controller: controller.searchCtrl,
                                hintText: "Family ID डालें",
                                fillColor: Colors.grey.shade300,
                                showBorder: false,
                                errorText: controller.familyIdError,
                              ),

                              const SizedBox(height: 16),

                              // SEARCH BUTTON
                              AppButton(
                                buttonName: controller.isLoading
                                    ? "Loading..." : "परिवार खोजें",
                                onTap: () async {
                                  await controller.searchFamily(controller.searchCtrl.text.trim());
                                },
                              ),

                              const SizedBox(height: 16),

                              // OR
                              Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color:
                                      Colors.grey.shade400,
                                    ),
                                  ),

                                  Padding(
                                    padding:
                                    EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: Text("या", style: styleW400S14),
                                  ),

                                  Expanded(
                                    child: Divider(
                                      color:
                                      Colors.grey.shade400,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16),

                              // 🔹 ADD FAMILY
                              AppButton(
                                buttonName: "नया परिवार जोड़ें",
                                onTap: () {
                                  Get.to(() => AddFamilyScreen());
                                },
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),

                        // BODY CONTENT
                        Expanded(
                          child: Builder(
                            builder: (_) {
                              // LOADING
                              if (controller.isLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              // INITIAL EMPTY
                              if (!controller.hasSearched) {
                                return const SizedBox();
                              }

                              // MEMBERS
                              final members = controller.familyList.isNotEmpty
                                  ? controller.familyList.first.members ?? []
                                  : [];

                              // NO FAMILY
                              if (members.isEmpty) {
                                return Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.all(12),
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: Colors.orange),
                                    ),

                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.search_off,
                                          size: 60,
                                          color: Colors.orange,
                                        ),
                                        const SizedBox(height: 15),
                                        const Text(
                                          "परिवार नहीं मिला",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight:
                                            FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(height: 10),

                                        Text(
                                          "इस Family ID से कोई परिवार नहीं मिला।\nकृपया नया परिवार जोड़ें।",
                                          textAlign: TextAlign.center,
                                          style: styleW400S16,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }

                              /// ✅ FAMILY FOUND
                              return ListView.builder(
                                itemCount: members.length + 1,
                                itemBuilder: (context, index) {

                                  /// ➕ LAST ITEM BUTTONS
                                  if (index == members.length) {

                                    return Padding(
                                      padding: const EdgeInsets.all(12),

                                      child: Row(
                                        children: [

                                          /// LOCAL ADD IN UI
                                          Expanded(
                                            child: AppButton(
                                              buttonName: "+ सदस्य जोड़ें",
                                              onTap: controller.addNewMember,
                                            ),
                                          ),

                                          const SizedBox(width: 10),

                                          /// FINAL API SAVE
                                          Expanded(
                                            child: AppButton(
                                              buttonName: "सेव करें",
                                              onTap: controller.hasNewMembers ? () async {
                                                controller.saveFamily();
                                              } : () {
                                                Get.snackbar(
                                                  "Message",
                                                  "पहले नया सदस्य जोड़ें",
                                                  snackPosition: SnackPosition.BOTTOM,
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  final item = members[index];
                                  return Padding(
                                    key: ValueKey("${item.memberId}_$index"),
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    child: familyCard(item, index),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // FAMILY CARD
  Widget familyCard(FamilyMembers item, int index) {
    final controller = Get.find<FamilyController>();

    final isExisting = controller.isExistingMember(item);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        children: [
          /// NAME + ID / STATUS
          Row(
            children: [
              Expanded(
                child: isExisting
                    ? readOnlyField("नाम", item.memberName ?? "")
                    : field(
                  "नाम",
                  item.memberName ?? "",
                      (v) => item.memberName = v,
                  "नाम",
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: isExisting
                    ? readOnlyField("सदस्य आईडी", item.memberId ?? "")
                    : idOrMotherField(item),
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// AADHAR
          isExisting
              ? readOnlyField("आधार", item.addharId ?? "")
              : field("आधार (Optional)", item.addharId ?? "",
                  (v) => item.addharId = v, "आधार"),

          const SizedBox(height: 10),

          /// ABHA
          isExisting
              ? readOnlyField("ABHA", item.abhaId ?? "")
              : field("ABHA (Optional)", item.abhaId ?? "",
                  (v) => item.abhaId = v, "ABHA"),

          const SizedBox(height: 10),

          /// DOB
          isExisting ? readOnlyDOB(item) : dobField(item),

          const SizedBox(height: 10),

          /// GENDER
          isExisting ? readOnlyGender(item) : genderField(item),
        ],
      ),
    );
  }

  // COMMON FIELD
  Widget field(
      String label,
      String value,
      Function(String) onChanged,
      String hint,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 6),

        TextFormField(
          initialValue: value,
          onChanged: onChanged,
          style: const TextStyle(fontSize: 14),

          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 13,
            ),

            filled: true,
            fillColor: Colors.white,

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xff0f7df2),
                width: 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }
  /// 🔹 ID / MOTHER FIELD
  Widget idOrMotherField(FamilyMembers item) {
    final controller = Get.find<FamilyController>();

    final isExisting =
        item.memberId != null && item.memberId!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isExisting ? "सदस्य आईडी" : "स्टेटस",
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 6),

        /// 🔴 EXISTING MEMBER (READ ONLY)
        if (isExisting)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              item.memberId ?? "-",
              style: const TextStyle(fontSize: 14),
            ),
          )

        /// 🟢 NEW MEMBER (DROPDOWN)
        else
          DropdownButtonFormField<String>(
            value: controller.memberStatus[item.hashCode.toString()],

            isExpanded: true,

            items: const [
              DropdownMenuItem(
                value: "NEWBORN",
                child: Text("Newborn"),
              ),
              DropdownMenuItem(
                value: "OTHER",
                child: Text("Other"),
              ),
            ],

            onChanged: (v) {
              controller.memberStatus[item.hashCode.toString()] =
                  v ?? "";
              controller.update([FamilyController.familySearchID]);
            },

            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,

              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),

              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xff0f7df2),
                  width: 1.2,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget dobField(FamilyMembers item) {
    final controller = Get.find<FamilyController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("जन्म तिथि"),
        const SizedBox(height: 6),

        GestureDetector(
          onTap: () async {
            DateTime? picked = await showDatePicker(
              context: Get.context!,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );

            if (picked != null) {
              String formatted =
              DateFormat('yyyy/MM/dd').format(picked);

              item.dob = formatted;

              /// 🔥 IMPORTANT FIX
              controller.update([FamilyController.familySearchID]);
            }
          },

          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(6),
            ),

            child: Text(
              (item.dob == null || item.dob!.isEmpty)
                  ? "जन्म तिथि चुनें"
                  : item.dob!,
              style: TextStyle(
                color: (item.dob == null || item.dob!.isEmpty)
                    ? Colors.grey
                    : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget genderField(FamilyMembers item) {
    final controller = Get.find<FamilyController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "लिंग",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 6),

        DropdownButtonFormField<String>(
          value: (item.gender == "MALE" || item.gender == "FEMALE")
              ? item.gender
              : null,

          isExpanded: true,

          items: const [
            DropdownMenuItem(
              value: "MALE",
              child: Text("Male"),
            ),
            DropdownMenuItem(
              value: "FEMALE",
              child: Text("Female"),
            ),
          ],

          onChanged: (v) {
            item.gender = v ?? "";
            controller.update([FamilyController.familySearchID]);
          },

          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),

            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xff0f7df2),
                width: 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget statusField(FamilyMembers item) {
    final controller = Get.find<FamilyController>();
    final key = item.hashCode.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Status"),
        const SizedBox(height: 5),

        DropdownButtonFormField<String>(
          value: controller.memberStatus[key],

          items: const [
            DropdownMenuItem(
              value: "NEWBORN",
              child: Text("Newborn"),
            ),
            DropdownMenuItem(
              value: "OTHER",
              child: Text("Other"),
            ),
          ],

          onChanged: (v) {
            controller.memberStatus[key] = v ?? "";
          },

          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
      ],
    );
  }

  Widget readOnlyField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(value.isNotEmpty ? value : "-"),
        ),
      ],
    );
  }

  Widget readOnlyDOB(FamilyMembers item) {
    return readOnlyField("जन्म तिथि", item.dob ?? "");
  }

  String getGenderLabel(String? gender) {
    switch (gender) {
      case "M":
        return "Male";
      case "F":
        return "Female";
      case "MALE":
        return "Male";
      case "FEMALE":
        return "Female";
      default:
        return "-";
    }
  }

  Widget readOnlyGender(FamilyMembers item) {
    String value = "-";

    if (item.gender == "M" || item.gender == "MALE" || item.gender == "Male") {
      value = "Male";
    } else if (item.gender == "F" || item.gender == "FEMALE" || item.gender == "Female") {
      value = "Female";
    }

    return readOnlyField("लिंग", value);
  }
}


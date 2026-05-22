import 'package:asha_pay/asha_pay.dart';
import 'package:asha_pay/screens/familyListing/addFamilyScreen.dart';
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
                                    child: familyCard(item),
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
  Widget familyCard(FamilyMembers item) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        children: [
          // 🔹 TOP ROW
          Row(
            children: [
              Expanded(
                child: field("नाम", item.memberName ?? "",
                      (v) {
                    item.memberName = v;
                  },
                  "नाम डालें",
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: idOrMotherField(item),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // AADHAR
          field(
            "आधार आईडी", item.addharId ?? "",
                (v) {
              item.addharId = v;
            },
            "आधार डालें",
          ),

          const SizedBox(height: 10),

          // ABHA
          field(
            "आमा आईडी",
            item.abhaId ?? "",
                (v) {
              item.abhaId = v;
            },
            "आमा आईडी डालें",
          ),
          const SizedBox(height: 10),
          // DOB + GENDER
          Row(
            children: [
              Expanded(
                child: field(
                  "जन्म तिथि",
                  item.dob ?? "",
                      (v) {item.dob = v;
                  },
                  "जन्म तिथि",
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: field(
                  "लिंग",
                  item.gender ?? "",
                      (v) {
                    item.gender = v;
                  },
                  "लिंग चुनें",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // COMMON FIELD
  Widget field(String label, String value, Function(String) onChanged, String hint) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 5),
        TextFormField(
          key: ValueKey("$label-$value"),
          initialValue: value,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
            ),
            border: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(6),
            ),
          ),
        ),
      ],
    );
  }

  /// 🔹 ID / MOTHER FIELD
  Widget idOrMotherField(FamilyMembers item) {
    final controller = Get.find<FamilyController>();

    final isExisting = item.memberId != null && item.memberId!.isNotEmpty;
    final members = controller.familyList.first.members ?? [];
    final index = members.indexOf(item);

    return Column(

      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [

        Text(
          isExisting
              ? "सदस्य आईडी"
              : "स्टेटस",
        ),

        const SizedBox(height: 5),

        /// OLD MEMBER
        isExisting

            ? Container(

          width: double.infinity,

          padding:
          const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 12,
          ),

          decoration: BoxDecoration(

            border: Border.all(
              color: Colors.grey.shade300,
            ),

            borderRadius:
            BorderRadius.circular(6),
          ),

          child: Text(
            item.memberId ?? "",
          ),
        )

        /// NEW MEMBER
            : DropdownButtonFormField<String>(

          value: controller.memberStatus[index],

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

            controller.memberStatus[index] = v ?? "";

          },

          decoration: InputDecoration(

            hintText: "स्टेटस चुनें",

            border: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(6),
            ),
          ),
        ),
      ],
    );
  }
}
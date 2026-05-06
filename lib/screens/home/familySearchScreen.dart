import 'package:asha_pay/asha_pay.dart';
import 'package:asha_pay/model/MemberModel.dart';
import 'package:asha_pay/model/family_model.dart';
import 'controller/family_controller.dart';

class FamilySearchScreen extends StatelessWidget {
  final controller = Get.put(FamilyController());

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

                /// 🔹 HEADER
                CommonHeader(title: "ASHA Worker"),

                /// 🔹 BODY
                Expanded(
                  child:  Container(
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
                        )
                      ],
                    ),
                    child: Column(
                      children: [

                        /// 🔍 SEARCH
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            children: [
                              CommonTextField(
                                controller: controller.searchCtrl,
                                hintText: "Family ID डालें",
                                fillColor: Colors.grey.shade300,
                                showBorder: false,
                                errorText: controller.familyIdError,
                              ),
                              const SizedBox(height: 16),
                              AppButton(
                                buttonName: controller.isLoading
                                    ? "Loading..."
                                    : "परिवार खोजें",
                                onTap: () async {
                                  await controller.searchFamily();
                                },
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),

                        /// 🔥 LIST
                        Expanded(
                          child: Builder(
                            builder: (_) {
                              if (controller.isLoading) {
                                return const Center(child: CircularProgressIndicator());
                              }

                              if (!controller.hasSearched) {
                                return const Center(child: Text(""));
                              }

                              if (controller.membersList.isEmpty) {
                                return const Center(child: Text("No Data Found!"));
                              }

                              return ListView.builder(
                                itemCount: controller.membersList.length + 1,
                                itemBuilder: (context, index) {

                                  /// 🔥 BUTTONS
                                  if (index == controller.membersList.length) {
                                    return Container(
                                      padding: const EdgeInsets.all(12),
                                      color: Colors.white,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: AppButton(
                                              buttonName: "सदस्य जोड़ें",
                                              onTap: () {
                                                controller.addNewMember();
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: AppButton(
                                              buttonName: "परिवार जोड़ें",
                                              onTap: () {
                                                controller.saveFamily();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }

                                  final item = controller.membersList[index];

                                  return Padding(
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

  /// 🔹 CARD
  Widget familyCard(MemberModel item) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [

          Row(
            children: [
              Expanded(
                child: field("नाम", item.nameCtrl, "नाम डालें"),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: idOrMotherField(item),
              ),
            ],
          ),

          const SizedBox(height: 10),

          field("आधार आईडी", item.aadharCtrl, "आधार डालें"),

          const SizedBox(height: 10),

          field("आमा आईडी", item.abhaCtrl, "आमा आईडी डालें"),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: field("जन्म तिथि", item.dobCtrl, "जन्म तिथि"),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: field("लिंग", item.genderCtrl, "लिंग चुनें"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 🔹 COMMON FIELD
  Widget field(String label, TextEditingController ctrl, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 5),
        TextField(
          controller: ctrl,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
      ],
    );
  }

  /// 🔹 ID OR MOTHER FIELD
  Widget idOrMotherField(MemberModel item) {
    final isExisting = item.memberId != null && item.memberId!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(isExisting ? "सदस्य आईडी" : "माँ का नाम"),
        const SizedBox(height: 5),

        isExisting
            ? Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(item.memberId!),
        )
            : TextField(
          controller: item.motherCtrl,
          decoration: InputDecoration(
            hintText: "माँ का नाम डालें",
            hintStyle: TextStyle(color: Colors.grey.shade400),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
      ],
    );
  }


}
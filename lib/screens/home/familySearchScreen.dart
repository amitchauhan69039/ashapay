import 'package:asha_pay/asha_pay.dart';
import 'package:asha_pay/model/family_model.dart';
import 'controller/family_controller.dart';

class FamilySearchScreen extends StatelessWidget {
  final controller = Get.put(FamilyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2F7FB6),

      body: SafeArea(
        child: Column(
          children: [
            // 🔹 Header
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.arrow_back, color: Colors.white),
                  Expanded(
                    child: Center(
                      child: Text(
                        "ASHA Worker",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  appSizedBox(width: 24)
                ],
              ),
            ),

            // 🔹 White Body
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),

                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          CommonTextField(
                            controller: controller.searchCtrl,
                            hintText: "6xgz0695",
                            textInputType: TextInputType.text,
                            fillColor: Colors.grey.shade300,
                            showBorder: false,
                          ),

                          appSizedBox(height: 2.h),

                          AppButton(
                            buttonName: controller.isLoading ? "Loading..." : "परिवार खोजें",
                            isEnabled: !controller.isLoading,
                            onTap: () async {
                              if (controller.isLoading) return;

                              controller.isLoading = true;
                              controller.update();

                              await controller.searchFamily(controller.searchCtrl.text);

                              controller.isLoading = false;
                              controller.update();
                            },
                          ),
                        ],
                      ),
                    ),

                    appSizedBox(height: 3.h),

                    // 🔥 LIST AREA
                    Expanded(
                      child: GetBuilder<FamilyController>(
                        builder: (controller) {

                          // Loader
                          if (controller.isLoading) {
                            return Center(child: CircularProgressIndicator());
                          }

                          // Empty
                          if (controller.familyList.isEmpty) {
                            return Center(child: Text("No Data Found"));
                          }

                          return ListView.builder(
                            itemCount: controller.familyList.length,
                            itemBuilder: (context, familyIndex) {

                              final family = controller.familyList[familyIndex];

                              return Column(
                                children: [
                                  // 🔥 MEMBERS LIST
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: family.members?.length ?? 0,
                                    itemBuilder: (context, memberIndex) {

                                      final member = family.members![memberIndex];

                                      return familyCard(member, memberIndex);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // 🔹 Card UI (same as your design)
  Widget familyCard(Members item, int memberIndex) {
    return Container(
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: field("नाम", item.memberName ?? "", "नाम डालें"),
              ),
              appSizedBox(width: 10),
              Expanded(
                child: field("सदस्य आईडी", item.memberId.toString(), "सदस्य आईडी डालें"),
              ),
            ],
          ),

          appSizedBox(height: 10),
          field("आधार आईडी", item.addharId ?? "", "आधार आईडी डालें"),
          appSizedBox(height: 10),
          field("आमा आईडी", item.abhaId ?? "", "आमा आईडी डालें"),
          appSizedBox(height: 10),

          Row(
            children: [
              Expanded(child: field("जन्म तिथि",item.dob ?? "", "जन्म तिथि डालें")),
              appSizedBox(width: 10),
              Expanded(child: field("लिंग",item.gender ?? "", "लिंग डालें")),
            ],
          ),
        ],
      ),
    );
  }

  Widget field(String label, String value, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        appSizedBox(height: 5),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            (value.isEmpty) ? hint : value,
            style: TextStyle(
              color: (value.isEmpty)
                  ? Colors.grey // 🔥 hint color
                  : Colors.black,
            ),
          ),
        )
      ],
    );
  }
}
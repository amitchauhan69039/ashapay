import 'package:asha_pay/asha_pay.dart';
import 'package:asha_pay/screens/familyListing/AddFamilyController.dart';

class AddFamilyScreen extends StatelessWidget {

  AddFamilyScreen({super.key});

  final controller = Get.put(AddFamilyController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF2F7FB6),

      body: GetBuilder<AddFamilyController>(
        builder: (controller) {

          return SafeArea(
            child: Column(
              children: [

                CommonHeader(title: "नया परिवार जोड़ें"),

                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),

                    decoration: const BoxDecoration(
                      color: Color(0xFFF3F5F7),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),

                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),

                      child: Column(
                        children: [

                          /// ================= HEAD DETAILS =================
                          sectionTitle("मुखिया की जानकारी"),

                          cardField("नाम", controller.headNameCtrl, "नाम"),
                          cardField("मोबाइल", controller.mobileCtrl, "मोबाइल नंबर"),

                          dropdownCard(
                            "लिंग",
                            controller.selectedGender,
                            controller.genderList,
                            controller.changeGender,
                          ),

                          cardField(
                            "जन्म तिथि",
                            controller.dobCtrl,
                            "YYYY/MM/DD",
                            onTap: () => controller.pickDob(context),
                          ),

                          cardField("उम्र", controller.ageCtrl, "ऑटो आएगी"),

                          const SizedBox(height: 16),

                          /// ================= ADDRESS =================
                          sectionTitle("पता विवरण"),

                          cardField("पता", controller.addressCtrl, "पूरा पता"),
                          cardField("गांव / वार्ड", controller.villageCtrl, "गांव"),

                          const SizedBox(height: 16),

                          /// ================= FAMILY =================
                          sectionTitle("परिवार विवरण"),

                          cardField("कुल सदस्य", controller.membersCtrl, "संख्या"),
                          cardField("बच्चों की संख्या", controller.childrenCtrl, "संख्या"),

                          const SizedBox(height: 16),

                          /// ================= SCHEME =================
                          sectionTitle("योजना विवरण"),

                          dropdownCard(
                            "राशन कार्ड",
                            controller.selectedRation,
                            controller.rationList,
                            controller.changeRation,
                          ),

                          dropdownCard(
                            "आय वर्ग",
                            controller.selectedIncome,
                            controller.incomeList,
                            controller.changeIncome,
                          ),

                          const SizedBox(height: 25),

                          /// SAVE BUTTON
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: controller.addNewFamily,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                backgroundColor: const Color(0xFF2F7FB6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                controller.isLoading
                                    ? "Saving..."
                                    : "परिवार सेव करें",
                                style: const TextStyle(fontSize: 16, color: ColorRes.white),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),
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

  /// 🔹 SECTION TITLE
  Widget sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 10),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// 🔹 CARD FIELD
  Widget cardField(
      String label,
      TextEditingController ctrl,
      String hint, {
        VoidCallback? onTap,
      }) {

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
          )
        ],
      ),
      child: TextField(
        controller: ctrl,
        readOnly: onTap != null,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          hintText: hint,
        ),
      ),
    );
  }

  /// 🔹 DROPDOWN CARD
  Widget dropdownCard(
      String title,
      String? value,
      List<String> items,
      Function(String?) onChanged,
      ) {

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
          )
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: title,
          border: InputBorder.none,
        ),
        items: items
            .map((e) => DropdownMenuItem(
          value: e,
          child: Text(e),
        ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
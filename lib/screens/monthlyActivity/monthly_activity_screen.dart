import 'package:asha_pay/asha_pay.dart';
import 'package:flutter/material.dart';

class MonthlyActivityScreen extends StatefulWidget {
  final String activity;
  final String programId;

  const MonthlyActivityScreen({super.key,required this.activity,required this.programId});

  @override
  State<MonthlyActivityScreen> createState() => _MonthlyActivityScreenState();
}

class _MonthlyActivityScreenState extends State<MonthlyActivityScreen> {
  final MonthlyActivityController controller = Get.put(MonthlyActivityController());




  @override
  void initState() {
    super.initState();
    controller.activity=widget.activity;
    controller.programId=widget.programId;
  }

  bool showLmp = false;
  bool showCouple = false;



  List<String> places = ["Delhi", "Mumbai", "Jaipur"];



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
            'मासिक बैठकें',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        body: GetBuilder<MonthlyActivityController>(
            id: 'monthly_activity',
            builder: (controller) {
              return StackedLoader(
                loading: controller.isLoading,
                child: SafeArea(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const SizedBox(height: 12),

                        if (widget.activity=="6") ...[

                          questionText(
                            'ग्राम स्वास्थ्य स्वच्छता पोषण समिति की मासिक बैठक करना',
                          ),
                          const SizedBox(height: 12),
                          _yesNoRow(
                            selectedNo: controller.selectedNo1,
                            onChanged: (value) {
                              setState(() {
                                controller.selectedNo1 = value;
                              });
                            },
                          ),

                          const SizedBox(height: 12),

                          if (!controller.selectedNo1)
                            datePlaceRow(
                              context: context,
                              dateController: controller.dateController,
                              selectedPlace: controller.selectedPlace,
                              places: places,
                              onPlaceChanged: (value) {
                                setState(() {
                                  controller.selectedPlace = value ?? "";
                                });
                              },
                            ),

                          const SizedBox(height: 30),

                        ],

                        if (widget.activity=="7") ...[
                          questionText(
                            'मासिक ग्राम/शहरी स्वास्थ्य पोषण दिवस मनाना',
                          ),
                          const SizedBox(height: 12),
                          _yesNoRow(
                            selectedNo: controller.selectedNo2,
                            onChanged: (value) {
                              setState(() {
                                controller.selectedNo2 = value;
                              });
                            },
                          ),

                          const SizedBox(height: 12),

                          if (!controller.selectedNo2)
                            datePlaceRow(
                              context: context,
                              dateController: controller.dateController,
                              selectedPlace: controller.selectedPlace,
                              places: places,
                              onPlaceChanged: (value) {
                                setState(() {
                                  controller.selectedPlace = value ?? "";
                                });
                              },
                            ),

                          if (!controller.selectedNo2)
                            const SizedBox(height: 8),

                          if (!controller.selectedNo2)
                            SizedBox(
                              height: 60,
                              child: TextField(
                                controller: controller.agendaController,
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText: "चर्चा का एजेंडा चुनें",
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: 16,
                                  ),

                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 0,
                                  ),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                  ),

                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: BorderSide(color: Colors.grey.shade300),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: const BorderSide(color: Colors.blue),
                                  ),
                                ),
                              ),
                            ),



                          const SizedBox(height: 30),

                        ],

                        if (widget.activity=="8") ...[
                          questionText(
                            'प्राथमिक स्वास्थ्य केंद्र पर मासिक मीटिंग में उपस्थित होना',
                          ),

                          const SizedBox(height: 12),
                          _yesNoRow(
                            selectedNo: controller.selectedNo3,
                            onChanged: (value) {
                              setState(() {
                                controller.selectedNo3 = value;
                              });
                            },
                          ),

                          const SizedBox(height: 12),

                          if (!controller.selectedNo3)
                            datePlaceRow(
                              context: context,
                              dateController: controller.dateController,
                              selectedPlace: controller.selectedPlace,
                              places: places,
                              onPlaceChanged: (value) {
                                setState(() {
                                  controller.selectedPlace = value ?? "";
                                });
                              },
                            ),

                          const SizedBox(height: 30),
                        ],

                        AppButton(
                          buttonName: "डेटा जमा करें",
                          height: 45,
                          onTap: () async {

                            controller.addAshaMeetingActivity();
                          },
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              );
            })
    );
  }

  Widget questionText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 22,
        height: 1.3,
        color: Colors.black,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget memberRow({required VoidCallback onTap} ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: const Color(0xffeaf4f4),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              width: 55,
              decoration: const BoxDecoration(
                color: Color(0xff0f7df2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
            const SizedBox(width: 18),
            const Text(
              'सदस्य जोड़ें',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _yesNoRow({
    required bool selectedNo,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: _choiceBox(
            label: 'हां',
            selected: !selectedNo,
            onTap: () => onChanged(false),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _choiceBox(
            label: 'नहीं',
            selected: selectedNo,
            onTap: () => onChanged(true),
          ),
        ),
      ],
    );
  }

  Widget _choiceBox({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        height: 78,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: const Color(0xffeaf4f4),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xff0f7df2),
                  width: 3,
                ),
              ),
              child: selected
                  ? const Icon(
                Icons.check,
                color: Color(0xff0f7df2),
                size: 34,
              )
                  : null,
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget datePlaceRow({
    required BuildContext context,
    required TextEditingController dateController,
    required String selectedPlace,
    required List<String> places,
    required Function(String?) onPlaceChanged,
  }) {
    const double fieldHeight = 50;

    return Row(
      children: [
        /// Date Field
        Expanded(
          child: SizedBox(
            height: fieldHeight,
            child: GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );

                if (pickedDate != null) {
                  dateController.text =
                  "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                }
              },
              child: AbsorbPointer(
                child: TextField(
                  controller: dateController,
                  decoration: InputDecoration(
                    hintText: "दिनांक दर्ज करें",
                    hintStyle:  TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 16,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 12),

        /// Place Dropdown
        Expanded(
          child: SizedBox(
            height: fieldHeight,
            child: DropdownButtonFormField<String>(
              value: selectedPlace.isEmpty ? null : selectedPlace,
              hint: Text(
                "जगह दर्ज करें",
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 16,
                ),
              ),
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down),

              /// 🔥 Important fixes
              isDense: true,
              itemHeight: 50,

              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10, // 👈 control height inside
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),

              items: places.map((place) {
                return DropdownMenuItem(
                  value: place,
                  child: Text(place),
                );
              }).toList(),

              onChanged: onPlaceChanged,
            ),
          ),
        ),
      ],
    );
  }
}
import 'package:asha_pay/asha_pay.dart';
import 'package:flutter/material.dart';

import '../../model/family_model.dart';

class MonthlyActivityScreen extends StatefulWidget {

  const MonthlyActivityScreen({super.key,});

  @override
  State<MonthlyActivityScreen> createState() => _MonthlyActivityScreenState();
}

class _MonthlyActivityScreenState extends State<MonthlyActivityScreen> {
  final MonthlyActivityController controller = Get.put(MonthlyActivityController());
  bool selectedNo1 = true;
  bool selectedNo2 = true;
  bool selectedNo3 = true;

  List<String> lmpDates = [];
  List<String> regDates = [];

  List<String> selectedMembers=[];
  List<String> selectedCouplesMembers=[];

  @override
  void initState() {

    super.initState();

  }


  bool showLmp = false;
  bool showCouple = false;

  TextEditingController dateController = TextEditingController();
  TextEditingController agendaController = TextEditingController();
  String selectedPlace = "";

  List<String> places = ["Delhi", "Mumbai", "Jaipur"];

  String lmp1 = '';
  String reg1 = '';
  String lmp2 = '';
  String reg2 = '';

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

                        questionText(
                          '1. ग्राम स्वास्थ्य स्वच्छता पोषण समिति की मासिक बैठक करना',
                        ),
                        const SizedBox(height: 12),
                        _yesNoRow(
                          selectedNo: selectedNo1,
                          onChanged: (value) {
                            setState(() {
                              selectedNo1 = value;
                            });
                          },
                        ),

                        const SizedBox(height: 12),

                        if (!selectedNo1)
                          datePlaceRow(
                            context: context,
                            dateController: dateController,
                            selectedPlace: selectedPlace,
                            places: places,
                            onPlaceChanged: (value) {
                              setState(() {
                                selectedPlace = value ?? "";
                              });
                            },
                          ),

                        const SizedBox(height: 20),

                        questionText(
                          '6. मासिक ग्राम/शहरी स्वास्थ्य पोषण दिवस मनाना',
                        ),
                        const SizedBox(height: 12),
                        _yesNoRow(
                          selectedNo: selectedNo2,
                          onChanged: (value) {
                            setState(() {
                              selectedNo2 = value;
                            });
                          },
                        ),

                        const SizedBox(height: 12),

                        if (!selectedNo2)
                          datePlaceRow(
                            context: context,
                            dateController: dateController,
                            selectedPlace: selectedPlace,
                            places: places,
                            onPlaceChanged: (value) {
                              setState(() {
                                selectedPlace = value ?? "";
                              });
                            },
                          ),

                        if (!selectedNo2)
                          const SizedBox(height: 8),

                        if (!selectedNo2)
                          SizedBox(
                            height: 60,
                            child: TextField(
                              controller: agendaController,
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



                        const SizedBox(height: 20),

                        questionText(
                          '7. प्राथमिक स्वास्थ्य केंद्र पर मासिक मीटिंग में उपस्थित होना',
                        ),

                        const SizedBox(height: 12),
                        _yesNoRow(
                          selectedNo: selectedNo3,
                          onChanged: (value) {
                            setState(() {
                              selectedNo3 = value;
                            });
                          },
                        ),

                        const SizedBox(height: 12),

                        if (!selectedNo3)
                          datePlaceRow(
                            context: context,
                            dateController: dateController,
                            selectedPlace: selectedPlace,
                            places: places,
                            onPlaceChanged: (value) {
                              setState(() {
                                selectedPlace = value ?? "";
                              });
                            },
                          ),

                        const SizedBox(height: 30),

                        AppButton(
                          buttonName: "डेटा जमा करें",
                          height: 45,
                          onTap: () async {

                            Get.back();
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
        fontSize: 16,
        height: 1.3,
        color: Colors.black,
        fontWeight: FontWeight.w500,
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



  Widget addLMP(BuildContext context,List<String> selectedMembers) {

    print("sizzzeee ${selectedMembers.length}");
    return Column(
      children: [
        Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          color: const Color(0xffe8e8e8),
          child: const Row(
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  'LMP',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  'REGISTRATION DATE',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: selectedMembers.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  children: [

                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Text(selectedMembers[index],
                          style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),



                    Expanded(
                      flex: 4,
                      child: InkWell(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );

                          if (picked != null) {
                            setState(() {
                              lmpDates[index] =
                              "${picked.day}/${picked.month}/${picked.year}";
                            });

                          }
                        },
                        child:Container(
                          height: 55,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            border: Border.all( color: const Color(0xffd7d7d7),
                            ),
                          ),
                          child: Text( lmpDates[index].isEmpty
                              ? "एलएमपी तिथि" : lmpDates[index],
                            style: TextStyle(
                              fontSize: 14,
                              color: lmpDates[index].isEmpty ? const Color(0xffbdbdbd) : Colors.black, ),
                          ),
                        ),
                      ),
                    ),



                    appSizedBox(width: 10),
                    // 📅 REG
                    Expanded(
                      flex: 4,
                      child: InkWell(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );

                          if (picked != null) {
                            setState(() {
                              regDates[index] =
                              "${picked.day}/${picked.month}/${picked.year}";
                            });
                          }
                        },
                        child:Container(
                          height: 55,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            border: Border.all( color: const Color(0xffd7d7d7),
                            ),
                          ),
                          child: Text( regDates[index].isEmpty
                              ? "पंजीकरण तिथि"
                              : regDates[index],
                            style: TextStyle(
                              fontSize: 14,
                              color: regDates[index].isEmpty ? const Color(0xffbdbdbd) : Colors.black, ),
                          ),
                        ),

                      ),
                    ),
                  ],
                ),
                appSizedBox(height: 10)
              ],
            );
          },
        ),

      ],
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


  Widget coupleCard(){

    String names="";
    for(int i=0;i<selectedCouplesMembers.length;i++){
      if(i==0){
        names=selectedCouplesMembers[i];
      }else{
        names=names+" & "+selectedCouplesMembers[i];
      }
    }
    return  Column(
      children: [

        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xffd9d9d9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Text(
              "चयनित जोड़ें",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

        const SizedBox(height: 15),


        Container(
          height: 55,
          decoration: BoxDecoration(
            color: const Color(0xffeaf4f4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              // 🔴 Red Left Section
              Container(
                width: 55,
                decoration: const BoxDecoration(
                  color: Color(0xffd32f2f),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),

              // 📝 Text
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 12,right: 12),
                  child: Text(
                    names.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),

              // 👨‍👩 Icon
              const Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(
                  Icons.family_restroom,
                  size: 32,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget birthDeathCard(){
    return  Column(
      children: [
        Container(
          height: 55,
          decoration: BoxDecoration(
            color: const Color(0xffeaf4f4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [

              Container(
                width: 55,
                decoration: const BoxDecoration(
                  color: Color(0xffd32f2f),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),

              // 📝 Text
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 12,right: 12),
                  child: Text(
                    "JONISH KUMAR",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),


            ],
          ),
        ),
      ],
    );
  }

}
import 'package:asha_pay/asha_pay.dart';
import 'package:flutter/material.dart';

import '../../model/family_model.dart';
import '../../model/get_family_activity_model.dart';

class BirthDeathScreen extends StatefulWidget {
  final FamilyData familyData;
  final String programId;
  final String activityId;

  const BirthDeathScreen({super.key,required this.familyData,required this.programId,required this.activityId});

  @override
  State<BirthDeathScreen> createState() => _BirthDeathScreenState();
}

class _BirthDeathScreenState extends State<BirthDeathScreen> {
  final AshaGatividhiController controller = Get.put(AshaGatividhiController());
  bool selectedNo5 = true;
  bool selectedNo6 = true;
  bool selectedNo7 = true;

  @override
  void initState() {

    super.initState();
    controller.familyData=widget.familyData;
    controller.getActivitybyFamilyId(widget.familyData.familyId!);
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
            'आशा गतिविधि',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: GetBuilder<AshaGatividhiController>(
            id: 'asha_gatividhi',
            builder: (controller) {
              return StackedLoader(
                loading: controller.loader,
                child: SafeArea(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const SizedBox(height: 34),

                        questionText(
                          'मासिक आधार पर ग्राम स्वास्थ्य रजिस्टर का रख-रखाव तथा मासिक आधार पर जन्म-मृत्यु का पंजीकरण करवाना',
                        ),
                        const SizedBox(height: 20),
                        memberRow(
                          onTap: (){

                            Get.to(()=> ParivarKiSuchiScreen(step: "step4",familyData: controller.familyData!))?.then((result) {
                              if (result != null) {



                                controller.selectedDeathMembers=result;




                                setState(() {

                                  controller.isDeath=true;
                                  controller.activityid="5";
                                });



                                print(result);
                              }
                            });

                          },

                        ),

                        const SizedBox(height: 20),

                        if(controller.isDeath)
                          birthDeathCard(context, controller.selectedDeathMembers[0].memberName!),

                        const SizedBox(height: 20),
                        if(controller.isDeath)
                          birthDeathDateUi(context),

                        const SizedBox(height: 35),

                        AppButton(
                          buttonName: "डेटा जमा करें",
                          height: 45,
                          onTap: () async {
                            if (controller.birthDeathDateController.text.trim().isEmpty) {
                             // toastMsg( "कृपया तिथि चुनें");
                              Get.snackbar(
                                "त्रुटि",
                                "कृपया तिथि चुनें",
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                              return;
                            }


                            controller.dataSubmit();
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


  Widget birthDeathCard(BuildContext context,String selectedMembers){
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
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 12,right: 12),
                  child: Text(
                    selectedMembers,
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


  Widget birthDeathDateUi(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xffeaf4f4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "जन्म / मृत्यु तिथि",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 10),

          InkWell(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );

              if (picked != null) {
                setState(() {
                  controller.birthDeathDateController.text =
                  "${picked.day}/${picked.month}/${picked.year}";
                });
              }
            },
            child: Container(
              height: 55,
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
              ),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xffd7d7d7),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(controller.birthDeathDateController.text.isEmpty
                          ? "तिथि चुनें"
                          : controller.birthDeathDateController.text,
                      style: TextStyle(
                        fontSize: 14,
                        color:controller.birthDeathDateController.text.isEmpty
                            ? Colors.grey
                            : Colors.black,
                      ),
                    ),
                  ),

                  const Icon(
                    Icons.calendar_today,
                    size: 20,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
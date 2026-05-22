import 'package:asha_pay/asha_pay.dart';
import 'package:flutter/material.dart';

import '../../model/family_model.dart';
import '../../model/get_family_activity_model.dart';


class AshaGatividhiScreen extends StatefulWidget {
  final FamilyData familyData;
  const AshaGatividhiScreen({super.key,required this.familyData});

  @override
  State<AshaGatividhiScreen> createState() => _AshaGatividhiScreenState();
}

class _AshaGatividhiScreenState extends State<AshaGatividhiScreen> {
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


                      questionText(
                        '1. योग्य विवाहित जोड़ों (18 -49 वर्ष तक के) की सूची तैयार करना',
                      ),
                      const SizedBox(height: 12),
                      memberRow(
                        onTap: () {
                          Get.to(()=> ParivarKiSuchiScreen(step: "step3",familyData: controller.familyData!,))?.then((result) {
                            if (result != null) {


                              controller.selectedCouplesMembers=result;

                              setState(() {
                                showCouple=true;

                                controller.activityid="4";
                              });
                              print(result);
                            }
                          });

                        },
                      ),

                      const SizedBox(height: 12),

                      if(showCouple || controller.isCouple)
                        Column(
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

                          ],
                        ),

                      if(showCouple)
                        coupleCard(),





                      if(controller.isCouple)
                        coupleCard2(),


                      controller.isCouple ?
                          Column(
                            children: [
                              const SizedBox(height: 34),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: questionText(
                                      '2. गर्भवती महिलाओं की मासिक सूची तैयार करना',
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  InkWell(
                                    onTap: (){

                                      Get.to(()=> ParivarKiSuchiScreen(step: "step1",familyData: controller.familyData!))?.then((result) {
                                        if (result != null) {



                                          controller.selectedMembers=result;

                                          controller.lmpDates = List.filled(controller.selectedMembers.length, "");
                                          controller.regDates = List.filled(controller.selectedMembers.length, "");


                                          setState(() {
                                            showLmp=true;
                                            controller.activityid="1";
                                          });



                                          print(result);
                                        }
                                      });

                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: const Color(0xff0f7df2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              if (showLmp || controller.isLmp) ...[
                                const SizedBox(height: 20),
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

                                if(controller.isLmp)
                                  showLMP(context),

                                addLMP(context,controller.selectedMembers),
                              ],

                              const SizedBox(height: 20),



                              if (controller.isLmp) ...[

                                questionText(
                                  '3. बच्चों/गर्भवती महिलाओं के टीकाकरण की मासिक ड्यू लिस्ट तैयार करना',
                                ),
                                const SizedBox(height: 12),
                                memberRow(

                                  onTap: () {
                                    Get.to(()=> VaccinationListScreen(familyData: controller.familyData!));

                                  },
                                ),

                              ],


                            ],
                          ) : Container(),


                      const SizedBox(height: 34),


                      questionText(
                        '4. मासिक आधार पर ग्राम स्वास्थ्य रजिस्टर का रख-रखाव तथा मासिक आधार पर जन्म-मृत्यु का पंजीकरण करवाना',
                      ),
                      const SizedBox(height: 12),
                      memberRow(
                        onTap: (){

                          Get.to(()=> ParivarKiSuchiScreen(step: "step4",familyData: controller.familyData!))?.then((result) {
                            if (result != null) {



                              controller.selectedDeathMembers=result;




                              setState(() {

                                controller.isDeath=true;
                                //controller.activityid="4";
                              });



                              print(result);
                            }
                          });

                        },

                      ),

                      const SizedBox(height: 12),

                      if(controller.isDeath)
                        birthDeathCard(context, controller.selectedDeathMembers[0].memberName!),

                      const SizedBox(height: 35),

                      AppButton(
                        buttonName: "डेटा जमा करें",
                        height: 45,
                        onTap: () async {

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



  Widget addLMP(BuildContext context,List<FamilyMembers> selectedMembers) {

    print("sizzzeee ${selectedMembers.length}");
    return Column(
      children: [


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
                        child: Text(selectedMembers[index].memberName!,
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
                              controller.lmpDates[index] =
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
                          child: Text( controller.lmpDates[index].isEmpty
                ? "एलएमपी तिथि" : controller.lmpDates[index],
                            style: TextStyle(
                              fontSize: 14,
                              color: controller.lmpDates[index].isEmpty ? const Color(0xffbdbdbd) : Colors.black, ),
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
                              controller.regDates[index] =
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
                          child: Text( controller.regDates[index].isEmpty
                              ? "पंजीकरण तिथि"
                              : controller.regDates[index],
                            style: TextStyle(
                              fontSize: 14,
                              color: controller.regDates[index].isEmpty ? const Color(0xffbdbdbd) : Colors.black, ),
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

  Widget showLMP(
      BuildContext context
      ) {

    List<Members> members = [];

    // Null safe check
    for (var activity
    in controller.familyActivityModel?.data?.activities ?? []) {
      if (activity.activityId == 1) {
        members = activity.members ?? [];
        break;
      }
    }

    // If no members found then hide widget
    if (members.isEmpty) {
      return const SizedBox();
    }


    return Column(
      children: [


        ListView.builder(
          shrinkWrap: true,
          physics:
          const NeverScrollableScrollPhysics(),
          itemCount: members.length,
          itemBuilder: (context, index) {

            String lmpDate =members[index].lmpDate!;


            String regDate =members[index].regdate!;


            return Padding(
              padding:
              const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [

                  /// Name
                  Expanded(
                    flex: 4,
                    child: Text(
                      members[index].memberName ?? "",
                    ),
                  ),

                  /// LMP (Non-editable, API value)
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 55,
                      alignment:
                      Alignment.centerLeft,
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(
                              0xffd7d7d7),
                        ),
                      ),
                      child: Text(
                        lmpDate.isEmpty
                            ? "एलएमपी तिथि"
                            : lmpDate,
                      ),
                    ),
                  ),

                  appSizedBox(width: 10),

                  /// REG (Editable)
                  Expanded(
                    flex: 4,
                    child: InkWell(
                      onTap: () async {
                        final picked =
                        await showDatePicker(
                          context: context,
                          initialDate:
                          DateTime.now(),
                          firstDate:
                          DateTime(2000),
                          lastDate:
                          DateTime(2100),
                        );

                        if (picked != null) {
                          setState(() {
                            controller
                                .regDates[index] =
                            "${picked.day}/${picked.month}/${picked.year}";
                          });
                        }
                      },
                      child: Container(
                        height: 55,
                        alignment:
                        Alignment.centerLeft,
                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        decoration:
                        BoxDecoration(
                          border: Border.all(
                            color: const Color(
                                0xffd7d7d7),
                          ),
                        ),
                        child: Text(
                          regDate.isEmpty
                              ? "पंजीकरण तिथि"
                              : regDate,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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

    for(int i=0;i<controller.selectedCouplesMembers.length;i++){
      if(i==0){
        names=controller.selectedCouplesMembers[i].memberName!;
      }else{
        names=names+" & "+controller.selectedCouplesMembers[i].memberName!;
      }
    }

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
        const SizedBox(height: 15),
      ],
    );
  }

  Widget coupleCard2() {
    List<Members> members = [];

    // Null safe check
    for (var activity
    in controller.familyActivityModel?.data?.activities ?? []) {
      if (activity.activityId == 4) {
        members = activity.members ?? [];
        break;
      }
    }

    // If no members found then hide widget
    if (members.isEmpty) {
      return const SizedBox();
    }

    return Column(
      children: [


        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: members.length,
          separatorBuilder: (context, index) =>
          const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final member = members[index];

            String memberName = member.memberName ?? '';
            String spouseName = member.spousename ?? '';

            String name =
            "$memberName & $spouseName".toUpperCase();

            return Container(
              height: 55,
              decoration: BoxDecoration(
                color: const Color(0xffeaf4f4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  // Left Red Section
                  GestureDetector(
                    onTap: () {
                      // remove action here
                    },
                    child: Container(
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
                  ),

                  // Name Text
                  Expanded(
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),

                  // Family Icon
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
            );
          },
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

}
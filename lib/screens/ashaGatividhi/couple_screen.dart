import 'package:asha_pay/asha_pay.dart';
import 'package:flutter/material.dart';

import '../../model/family_model.dart';
import '../../model/get_family_activity_model.dart';


class CoupleScreen extends StatefulWidget {
  final FamilyData familyData;
  final String programId;
  final String activityId;

  const CoupleScreen({super.key,required this.familyData,required this.programId,required this.activityId});

  @override
  State<CoupleScreen> createState() => _CoupleScreenState();
}

class _CoupleScreenState extends State<CoupleScreen> {
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
            'विवाहित जोड़े',
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

                        const SizedBox(height: 20),

                        questionText(
                          'योग्य विवाहित जोड़ों (18 -49 वर्ष तक के) की सूची तैयार करना',
                        ),
                        const SizedBox(height: 30),
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

                        const SizedBox(height: 30),

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

                              const SizedBox(height: 25),

                            ],
                          ),

                        if(showCouple)
                          coupleCard(),





                        if(controller.isCouple)
                          coupleCard2(),



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


}
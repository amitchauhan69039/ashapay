import 'package:asha_pay/asha_pay.dart';
import 'package:asha_pay/screens/BaalSwasthya/childListController.dart';
import 'package:asha_pay/screens/BaalSwasthya/childVaccinationScreen.dart';
import '../../model/family_model.dart';

class ChildListScreen extends StatefulWidget {
  final FamilyData familyData;
  final String programId;
  final String activityId;

  const ChildListScreen({
    super.key,
    required this.familyData,
    required this.programId,required this.activityId});


  @override
  State<ChildListScreen> createState() =>
      _ChildListScreenState();
}

class _ChildListScreenState
    extends State<ChildListScreen> {
  final ChildListController controller = Get.put(ChildListController());

  int selectedIndex = -1;
  List<bool> expandedList = [];

  @override
  void initState() {
    super.initState();

    controller.familyData = widget.familyData;

    controller.getMotherChildListWithId(
      widget.familyData.familyId!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffECECEC),
      appBar: AppBar(
        backgroundColor: const Color(0xff0f7df2),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'टीकाकरण देय सूची',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: GetBuilder<ChildListController>(
        id: 'vaccination_list',
        builder: (controller) {
          return StackedLoader(
            loading: controller.loader,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 8),

                  getData(),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getData() {
    final children =
        controller.motherChildModel?.data?.children ?? [];

    if (children.isEmpty) {
      return SizedBox(
        height: MediaQuery.of(this.context).size.height * 0.7,
        child: Center(
          child: Text(
            "No Children Found!",
            style: styleW400S18,
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: children.length,
      itemBuilder: (context, index) {
        final child = children[index];

        return GestureDetector(
          onTap: () {
            Get.to(
                  () => ChildVaccinationScreen(
                familyData: widget.familyData,
                    selectedIndex: index,
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.05),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                //========================
                // CHILD ICON
                //========================

                Container(
                  height: 58,
                  width: 58,
                  decoration: BoxDecoration(
                    color: const Color(0xff0f7df2).withOpacity(.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    child.gender == "F"
                        ? Icons.girl
                        : Icons.boy,
                    color: const Color(0xff0f7df2),
                    size: 30,
                  ),
                ),

                const SizedBox(width: 16),

                //========================
                // DETAILS
                //========================

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      // NAME
                      Text(
                        child.name ?? "-",
                        style: styleW700S18
                      ),

                      const SizedBox(height: 12),

                      // AGE
                      Row(
                        children: [
                          const Icon(
                            Icons.cake,
                            size: 18,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "Age : ${child.age ?? "-"}",
                            style: styleW400S16
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // DOB
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            size: 18,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              "DOB : ${child.dob ?? "-"}",
                              style: styleW400S16
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // GENDER
                      Row(
                        children: [
                          const Icon(
                            Icons.person,
                            size: 18,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              "Gender : ${child.gender == "F" ? "Female" : "Male"}",
                              style: styleW400S16
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // STATUS
                      Row(
                        children: [
                          const Icon(
                            Icons.health_and_safety,
                            size: 18,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              "Status : ${child.status ?? "-"}",
                              style: TextStyle(
                                fontSize: 16,
                                color: child.status == "Active"
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),

                     /* const SizedBox(height: 10),

                      // MOTHER NAME
                      const Row(
                        children: [
                          Icon(
                            Icons.pregnant_woman,
                            size: 18,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              "Mother : """, /////${child.motherName ?? "-"}",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),*/
                    ],
                  ),
                ),

                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildPersonRow({
    required int index,
    required String name,
    required String gender,
    required String age,
  }) {
    return Container(
      color: Colors.white,
      padding:
      const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value:
              selectedIndex == index,
              activeColor:
              Colors.blue,
              onChanged: (v) {
                setState(() {
                  selectedIndex =
                      index;
                });
              },
            ),
          ),
          const SizedBox(width: 14),

          Expanded(
            flex: 3,
            child: Text(name),
          ),

          Expanded(
            flex: 2,
            child: Text(gender),
          ),

          Expanded(
            flex: 2,
            child: Text(age),
          ),
        ],
      ),
    );
  }

  Widget vaccinationCard({
    required BuildContext context,
    required Color iconColor,
    required String title,
    required String status,
    required Color statusColor,
    required List<List<String>>
    vaccines,
    required bool expanded,
    required VoidCallback onTap,
  }) {
    return Row(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 60,
          child: Column(
            children: [
              Container(
                height: 46,
                width: 46,
                decoration:
                BoxDecoration(
                  gradient:
                  LinearGradient(
                    colors: [
                      iconColor,
                      iconColor
                          .withOpacity(
                        .8,
                      ),
                    ],
                  ),
                  shape:
                  BoxShape.circle,
                ),
                child: const Icon(
                  Icons
                      .vaccines_rounded,
                  color:
                  Colors.white,
                  size: 22,
                ),
              ),
              Container(
                width: 2,
                height: expanded
                    ? 72
                    : 50,
                color: Colors
                    .grey.shade300,
              ),
            ],
          ),
        ),

        Expanded(
          child: Container(
            margin:
            const EdgeInsets.only(
              right: 14,
              bottom: 18,
            ),
            decoration:
            BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(
                24,
              ),
            ),
            child: Column(
              children: [
                InkWell(
                  borderRadius:
                  BorderRadius.circular(
                    24,
                  ),
                  onTap: onTap,
                  child: Padding(
                    padding:
                    const EdgeInsets
                        .symmetric(
                      horizontal: 18,
                      vertical: 18,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              Text(
                                title,
                                style:
                                const TextStyle(
                                  fontSize:
                                  17,
                                  fontWeight:
                                  FontWeight
                                      .w700,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                padding:
                                const EdgeInsets.symmetric(
                                  horizontal:
                                  14,
                                  vertical:
                                  6,
                                ),
                                decoration:
                                BoxDecoration(
                                  color:
                                  statusColor
                                      .withOpacity(
                                    .12,
                                  ),
                                  borderRadius:
                                  BorderRadius.circular(
                                    30,
                                  ),
                                ),
                                child: Text(
                                  status,
                                  style:
                                  TextStyle(
                                    color:
                                    statusColor,
                                    fontSize:
                                    12,
                                    fontWeight:
                                    FontWeight
                                        .w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          expanded
                              ? Icons
                              .keyboard_arrow_up
                              : Icons
                              .keyboard_arrow_down,
                        ),
                      ],
                    ),
                  ),
                ),

                if (expanded)
                  Container(
                    margin:
                    const EdgeInsets
                        .fromLTRB(
                      16,
                      0,
                      16,
                      16,
                    ),
                    child: Column(
                      children:
                      vaccines.map((e) {
                        return Container(
                          padding:
                          const EdgeInsets
                              .symmetric(
                            horizontal:
                            14,
                            vertical:
                            14,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child:
                                Text(
                                  e[0],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child:
                                Text(
                                  e[1],
                                  textAlign:
                                  TextAlign.center,
                                ),
                              ),
                              const Expanded(
                                flex: 2,
                                child:
                                Text(
                                  "-",
                                  textAlign:
                                  TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
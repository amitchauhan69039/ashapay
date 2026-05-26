import 'package:asha_pay/asha_pay.dart';

import '../../model/family_model.dart';
import '../../model/get_mother_child_model.dart';

class VaccinationListScreen extends StatefulWidget {
  final FamilyData familyData;

  const VaccinationListScreen({
    super.key,
    required this.familyData,
  });

  @override
  State<VaccinationListScreen> createState() =>
      _VaccinationListScreenState();
}

class _VaccinationListScreenState
    extends State<VaccinationListScreen> {
  final VaccinationListController controller =
  Get.put(VaccinationListController());

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
      body: GetBuilder<VaccinationListController>(
        id: 'vaccination_list',
        builder: (controller) {
          return StackedLoader(
            loading: controller.loader,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 8),

                  //=========================
                  // Header
                  //=========================

                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 18,
                    ),
                    child: Row(
                      children: const [
                        SizedBox(width: 30),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Name",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Gender",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Age",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  getVaccines(),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getVaccines() {
    final pregnantWomen =
        controller.motherChildModel?.data?.pregnantWomens ??
            [];

    final children =
        controller.motherChildModel?.data?.children ?? [];

    final List<dynamic> members = [
      ...pregnantWomen,
      ...children,
    ];

    if (members.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Text(
            "No data found",
          ),
        ),
      );
    }

    if (selectedIndex == -1) {
      selectedIndex = 0;
    }

    final selectedMember = members[selectedIndex];

    List<VaccinationDetail> vaccinations = [];

    if (selectedMember is PregnantWomens) {
      vaccinations =
          selectedMember.vaccinationDetail ?? [];
    }

    if (selectedMember is Children) {
      vaccinations =
          selectedMember.vaccinationDetail ?? [];
    }

    if (expandedList.length !=
        vaccinations.length) {
      expandedList = List.generate(
        vaccinations.length,
            (index) => true,
      );
    }

    return Column(
      children: [
        //=========================
        // Member List
        //=========================

        ListView.builder(
          shrinkWrap: true,
          physics:
          const NeverScrollableScrollPhysics(),
          itemCount: members.length,
          itemBuilder: (context, index) {
            final member = members[index];

            String name = "";
            String gender = "";
            String age = "";

            if (member is PregnantWomens) {
              name = member.name ?? "";
              gender = "F";
              age = member.lmpWeeks ?? "";
            }

            if (member is Children) {
              name = member.name ?? "";
              gender = member.gender ?? "";
              age = member.age ?? "";
            }

            return buildPersonRow(
              index: index,
              name: name,
              gender: gender,
              age: age,
            );
          },
        ),

        const SizedBox(height: 16),

        //=========================
        // Vaccination Cards
        //=========================

        ...List.generate(
          vaccinations.length,
              (index) {
            final vaccine =
            vaccinations[index];

            bool isCompleted =
                vaccine.vacStatus
                    ?.toLowerCase() ==
                    "completed";

            return vaccinationCard(
              context: this.context,
              expanded: expandedList[index],
              onTap: () {
                setState(() {
                  expandedList[index] =
                  !expandedList[index];
                });
              },
              iconColor: Colors.blue,
              title:
              vaccine.vaccinationName ??
                  "",
              status: isCompleted
                  ? "Completed"
                  : "Pending",
              statusColor: isCompleted
                  ? Colors.green
                  : Colors.orange,
              vaccines: [
                [
                  vaccine
                      .vaccinationName ??
                      "",
                  vaccine.vacStatus ??
                      "Pending",
                  vaccine
                      .vaccinationDate
                      ?.toString() ??
                      "-"
                ]
              ],
            );
          },
        ),

        const SizedBox(height: 30),

        // Container(
        //   margin: const EdgeInsets.only(
        //     right: 16,
        //     bottom: 16,
        //   ),
        //   child: Align(
        //     alignment: Alignment.centerRight,
        //     child: ElevatedButton(
        //       style:
        //       ElevatedButton.styleFrom(
        //         backgroundColor:
        //         Colors.blue,
        //         padding:
        //         const EdgeInsets.symmetric(
        //           horizontal: 35,
        //           vertical: 10,
        //         ),
        //         shape:
        //         RoundedRectangleBorder(
        //           borderRadius:
        //           BorderRadius.circular(
        //             14,
        //           ),
        //         ),
        //       ),
        //       onPressed: () {
        //         controller.dataSubmit();
        //       },
        //       child: const Text(
        //         "जोड़ें",
        //         style: TextStyle(
        //           fontSize: 16,
        //           color: Colors.white,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
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
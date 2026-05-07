import 'package:asha_pay/asha_pay.dart';

class VaccinationListScreen extends StatefulWidget {
  const VaccinationListScreen({super.key});

  @override
  State<VaccinationListScreen> createState() =>
      _VaccinationListScreenState();
}

class _VaccinationListScreenState
    extends State<VaccinationListScreen> {
  final VaccinationListController controller =
  Get.put(VaccinationListController());

  bool birthExpanded = true;
  bool week6Expanded = true;
  bool week10Expanded = false;

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffECECEC),

      appBar: AppBar(
        backgroundColor: const Color(0xff0f7df2),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'टीकाकरण देय सूची',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      body: GetBuilder<VaccinationListController>(
        id: 'parivar_selection',
        builder: (controller) {
          return StackedLoader(
            loading: controller.loader,

            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 8),

                  //================================================
                  // LIST HEADER
                  //================================================

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
                              fontSize: 16,
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: Text(
                            "Gender",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: Text(
                            "Age",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  buildPersonRow(
                    index: 0,
                    name: "STRING12",
                    gender: "F",
                    age: "5 weeks",
                  ),

                  buildPersonRow(
                    index: 1,
                    name: "STRING13",
                    gender: "F",
                    age: "5 weeks",
                  ),

                  buildPersonRow(
                    index: 2,
                    name: "STRING14",
                    gender: "M",
                    age: "5 weeks",
                  ),

                  const SizedBox(height: 14),

                  //================================================
                  // BIRTH
                  //================================================

                  vaccinationCard(
                    expanded: birthExpanded,
                    onTap: () {
                      setState(() {
                        birthExpanded = !birthExpanded;
                      });
                    },

                    iconColor: Colors.green,
                    title: "Birth",
                    status: "All Completed",
                    statusColor: Colors.green,

                    vaccines: const [
                      ["BCG", "Completed", "12 Oct 2023"],
                      ["OPV-0", "Completed", "12 Oct 2023"],
                      ["Hep B", "Completed", "12 Oct 2023"],
                    ],
                  ),

                  //================================================
                  // 6 WEEKS
                  //================================================

                  vaccinationCard(
                    expanded: week6Expanded,
                    onTap: () {
                      setState(() {
                        week6Expanded = !week6Expanded;
                      });
                    },

                    iconColor: Colors.blue,
                    title: "6 Weeks",
                    status: "DUE NOW",
                    statusColor: Colors.red,

                    vaccines: const [
                      ["OPV-1", "Due Today", "12 Oct 2023"],
                      [
                        "Pentavalent-1",
                        "Due Today",
                        "12 Oct 2023"
                      ],
                      [
                        "Rotavirus-1",
                        "Due Today",
                        "12 Oct 2023"
                      ],
                      ["fIPV-1", "Due Today", "12 Oct 2023"],
                    ],
                  ),

                  //================================================
                  // 10 WEEKS
                  //================================================

                  vaccinationCard(
                    expanded: week10Expanded,
                    onTap: () {
                      setState(() {
                        week10Expanded = !week10Expanded;
                      });
                    },

                    iconColor: Colors.orange,
                    title: "10 Weeks",
                    status: "Pending",
                    statusColor: Colors.red,
                    vaccines: const [],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  //====================================================
  // PERSON ROW
  //====================================================

  Widget buildPersonRow({
    required int index,
    required String name,
    required String gender,
    required String age,
  }) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: selectedIndex == index,
              activeColor: Colors.blue,

              onChanged: (v) {
                setState(() {
                  selectedIndex = index;
                });
              },

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            flex: 3,
            child: Text(
              name,
              style: const TextStyle(fontSize: 15),
            ),
          ),

          Expanded(
            flex: 2,
            child: Text(
              gender,
              style: const TextStyle(fontSize: 15),
            ),
          ),

          Expanded(
            flex: 2,
            child: Text(
              age,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  //====================================================
  // VACCINATION CARD
  //====================================================

  Widget vaccinationCard({
    required Color iconColor,
    required String title,
    required String status,
    required Color statusColor,
    required List<List<String>> vaccines,
    required bool expanded,
    required VoidCallback onTap,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //================================================
        // TIMELINE
        //================================================

        SizedBox(
          width: 58,
          child: Column(
            children: [
              Container(
                height: 34,
                width: 34,
                decoration: BoxDecoration(
                  color: iconColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                ),
                child: const Icon(
                  Icons.calendar_month,
                  color: Colors.white,
                  size: 18,
                ),
              ),

              Container(
                width: 2,
                height: expanded ? 320 : 60,
                color: Colors.grey.shade300,
              ),
            ],
          ),
        ),

        //================================================
        // CARD
        //================================================

        Expanded(
          child: Container(
            margin: const EdgeInsets.only(
              right: 14,
              bottom: 18,
            ),

            child: Column(
              children: [
                //================================================
                // TOP CARD
                //================================================

                GestureDetector(
                  onTap: onTap,

                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),

                      boxShadow: [
                        BoxShadow(
                          color:
                          Colors.black.withOpacity(0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),

                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                status,
                                style: TextStyle(
                                  color: statusColor,
                                  fontWeight:
                                  FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),

                        AnimatedRotation(
                          turns: expanded ? 0.5 : 0,
                          duration: const Duration(
                            milliseconds: 300,
                          ),
                          child: const Icon(
                            Icons.keyboard_arrow_down,
                            size: 30,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //================================================
                // TABLE
                //================================================

                AnimatedCrossFade(
                  duration:
                  const Duration(milliseconds: 300),

                  crossFadeState: expanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,

                  firstChild: const SizedBox(),

                  secondChild: vaccines.isEmpty
                      ? const SizedBox()
                      : Container(
                    margin:
                    const EdgeInsets.only(top: 12),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.circular(16),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.03),
                          blurRadius: 5,
                          offset:
                          const Offset(0, 2),
                        ),
                      ],
                    ),

                    child: Column(
                      children: [
                        //====================================
                        // HEADER
                        //====================================

                        Container(
                          padding:
                          const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),

                          decoration:
                          const BoxDecoration(
                            color: Color(0xffF5F5F5),

                            borderRadius:
                            BorderRadius.only(
                              topLeft:
                              Radius.circular(16),
                              topRight:
                              Radius.circular(16),
                            ),
                          ),

                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding:
                                  const EdgeInsets
                                      .only(
                                    right: 12,
                                  ),
                                  child: const Text(
                                    "टीका",
                                    style: TextStyle(
                                      fontWeight:
                                      FontWeight
                                          .w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),



                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment
                                      .centerLeft,
                                  padding:
                                  const EdgeInsets
                                      .symmetric(
                                    horizontal: 12,
                                  ),
                                  child: const Text(
                                    "स्थिति",
                                    style: TextStyle(
                                      fontWeight:
                                      FontWeight
                                          .w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),


                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment
                                      .centerLeft,
                                  padding:
                                  const EdgeInsets
                                      .only(
                                    left: 12,
                                  ),
                                  child: const Text(
                                    "तारीख",
                                    style: TextStyle(
                                      fontWeight:
                                      FontWeight
                                          .w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //====================================
                        // VACCINE LIST
                        //====================================

                        ...vaccines.map(
                              (e) => Column(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),

                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        alignment:
                                        Alignment
                                            .centerLeft,
                                        padding:
                                        const EdgeInsets
                                            .only(
                                          right: 12,
                                        ),
                                        child: Text(
                                          e[0],
                                          style:
                                          const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),


                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        alignment:
                                        Alignment
                                            .centerLeft,
                                        padding:
                                        const EdgeInsets
                                            .symmetric(
                                          horizontal:
                                          12,
                                        ),
                                        child: Text(
                                          e[1],
                                          style:
                                          TextStyle(
                                            fontSize:
                                            14,
                                            color: e[1] ==
                                                "Completed"
                                                ? Colors
                                                .green
                                                : Colors
                                                .red,
                                          ),
                                        ),
                                      ),
                                    ),



                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        alignment:
                                        Alignment
                                            .centerLeft,
                                        padding:
                                        const EdgeInsets
                                            .only(
                                          left: 12,
                                        ),
                                        child: Text(
                                          e[2],
                                          style:
                                          TextStyle(
                                            fontSize:
                                            13,
                                            color: Colors
                                                .grey
                                                .shade600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Divider(
                                height: 1,
                                thickness: 1,
                                color: Colors
                                    .grey
                                    .shade200,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
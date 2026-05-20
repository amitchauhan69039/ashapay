import 'package:asha_pay/asha_pay.dart';

import '../../model/family_model.dart';
import '../../model/get_family_activity_model.dart';

class VaccinationListScreen extends StatefulWidget {
  final FamilyData familyData;

  const VaccinationListScreen({
    super.key,
    required this.familyData,
  });

  @override
  State<VaccinationListScreen> createState() => _VaccinationListScreenState();
}

class _VaccinationListScreenState extends State<VaccinationListScreen> {
  final VaccinationListController controller =
      Get.put(VaccinationListController());

  List<bool> expandedList = [];

  @override
  void initState() {
    super.initState();

    controller.familyData = widget.familyData;
    controller.getActivitybyFamilyId(widget.familyData.familyId!);
    controller.getMotherChildListWithId(widget.familyData.familyId!);
  }

  @override
  Widget build(BuildContext context) {
    List members = controller.familyActivityModel?.data!.activities
            ?.firstWhere(
              (e) => e.activityId == 2,
            )
            .members ??
        [];

    if (controller.selectedIndex == -1 && members.isNotEmpty) {
      controller.selectedIndex = 0;
    }

    if (controller.selectedIndex != -1 && members.isNotEmpty) {
      expandedList = List.generate(
        members[controller.selectedIndex].vaccinations?.length ?? 0,
        (index) => true,
      );
    }

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
        vertical: 10,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: controller.selectedIndex == index,
              activeColor: Colors.blue,
              onChanged: (v) {
                setState(() {
                  controller.selectedIndex = index;
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

  String getAge(String dob) {
    if (dob.isEmpty) return "";

    DateTime birthDate = DateTime.parse(dob);

    Duration diff = DateTime.now().difference(
      birthDate,
    );

    int years = diff.inDays ~/ 365;

    int months = diff.inDays ~/ 30;

    int weeks = diff.inDays ~/ 7;

    if (years > 0) {
      return "$years Years";
    } else if (months > 0) {
      return "$months Months";
    } else {
      return "$weeks Weeks";
    }
  }

  Widget vaccinationCard({
    required BuildContext context,
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
        //=====================================
        // Timeline
        //=====================================

        SizedBox(
          width: 60,
          child: Column(
            children: [
              Container(
                height: 46,
                width: 46,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      iconColor,
                      iconColor.withOpacity(.8),
                    ],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: iconColor.withOpacity(.25),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.vaccines_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              Container(
                width: 2,
                height: expanded ? vaccines.length * 72 : 50,
                color: Colors.grey.shade300,
              ),
            ],
          ),
        ),

        //=====================================
        // Card
        //=====================================

        Expanded(
          child: Container(
            margin: const EdgeInsets.only(
              right: 14,
              bottom: 18,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.05),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                //=====================================
                // Header
                //=====================================

                InkWell(
                  borderRadius: BorderRadius.circular(24),
                  onTap: onTap,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 18,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor.withOpacity(.12),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  status,
                                  style: TextStyle(
                                    color: statusColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        AnimatedRotation(
                          turns: expanded ? 0.5 : 0,
                          duration: const Duration(
                            milliseconds: 250,
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.keyboard_arrow_down,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //=====================================
                // Expandable section
                //=====================================

                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 250),
                  crossFadeState: expanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  firstChild: const SizedBox(),
                  secondChild: vaccines.isEmpty
                      ? const SizedBox()
                      : Container(
                          margin: const EdgeInsets.fromLTRB(
                            16,
                            0,
                            16,
                            16,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.grey.shade200,
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xffF8F9FC,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: const Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        "टीका",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "स्थिति",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "तारीख",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ...vaccines.asMap().entries.map(
                                (entry) {
                                  int i = entry.key;
                                  List<String> e = entry.value;

                                  bool isPending =
                                      e[1].toLowerCase() == "pending";

                                  String key = "$title-$i";

                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.grey.shade100,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            e[0],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 5,
                                            ),
                                            decoration: BoxDecoration(
                                              color: isPending
                                                  ? Colors.orange
                                                      .withOpacity(.12)
                                                  : Colors.green
                                                      .withOpacity(.12),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              e[1],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: isPending
                                                    ? Colors.orange
                                                    : Colors.green,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: isPending
                                              ? InkWell(
                                                  onTap: () async {
                                                    DateTime? picked =
                                                        await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(2020),
                                                      lastDate: DateTime(2035),
                                                    );

                                                    if (picked != null) {
                                                      setState(() {
                                                        String formattedDate =
                                                            "${picked.day.toString().padLeft(2, '0')}/"
                                                            "${picked.month.toString().padLeft(2, '0')}/"
                                                            "${picked.year}";

                                                        controller.selectedDates[
                                                                key] =
                                                            formattedDate;
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 10,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors
                                                            .blue.shade200,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    child: Text(
                                                      controller.selectedDates[
                                                              key] ??
                                                          "Select",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors
                                                            .blue.shade700,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Text(
                                                  e[2],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.grey.shade700,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
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

  Widget getVaccines() {
    List<Members> members = [];

    //=========================
    // Get activity 2 members
    //=========================

    for (var activity
        in controller.familyActivityModel?.data?.activities ?? []) {
      if (activity.activityId == 2) {
        members = activity.members ?? [];
        break;
      }
    }

    //=========================
    // No members found
    //=========================

    if (members.isEmpty) {
      return const SizedBox();
    }

    //=========================
    // Default selected member
    //=========================

    if (controller.selectedIndex == -1 && members.isNotEmpty) {
      controller.selectedIndex = 0;
    }

    //=========================
    // Safety check
    //=========================

    if (controller.selectedIndex >= members.length) {
      return const SizedBox();
    }

    final selectedMember = members[controller.selectedIndex];

    //=========================
    // Vaccination null check
    //=========================

    if (selectedMember.vaccinations == null ||
        selectedMember.vaccinations!.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Text(
            "No vaccination data found",
          ),
        ),
      );
    }

    final vaccinations = selectedMember.vaccinations!;

    //=========================
    // Expanded list sync
    //=========================

    if (expandedList.length != vaccinations.length) {
      expandedList = List.generate(
        vaccinations.length,
        (index) => true,
      );
    }

    //=========================
    // Same UI as hardcoded cards
    //=========================

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: members.length,
          itemBuilder: (context, index) {
            final member = members[index];

            return buildPersonRow(
              index: index,
              name: member.memberName ?? "",
              gender: member.gender ?? "",
              age: getAge(
                member.dob ?? "",
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        ...List.generate(
          vaccinations.length,
          (index) {
            final vaccination = vaccinations[index];

            bool isCompleted = vaccination.vaccines?.every(
                  (v) => v.action == "Completed",
                ) ??
                false;

            return vaccinationCard(
              context: this.context,
              expanded: expandedList[index],
              onTap: () {
                setState(() {
                  expandedList[index] = !expandedList[index];
                });
              },
              iconColor: Colors.blue,
              title: vaccination.ageStage ?? "",
              status: isCompleted ? "All Completed" : "Pending",
              statusColor: isCompleted ? Colors.green : Colors.red,
              vaccines: (vaccination.vaccines ?? [])
                  .map<List<String>>(
                    (Vaccines v) => [
                      v.name ?? "",
                      v.action ?? "",
                      v.date ?? "-",
                    ],
                  )
                  .toList(),
            );
          },
        ),
        const SizedBox(height: 20),
        Container(
          margin: EdgeInsets.only(right: 16, bottom: 16),
          child: Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 35,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {
                controller.dataSubmit();
              },
              child: const Text(
                "जोड़ें",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

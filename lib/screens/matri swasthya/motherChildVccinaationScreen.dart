import 'package:asha_pay/asha_pay.dart';
import 'package:asha_pay/screens/matri%20swasthya/mothers_list_controller.dart';
import '../../model/family_model.dart';
import '../../model/get_mother_child_model.dart';

class MotherChildVaccinationScreen
    extends StatefulWidget {
  final FamilyData familyData;
  final int selectedIndex;

  const MotherChildVaccinationScreen({
    super.key,
    required this.familyData,
    required this.selectedIndex,
  });

  @override
  State<MotherChildVaccinationScreen>
  createState() =>
      _MotherChildVaccinationScreenState();
}

class _MotherChildVaccinationScreenState
    extends State<MotherChildVaccinationScreen> {
  final MothersListController controller = Get.put(
    MothersListController(),
  );

  Map<String, TextEditingController> dateControllers = {};

  bool expanded = true;

  @override
  void initState() {
    super.initState();

    controller.familyData = widget.familyData;

    Future.delayed(
      Duration.zero,
          () {
        controller.getMotherChildListWithId(
          widget.familyData.familyId!,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffECECEC),
        appBar: AppBar(
          backgroundColor: const Color(0xff0f7df2),
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          title: const Text(
            'मातृ स्वास्थ्य',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: GetBuilder<MothersListController>(
          id: 'vaccination_list',
          builder: (controller) {
            return StackedLoader(
              loading: controller.loader,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    getMotherList(),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(
                              0xff0f7df2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                14,
                              ),
                            ),
                          ),
                          onPressed: () async {
                            await controller.dataSubmit();
                          },
                          child: const Text(
                            "Submit Data",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget getMotherList() {
    final mothers =
        controller.motherChildModel?.data?.pregnantWomens ?? [];

    if (mothers.isEmpty) {
      return const Center(child: Text("No Mothers Found"));
    }

    final mother = mothers[widget.selectedIndex];

    final vaccinations = mother.vaccinationDetail ?? [];

    return Column(
      children: [

        // MOTHER CARD
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xff0f7df2),
                Color(0xff5aa9ff),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [

                const Icon(
                  Icons.pregnant_woman,
                  color: Colors.white,
                  size: 34,
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mother.name ?? "-",
                        style: styleW700S20.copyWith(color: ColorRes.white)
                      ),

                      const SizedBox(height: 14),

                      Wrap(
                        spacing: 10,
                        runSpacing: 8,
                        children: [
                          infoChip(Icons.cake,
                              "Age ${mother.age ?? "-"}"),
                          infoChip(Icons.calendar_month,
                              "LMP ${mother.lmpWeeks ?? "-"}"),
                          infoChip(Icons.favorite,
                              "EDD ${mother.edd ?? "-"}"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // VACCINES
        vaccinationCard(
          vaccines: vaccinations,
          memberId: mother.memberId ?? "",
        ),
      ],
    );
  }

  Widget infoChip(
      IconData icon,
      String text,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.15),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.white.withOpacity(.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.white,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: styleW400S15.copyWith(color: ColorRes.white)
          ),
        ],
      ),
    );
  }

  Widget vaccinationCard({
    required List<VaccinationDetail> vaccines,
    required String memberId,
  }) {
    if (vaccines.isEmpty) {
      return const SizedBox();
    }

    return Column(
      children: List.generate(
        vaccines.length,
            (index) {
          VaccinationDetail vaccine = vaccines[index];

          final key = "${memberId}_${vaccine.vaccinationName}_$index";

          dateControllers.putIfAbsent(
            key,
                () => TextEditingController(),
          );


          bool isCompleted =
              vaccine.vacStatus?.toLowerCase() == "completed";

          return Container(
            margin: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 14,
            ),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //========================
                // ICON
                //========================

                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? Colors.green.withOpacity(.12)
                        : Colors.orange.withOpacity(.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.vaccines_rounded,
                    color:
                    isCompleted ? Colors.green : Colors.orange,
                  ),
                ),

                const SizedBox(width: 14),

                //========================
                // DETAILS
                //========================

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        vaccine.vaccinationName ?? "-",
                        style: styleW500S18
                      ),

                      const SizedBox(height: 10),

                      Container(
                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: isCompleted
                              ? Colors.green.withOpacity(.1)
                              : Colors.orange.withOpacity(.1),
                          borderRadius:
                          BorderRadius.circular(30),
                        ),
                        child: Text(
                          vaccine.vacStatus ?? "-",
                          style: TextStyle(
                            color: isCompleted
                                ? Colors.green
                                : Colors.orange,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      TextFormField(
                        controller: dateControllers[key],
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: isCompleted
                              ? (vaccine.vaccinationDate ?? "Completed")
                              : "Select Date",
                          suffixIcon: isCompleted
                              ? const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 20,
                          )
                              : const Icon(
                            Icons.calendar_month,
                            size: 20,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          filled: true,
                          fillColor: isCompleted
                              ? Colors.green.withOpacity(.05)
                              : const Color(0xffF5F5F5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        // completed pe disable
                        enabled: !isCompleted,
                        onTap: isCompleted
                            ? null
                            : () async {
                          DateTime? pickedDate =
                          await showDatePicker(
                            context: this.context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          );

                          if (pickedDate != null) {
                            String formattedDate = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                            // textField show
                            dateControllers[key]?.text = formattedDate;

                            // submit body save
                            controller.selectedDates[key] = formattedDate;

                            setState(() {});
                          }
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

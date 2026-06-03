import 'package:asha_pay/common/widget/loaders.dart';
import 'package:asha_pay/model/family_model.dart';
import 'package:asha_pay/screens/ParivarSelection/parivar_selection_controller.dart';
import 'package:asha_pay/screens/home/entryProgram_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/styles.dart';

class ParivarSelectionScreen extends StatefulWidget {
  final Function(FamilyData familyData)? onFamilyTap;

  const ParivarSelectionScreen({
    super.key,
    this.onFamilyTap,
  });

  @override
  State<ParivarSelectionScreen> createState() =>
      _ParivarSelectionScreenState();
}

class _ParivarSelectionScreenState
    extends State<ParivarSelectionScreen> {
  final ParivarSelectionController controller =
  Get.put(ParivarSelectionController());

  @override
  void initState() {
    super.initState();
    controller.getFamily();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xff2f7dbd),
        elevation: 0,
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
        title: const Text(
          "परिवार का चयन करें",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      body: GetBuilder<ParivarSelectionController>(
        id: 'parivar_selection',
        builder: (controller) {
          return StackedLoader(
            loading: controller.loader,
            child: Column(
              children: [
                Container(
                  color: const Color(0xff2f7dbd),
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xffe6e6e6),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "परिवार आईडी दर्ज करें",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),

                getList(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget getList() {
    if (controller.familyList.isNotEmpty) {
      return Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.familyList.length,
          itemBuilder: (context, index) {
            final familyData = controller.familyList[index];

            return InkWell(
              onTap: () {
                if (widget.onFamilyTap != null) {
                  widget.onFamilyTap!(familyData);
                } else {
                  Get.to(
                        () => AshaProgramScreen(
                      familyData: familyData,
                    ),
                  );
                }
              },
              child: Container(
                height: 60,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: const Color(0xffeaf4f4),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Color(0xff2f7dbd),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          bottomLeft: Radius.circular(4),
                        ),
                      ),
                      child: const Icon(
                        Icons.person_outline,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        familyData.familyId ?? "",
                        style: styleW500S21,
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.more_vert,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    } else {
      return const Expanded(
        child: Center(
          child: Text("परिवार उपलब्ध नहीं है"),
        ),
      );
    }
  }
}
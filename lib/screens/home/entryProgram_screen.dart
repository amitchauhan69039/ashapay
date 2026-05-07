import 'package:asha_pay/asha_pay.dart';
import 'package:asha_pay/screens/ParivarSelection/parivar_selection_screen.dart';
import 'package:asha_pay/screens/home/controller/programs_controller.dart';

class AshaProgramScreen extends StatelessWidget {

  final ProgramsController controller = Get.put(ProgramsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2F7FB6),
      appBar: AppBar(
        backgroundColor: const Color(0xff0f7df2),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "आशा कार्यक्रम",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [


            // 🔹 Body
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,

                ),

                // 🔥 GetBuilder
                child: GetBuilder<ProgramsController>(
                  builder: (controller) {

                    // 🔹 Loader
                    if (controller.loader) {
                      return Center(child: CircularProgressIndicator());
                    }

                    // 🔹 Empty State
                    if (controller.programsList == null ||
                        controller.programsList!.isEmpty) {
                      return Center(child: Text("No Data Found"));
                    }

                    // 🔹 List
                    return ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: controller.programsList!.length,
                      itemBuilder: (context, index) {

                        final item = controller.programsList![index];

                        return InkWell(
                            onTap: () {

                              if(index==1){
                                Get.to(()=> ParivarSelectionScreen());
                              }

                            },
                            child: programCard(item.programmeName ?? "")
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Card
  Widget programCard(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: Color(0xFF2F7FB6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18)
        ],
      ),
    );
  }
}
import 'package:asha_pay/asha_pay.dart';

class ParivarSelectionScreen extends StatefulWidget {

  @override
  _ParivarSelectionScreenState createState() => _ParivarSelectionScreenState();
}

class _ParivarSelectionScreenState extends State<ParivarSelectionScreen>{
  final ParivarSelectionController controller = Get.put(ParivarSelectionController());

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
        leading: const Icon(Icons.arrow_back, color: Colors.white),
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

      body:GetBuilder<ParivarSelectionController>(
          id: 'parivar_selection',
          builder: (controller) {
            return StackedLoader(
                loading: controller.loader,
                child: Column(
                  children: [
                    // 🔍 Search Box
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
          })


    );
  }

  Widget getList(){
    if(!controller.familyList.isEmpty){
      print("not empty bkjbjksdjk");
      return Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.familyList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                Get.to(()=> AshaGatividhiScreen(familyData: controller.familyList[index]));
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

                    // 📝 Text
                    Expanded(
                      child: Text(
                        controller.familyList[index].familyId!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    // ⋮ Menu Icon
                    const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(Icons.more_vert, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }else{
      return Container();
    }
  }
}
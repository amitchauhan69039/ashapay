import 'package:flutter/material.dart';

import '../../asha_pay.dart';

class ParivarKiSuchiScreen extends StatefulWidget {
  final String step;
  const ParivarKiSuchiScreen({super.key,required this.step});

  @override
  State<ParivarKiSuchiScreen> createState() => _ParivarKiSuchiScreenState();
}

class _ParivarKiSuchiScreenState extends State<ParivarKiSuchiScreen> {
  final List<Map<String, dynamic>> members = [
    {'name': 'PARVEEN KUMARI', 'selected': false},
    {'name': 'JONISH KUMAR', 'selected': false},
    {'name': 'PARNISH SANGWAN', 'selected': false},
    {'name': '', 'selected': false},
    {'name': 'ABC', 'selected': false},
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      appBar: AppBar(
        backgroundColor: const Color(0xff0f7df2),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'परिवार की सूची',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body:  ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        children: [
          ...List.generate(members.length, (index) {
            return Container(
              height: 60,
              margin: const EdgeInsets.only(bottom: 14),
              decoration: BoxDecoration(
                color: const Color(0xffe8e6f2),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    color: const Color(0xff2785d1),
                    child: const Center(
                      child: Icon(Icons.person_outline, color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        members[index]['name'],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        members[index]['selected'] = !members[index]['selected'];
                      });
                    },
                    child: Container(
                      width: 25,
                      height: 25,
                      margin: const EdgeInsets.only(right: 18),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff0f7df2), width: 2),
                      ),
                      child: members[index]['selected']
                          ? const Icon(Icons.check, size: 20)
                          : null,
                    ),
                  ),
                ],
              ),
            );
          }),

          // 👇 Button comes right after list
          const SizedBox(height: 10),

          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {

                if(widget.step=="step1"){
                  final List<String> selectedMembers =[];
                  for(int i=0;i<members.length;i++){
                    if(members[i]['selected']==true){
                      selectedMembers.add(members[i]['name']);
                    }
                  }
                  Get.back(result: selectedMembers);
                }

                if(widget.step=="step3"){
                  final List<String> selectedMembers =[];
                  var selected=0;
                  for(int i=0;i<members.length;i++){
                    if(members[i]['selected']==true){
                      selected++;
                      selectedMembers.add(members[i]['name']);
                    }
                  }

                  if(selected!=2){

                    toastMsg("Please select only two members");
                  }else{
                    Get.back(result: selectedMembers);
                  }

                }

              },
              child: Text( "परिवार जोड़ें",
                style: TextStyle(fontSize: 16,
                color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }



}
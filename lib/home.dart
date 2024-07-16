import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ratniprofessora/add_prof.dart';
import 'package:ratniprofessora/prof_page.dart';

class Home extends StatefulWidget {
  static const String route = '/';
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool overlay_on = false;
  void removeEntry() {
      overlay_on = false;
      setState(() {});
    }
  @override
  Widget build(BuildContext context) {
    bool move = (MediaQuery.sizeOf(context).width) < (MediaQuery.sizeOf(context).height);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/hse.jpeg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken)
        )
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Row(
            children: [
              Icon(Icons.school, color: Colors.white),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text("Рэйтни Профессора", style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
          backgroundColor: Colors.black,
        ),
        body: Stack(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20, left: 10, right: 10),
                        child: Text("Найти профессора в\nВысшей Школе Экономики", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30,), textAlign: TextAlign.center,),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: SearchAnchor(
                              viewConstraints: BoxConstraints(
                                maxHeight: 210,
                                minHeight: 0
                              ),
                              isFullScreen: move,
                              builder: (BuildContext context, SearchController controller){
                              return 
                                  SizedBox(
                                    width: 500,
                                    child: SearchBar(
                                      onTap: () {
                                        move = true;
                                        setState(() {});
                                        Future.delayed(Duration(seconds: 1));
                                        controller.openView();
                                      },
                                      onChanged: (_) {
                                        move = true;
                                        setState(() {});
                                        Future.delayed(Duration(seconds: 1));
                                        controller.openView();
                                        controller.openView();
                                      },
                                      hintText: "Имя профессора",
                                      leading: Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: const Icon(Icons.search_outlined),
                                      ),
                                      backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
                                    )
                              );
                              },
                              suggestionsBuilder: (BuildContext context, SearchController controller) async {
                                if (controller.text.isEmpty) {
                                  return List<ListTile>.generate(0, (int index) => ListTile());
                                }
                                  var query = FirebaseFirestore.instance
                                  .collection("Высшая Школа Экономики").get();
                                  // .where(FieldPath.documentId, isGreaterThanOrEqualTo: controller.text.toLowerCase())
                                  // .where(FieldPath.documentId, isLessThan: controller.text.toLowerCase() + '\uf8ff')
                                  // .get();
                                            
                                var snapshot = await query;
                                final docData = snapshot.docs.map((doc) => doc.data()).toList();
                                final subString = [];

                                 for (var doc in docData) {
                                    if (controller.text != "" && doc["name"].contains(controller.text.toLowerCase())) {
                                      subString.add(doc["name"]);
                                    }
                                  }
                                if (subString.isEmpty){
                                  return List<Padding>.generate(1, (int index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: ListTile(
                                        
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: BorderSide(width: 1, color: Colors.black)),
                                        leading: Icon(Icons.add),
                                        title: Text("Пусто"),
                                        subtitle: Text("Добавить профессора"),
                                        onTap: () {
                                          setState(() {
                                            controller.closeView("");
                                            overlay_on = true;
                                            setState(() {});
                                          });
                                        }
                                      ),
                                    );
                                  });
                                }
                                return List<Padding>.generate(subString.length, (int index) {
                                  final name = subString[index];
                                  // final String name = doc["name"];
                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: BorderSide(width: 1, color: Colors.black)),
                                      leading: Icon(Icons.school),
                                      title: Text(name),
                                      onTap: () {
                                        setState(() {
                                          controller.closeView(name);
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfPage(name: name)));
                                        });
                                      },
                                    ),
                                  );
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                
              ),
            ),
            if (overlay_on) 
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            color: Color(3).withOpacity(0.3),
          ),
          if (overlay_on)
          Center(child: AddProfessor(removeEntry: removeEntry,))
          ],
        ),
      ),
    );
  }
}
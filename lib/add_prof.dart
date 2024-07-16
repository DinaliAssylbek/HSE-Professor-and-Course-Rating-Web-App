import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddProfessor extends StatefulWidget {
  static const String route = '/add_prof';
  Function removeEntry;
  AddProfessor({required this.removeEntry, super.key});

  @override
  State<AddProfessor> createState() => _AddProfessorState();
}

class _AddProfessorState extends State<AddProfessor> {
  String firstName = "";
  String lastName = "";
  @override
  Widget build(BuildContext context) {
    return Center(
          child: Container(
            width: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15)
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20,10,20,20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                                onPressed: () {
                                  widget.removeEntry();
                                }, 
                                icon: Icon(Icons.cancel_outlined)
                              )
                    ],
                  ),
                  const Text("Имя Профессора", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SizedBox(
                      width: 500,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black))
                        ),
                        onChanged: (val) {
                          firstName = val;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  const Text("Фамилия Профессора", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SizedBox(
                      width: 500,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.black))
                        ),
                        onChanged: (val) {
                          lastName = val;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(500, 50),
                      elevation: 0.0,
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                    ),
                    child: Text("Создать", style: TextStyle(color: Colors.white)), 
                    onPressed: () {
                      String name = firstName.toLowerCase() + " " + lastName.toLowerCase();
                      FirebaseFirestore.instance.collection("Высшая Школа Экономики").doc(name).set(
                        {'name':name}
                      );
                    },
                  )
                ],
              ),
            ),
          )
    );
  }
}
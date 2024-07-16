import 'package:flutter/material.dart';
import 'prof_page.dart';

class ReviewContainer extends StatelessWidget {
  final int rating;
  final String courseName;
  final int difficulty;
  final String grade;
  final bool takeAgain;
  final bool textBook;
  final String fullReview;
  ReviewContainer({required this.rating, required this.courseName, required this.difficulty, required this.grade, required this.takeAgain, required this.textBook, required this.fullReview, super.key});

  @override
  Widget build(BuildContext context) {
    bool phone = (MediaQuery.sizeOf(context).width) < (MediaQuery.sizeOf(context).height);
    return Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * (1.9/3),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Column(
                            children: [
                              Text("Качество", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: rating >= 3 ? const Color.fromARGB(255, 210, 238, 130) : const Color.fromARGB(255, 254, 121, 104),
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: SizedBox(width: 70, height: 70, child: Center(child: Text(rating.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40))))
                                ),
                              ),
                              Text("Трудность", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
                              Container(
                                decoration: BoxDecoration(
                                    color: difficulty >= 3 ? const Color.fromARGB(255, 210, 238, 130) : const Color.fromARGB(255, 254, 121, 104),
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                child: SizedBox(width: 70, height: 70, child: Center(child: Text(difficulty.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40))))
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: 
                              Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox( width: phone ? (MediaQuery.sizeOf(context).width - 180) : (MediaQuery.sizeOf(context).width * (1.9/3)) - 240, child: Text(courseName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25), softWrap: true,)),
                                        SizedBox(
                                          width: MediaQuery.sizeOf(context).width * (1.9/3) - 240,
                                          child: Wrap(
                                            direction: Axis.horizontal,
                                            
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 10),
                                                  child: Container(child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text("Взяли бы еще раз: ", style: TextStyle(fontSize: 18),),
                                                      Text(takeAgain ? "Да" : "Нет", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)
                                                    ],
                                                  )),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(right:10),
                                                  child: Container(child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text("Учебник: ", style: TextStyle(fontSize: 18)),
                                                      Text(textBook ? "Да" : "Нет", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)
                                                    ],
                                                  )),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 10),
                                                  child: Container(child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text("Оценка: ", style: TextStyle(fontSize: 18)),
                                                      Text(grade, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)
                                                    ],
                                                  )),
                                                )
                                              ],
                                            ),
                                        ),
                                        
                                        
                                            SizedBox(
                                              width: phone ? (MediaQuery.sizeOf(context).width - 180) : (MediaQuery.sizeOf(context).width * (1.9/3)) - 240,
                                              child: Text(fullReview, style: TextStyle(fontSize: 18), softWrap: true)),
                                          
                                      ],
                                    ),
                            
                          ),
                        
                      ],
                    ),
                  ),
                ),
    );
  }
}
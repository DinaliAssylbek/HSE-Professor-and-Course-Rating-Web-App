import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AddReview extends StatefulWidget {
  String name;
  Function removeEntry;
  Function reload;
  Function settingState;
  AddReview({required this.name, required this.removeEntry, required this.reload, required this.settingState, super.key});

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  bool textbooks = true;
  bool takeAgain = true;
  int currentPage = 0;
  double rating = 3;
  double difficulty = 3;
  String fullReview = "";
  String courseName = "";
  String grade = "";

  @override
  Widget build(BuildContext context) {
    bool phone = (MediaQuery.sizeOf(context).width) < (MediaQuery.sizeOf(context).height);
    return Container(
      height: MediaQuery.sizeOf(context).height / 1.3,
      width: phone ? MediaQuery.sizeOf(context).width / 1.2 : MediaQuery.sizeOf(context).width / 1.5,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Container(
            height: MediaQuery.sizeOf(context).height / 1.3,
            width: phone ? MediaQuery.sizeOf(context).width / 1.2 : MediaQuery.sizeOf(context).width / 1.5,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(15),
              color: Colors.white
            ),
            margin: EdgeInsets.all(10),
            child: Row(
              children: [
                if (!phone)
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))
                    ),
                    child: Column(
                      children: [
                        Expanded(child: Container(child: Image.asset("assets/rateGraphic.png"),)),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20,0,20,0),
                    child: Container(
                      height: MediaQuery.sizeOf(context).height / 1.3,
                      width: phone ? MediaQuery.sizeOf(context).width / 1.2 : MediaQuery.sizeOf(context).width / 3,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  widget.settingState();
                                  widget.reload();
                                  widget.removeEntry();
                                }, 
                                icon: Icon(Icons.cancel_outlined)
                              )
                            ],
                          ),
                          if (currentPage == 0)
                          Expanded(
                            child: Container(
                              child: Column(
                                children: [
                                  Spacer(),
                                  Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text("Название Курса"),
                                              SizedBox(
                                                width: 300,
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.black))
                                                  ),
                                                  onChanged: (val) {
                                                    courseName = val;
                                                    setState(() {});
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                          ),
                                    Spacer(),
                                    Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("Оценка За Курс(По Желанию)"),
                                        SizedBox(
                                          width: 300,
                                          child: TextField(
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.black))
                                            ),
                                            onChanged: (val) {
                                              grade = val;
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                    ),
                                    Spacer(),
                                    Container(
                                      width: 300,
                                      child: Column(
                                        children: [
                                          Text("Этот профессор пользовался учебниками?"),
                                          Row(children: [
                                            IconButton(
                                              onPressed: () {
                                                textbooks = true;
                                                setState(() {});
                                              }, 
                                              icon: Icon(textbooks ? Icons.circle : Icons.circle_outlined),
                                              ),
                                              Text("Да", style: TextStyle(fontWeight: FontWeight.bold)),
                                          ],),
                                          Row(children: [
                                            IconButton(
                                              onPressed: () {
                                                textbooks = false;
                                                setState(() {});
                                              }, 
                                              icon: Icon(textbooks ? Icons.circle_outlined : Icons.circle),
                                              ),
                                              Text("Нет", style: TextStyle(fontWeight: FontWeight.bold)),
                                          ],)
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      width: 300,
                                      child: Row(
                                        children: [
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                currentPage = 1;
                                                setState(() {});
                                              }, 
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0.0,
                                                backgroundColor: Colors.black,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                )
                                              ),
                                              child: Text("Next >", style: TextStyle(color: Colors.white))
                                              ),
                                          ),
                                      
                                        ],
                                      ),
                                    ),
                                    Spacer()
                                ],
                              ),
                            ),
                          ),
                          if (currentPage == 1)
                          Expanded(
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    width: 300,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Text("Оцените Своего Профессора", textAlign: TextAlign.center,),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("1   "),
                                            RatingBar.builder(
                                              initialRating: 3,
                                              itemCount: 5,
                                              itemBuilder: (context, index) {
                                                switch (index) {
                                                    case 0:
                                                      return Icon(
                                                          Icons.sentiment_very_dissatisfied,
                                                          color: Colors.red,
                                                      );
                                                    case 1:
                                                      return Icon(
                                                          Icons.sentiment_dissatisfied,
                                                          color: Colors.redAccent,
                                                      );
                                                    case 2:
                                                      return Icon(
                                                          Icons.sentiment_neutral,
                                                          color: Colors.amber,
                                                      );
                                                    case 3:
                                                      return Icon(
                                                          Icons.sentiment_satisfied,
                                                          color: Colors.lightGreen,
                                                      );
                                                    case 4:
                                                        return Icon(
                                                          Icons.sentiment_very_satisfied,
                                                          color: Colors.green,
                                                        );
                                                }
                                                return Icon(Icons.circle);
                                              },
                                              onRatingUpdate: (val) {
                                                rating = val;
                                                setState(() {});
                                              },
                                            ),
                                            Text("   5")
                                          ],
                                        ),
                                        Text("Оценка - " + rating.toString(), style: TextStyle(fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    width: 300,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Text("Насколько трудным\nбыл этот профессор?", textAlign: TextAlign.center,),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("1   "),
                                            RatingBar.builder(
                                              initialRating: 3,
                                              itemCount: 5,
                                              itemBuilder: (context, index) {
                                                switch (index) {
                                                    case 0:
                                                      return Icon(
                                                          Icons.sentiment_very_dissatisfied,
                                                          color: Colors.red,
                                                      );
                                                    case 1:
                                                      return Icon(
                                                          Icons.sentiment_dissatisfied,
                                                          color: Colors.redAccent,
                                                      );
                                                    case 2:
                                                      return Icon(
                                                          Icons.sentiment_neutral,
                                                          color: Colors.amber,
                                                      );
                                                    case 3:
                                                      return Icon(
                                                          Icons.sentiment_satisfied,
                                                          color: Colors.lightGreen,
                                                      );
                                                    case 4:
                                                        return Icon(
                                                          Icons.sentiment_very_satisfied,
                                                          color: Colors.green,
                                                        );
                                                }
                                                return Icon(Icons.circle);
                                              },
                                              onRatingUpdate: (val) {
                                                difficulty = val;
                                                setState(() {});
                                              },
                                            ),
                                            Text("    5")
                                          ],
                                        ),
                                        Text("Оценка - " + difficulty.toString(), style: TextStyle(fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ),
                                    Spacer(),
                                    Container(
                                      width: 300,
                                      child: Column(
                                        children: [
                                          Text("Вы бы взяли этого профессора еще раз?"),
                                          Row(children: [
                                            IconButton(
                                              onPressed: () {
                                                textbooks = true;
                                                setState(() {});
                                              }, 
                                              icon: Icon(textbooks ? Icons.circle : Icons.circle_outlined),
                                              ),
                                              Text("Да", style: TextStyle(fontWeight: FontWeight.bold)),
                                          ],),
                                          Row(children: [
                                            IconButton(
                                              onPressed: () {
                                                textbooks = false;
                                                setState(() {});
                                              }, 
                                              icon: Icon(textbooks ? Icons.circle_outlined : Icons.circle),
                                              ),
                                              Text("Нет", style: TextStyle(fontWeight: FontWeight.bold)),
                                          ],)
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      width: 300,
                                      child: Row(
                                        children: [
                                          Spacer(),
                                          ElevatedButton(
                                              onPressed: () {
                                                currentPage = 0;
                                                setState(() {});
                                              }, 
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0.0,
                                                backgroundColor: Colors.black,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                )
                                              ),
                                              child: Text("< Back", style: TextStyle(color: Colors.white))
                                              ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                currentPage = 2;
                                                setState(() {});
                                              }, 
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0.0,
                                                backgroundColor: Colors.black,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                )
                                              ),
                                              child: Text("Next >", style: TextStyle(color: Colors.white))
                                              ),
                                          ),
                                      
                                        ],
                                      ),
                                    ),
                                    Spacer()
                                ],
                              ),
                            ),
                          ),
                          if (currentPage == 2)
                          Expanded(
                            child: Container(
                              child: Column(
                                children: [
                                  Spacer(),
                                  Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 300,
                                                child: Row(
                                                  children: [
                                                    Text("Напишите Отзыв", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                                    Spacer()
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 300,child: Text("Объясните профессиональные способности профессора, включая стиль преподавания и способность ясно излагать материал.")),
                                              SizedBox(
                                                width: 300,
                                                height: 250,
                                                child: TextField(
                                                  maxLines: null,
                                                  expands: true,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.black))
                                                  ),
                                                  onChanged: (val) {
                                                    fullReview = val;
                                                    setState(() {});
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                          ),
                                          Spacer(),
                                    Container(
                                      width: 300,
                                      child: Row(
                                        children: [
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 10),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                currentPage = 1;
                                                setState(() {});
                                              }, 
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0.0,
                                                backgroundColor: Colors.black,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                )
                                              ),
                                              child: Text("< Back", style: TextStyle(color: Colors.white))
                                              ),
                                          ),
                                          ElevatedButton(
                                              onPressed: () async {
                                                await FirebaseFirestore.instance.collection("Высшая Школа Экономики").doc(widget.name).collection("Reviews").doc().set({
                                                  'Course Name': courseName,
                                                  'Grade': grade,
                                                  'Textbook':textbooks,
                                                  'Rating' : rating,
                                                  'Difficulty': difficulty,
                                                  'Take Again':takeAgain,
                                                  'Full Review' : fullReview,
                                                  'Timestamp' : DateTime.now()
                                                });
                                                currentPage = 3;
                                                setState(() {});
                                              },
                                              
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0.0,
                                                backgroundColor: Colors.black,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                )
                                              ),
                                              child: Text("Submit", style: TextStyle(color: Colors.white))
                                              ),
                                        ],
                                      ),
                                    ),
                                    Spacer()
                                ],
                              ),
                            ),
                          ),
                          if (currentPage == 3)
                          Expanded(
                            child: Container(
                              child: Column(
                                children: [
                                  Spacer(),
                                  Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text("Отзыв Отправлен", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                              Icon(Icons.check_circle, color: Colors.green, size : 100,),
                                            ],
                                          )
                                          ),
                                    Spacer()
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
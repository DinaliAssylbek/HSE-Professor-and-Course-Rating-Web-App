import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ratniprofessora/add_review.dart';
import 'package:ratniprofessora/myBarGraph.dart';
import 'package:ratniprofessora/reviewContainer.dart';

class ProfPage extends StatefulWidget {
  String name;
  ProfPage({required this.name, super.key});

  @override
  State<ProfPage> createState() => _ProfPageState();
}

class _ProfPageState extends State<ProfPage> {
  bool overlay_on = false;
  OverlayEntry? myOverlayEntry;
  double rating = 0.0;
  double difficulty = 0.0;
  double takeAgain = 0.0;
  int totalCount = 0;
  List<double> ratingData = [0,0,0,0,0]; 
  List<ProfReview> all_prof_review = [];

  void reset(){
    setState(() {});
  }
  void get_data() async {
    all_prof_review = [];
    var query = FirebaseFirestore.instance.collection("Высшая Школа Экономики").doc(widget.name).collection("Reviews").get();
    var snapshot = await query;
    final docData = snapshot.docs.map((doc) => doc.data()).toList();
    if (docData.isEmpty)
    return;
    double ratingSum = 0;
    double difficultySum = 0;
    totalCount = docData.length;
    for (var doc in docData) {
      var full_prof_review = ProfReview(
        rating: int.parse(doc["Rating"].toString()), 
        courseName: doc["Course Name"], 
        difficulty: int.parse(doc["Difficulty"].toString()), 
        fullReview: doc["Full Review"], 
        grade: doc["Grade"], 
        takeAgain: doc["Take Again"], 
        textBook: doc["Textbook"]
        );
      all_prof_review.add(full_prof_review);
      double currRating = double.parse(doc["Rating"].toString());
      ratingSum += currRating;
      ratingData[(currRating - 1).toInt()] += 1;
      difficultySum += double.parse(doc["Difficulty"].toString());
      if (doc["Take Again"])
        takeAgain += 1;
    }
    rating= ratingSum / docData.length;
    difficulty = difficultySum / docData.length;
    takeAgain = takeAgain / docData.length;
    setState(() {});
  }
  @override
  void initState() {
    super.initState();
    get_data();
  }
  @override
  Widget build(BuildContext context) {
    void removeEntry(){
      overlay_on = false;
      setState(() {});
    }
    String firstName = widget.name.split(" ")[0];
    firstName = firstName[0].toUpperCase() + firstName.substring(1);
    String lastName = widget.name.split(" ")[1];
    lastName = lastName[0].toUpperCase() + lastName.substring(1);
    bool phone = (MediaQuery.sizeOf(context).width) < (MediaQuery.sizeOf(context).height);
    return PopScope(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          
          backgroundColor: Colors.black,
          title: Row(
            children: [
              Icon(Icons.school, color: Colors.white),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text("Рэйтни Профессора", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Row(
                children: [
                  if (!phone)
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width / 3,
                      height: MediaQuery.sizeOf(context).height,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                                  Text(firstName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.sizeOf(context).height / 20)),
                            Text(lastName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.sizeOf(context).height / 20)),
                            Padding(
                              padding: const EdgeInsets.only(top: 15, bottom: 15),
                              child: Row(
                                children: [
                                  Spacer(),
                                  ElevatedButton(
                                    onPressed: () {
                                      overlay_on = true;
                                      setState(() {});
                                    }, 
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size((MediaQuery.sizeOf(context).width / 3) - 40, 50),
                                      elevation: 0.0,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )
                                    ),
                                    child: Text("Написать Отзыв", style: TextStyle(color: Colors.black))
                                    ),
                                    Spacer()
                                ],
                              ),
                            ),
                            
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.circular(15)
                                          ),
                                          // color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              children: [
                                                Text("Рейтинг", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                                Container(
                                                  width: ((MediaQuery.sizeOf(context).width / 3) / 2) - 50,
                                                  height: ((MediaQuery.sizeOf(context).width / 3) / 2) - 70,
                                                  child: RatingPieChart(rating: rating.toDouble(),)
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.circular(15)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              children: [
                                                Text("Сложность", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                                Container(
                                                  width: ((MediaQuery.sizeOf(context).width / 3) / 2) - 50,
                                                  height: ((MediaQuery.sizeOf(context).width / 3) / 2) - 70,
                                                  child: RatingPieChart(rating: difficulty.toDouble(),)
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                              
                                      ],
                                  
                              ),
                          ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                  // height: 200,
                                  width: (MediaQuery.sizeOf(context).width / 3) - 40,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,8.0),
                                    child: MyBarGraph(ratingData: ratingData, count: totalCount),
                                  )
                                  ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: phone ? MediaQuery.sizeOf(context).width : MediaQuery.sizeOf(context).width * (1.9/3),
                    height: phone ? MediaQuery.sizeOf(context).height : MediaQuery.sizeOf(context).height - 100,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (phone)
                          Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                                  Text(firstName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.sizeOf(context).height / 20)),
                            Text(lastName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.sizeOf(context).height / 20)),
                            // Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(top: 15, bottom: 15),
                              child: Row(
                                children: [
                                  Spacer(),
                                  ElevatedButton(
                                    onPressed: () {
                                      // showFirstOverlay();
                                      
                                      overlay_on = true;
                                      setState(() {});
                                    }, 
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size((MediaQuery.sizeOf(context).width) - 70, 50),
                                      elevation: 0.0,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )
                                    ),
                                    child: Text("Написать Обзор", style: TextStyle(color: Colors.black))
                                    ),
                                    Spacer()
                                ],
                              ),
                            ),
                            
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.circular(15)
                                          ),
                                          // color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              children: [
                                                Text("Рейтинг", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                                Container(
                                                  width: ((MediaQuery.sizeOf(context).width ) / 2) - 75,
                                                  height: ((MediaQuery.sizeOf(context).width) / 2) - 100,
                                                  child: RatingPieChart(rating: rating.toDouble(),)
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.circular(15)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              children: [
                                                Text("Сложность", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                                Container(
                                                  width: ((MediaQuery.sizeOf(context).width) / 2) - 75,
                                                  height: ((MediaQuery.sizeOf(context).width) / 2) - 100,
                                                  child: RatingPieChart(rating: difficulty.toDouble(),)
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                              
                                      ],
                                  
                              ),
                          ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                  // height: 200,
                                  width: (MediaQuery.sizeOf(context).width) - 40,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,8.0),
                                    child: MyBarGraph(ratingData: ratingData, count: totalCount),
                                  )
                                  ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text("Все Отзывы", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                          ),
                            ListView.builder(
                                    shrinkWrap: true, 
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: all_prof_review.length,
                                        itemBuilder: (context, index) {
                                          return ReviewContainer(rating: all_prof_review[index].rating, courseName: all_prof_review[index].courseName, difficulty: all_prof_review[index].difficulty, grade: all_prof_review[index].grade, takeAgain: all_prof_review[index].takeAgain, textBook: all_prof_review[index].textBook, fullReview: all_prof_review[index].fullReview);
                                        }
                                        ),
                             
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          
          if (overlay_on) 
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            color: Color(3).withOpacity(0.3),
          ),
          if (overlay_on)
          Center(child: AddReview(name: widget.name, removeEntry: removeEntry, reload: initState, settingState: reset,))
          ]
        ),
      ),
    );
  }
}

class BarData {
  final double five;
  final double four;
  final double three;
  final double two;
  final double one;

  BarData({
    required this.five,
    required this.four,
    required this.three,
    required this.two,
    required this.one
  });

  List<IndividualBar> barData = [];

  void initializeBar(){
    barData = [
      IndividualBar(x: 1, y: one),
      IndividualBar(x: 2, y: two),
      IndividualBar(x: 3, y: three),
      IndividualBar(x: 4, y: four),
      IndividualBar(x: 5, y: five)
    ];
  }

  List<double> all_data = [];
  double getBiggest(){
    all_data = [five, four, three, two, one];
    double biggest = 0;
    for (double data in all_data){
      if (data > biggest)
        biggest = data;
    }
    return biggest;
  }
}

class IndividualBar{
  final int x;
  final double y;

  IndividualBar({required this.x, required this.y});
}

class ProfReview{
  final int rating;
  final String courseName;
  final int difficulty;
  final String grade;
  final bool takeAgain;
  final bool textBook;
  final String fullReview;

  ProfReview({required this.rating, required this.courseName, required this.difficulty, required this.fullReview, required this.grade, required this.takeAgain, required this.textBook});
}
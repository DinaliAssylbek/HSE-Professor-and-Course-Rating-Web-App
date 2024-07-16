import 'package:flutter/material.dart';
import 'package:ratniprofessora/add_review.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:ratniprofessora/prof_page.dart';

class MyBarGraph extends StatelessWidget {
  final List ratingData;
  final int count;
  const MyBarGraph({required this.ratingData, required this.count, super.key});

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      one: ratingData[0],
      two: ratingData[1],
      three: ratingData[2],
      four: ratingData[3],
      five: ratingData[4]
    );
    myBarData.initializeBar();
    return BarChart(
      BarChartData(
        maxY: myBarData.getBiggest() + 1,
        minY: 0,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: AxisTitles(axisNameWidget: Text("Распределение Рейтингов", style: TextStyle(fontWeight: FontWeight.bold)), sideTitles: SideTitles(showTitles: false), drawBelowEverything: false, axisNameSize: 30),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        barGroups: myBarData.barData.map(
          (data) => BarChartGroupData(
            x: data.x,
            barRods: [BarChartRodData(
              toY: data.y,
              color: Colors.grey[800],
              width: 25,
              borderRadius: BorderRadius.circular(4),
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                toY: myBarData.getBiggest() + 1,
                color:Colors.grey.withOpacity(0.5)
              )
              )],
              
          )
        ).toList()
      ) 
    );
  }
}

class RatingPieChart extends StatelessWidget {
  double rating;
  RatingPieChart({required this.rating, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(rating.toStringAsFixed(1), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        PieChart(
          PieChartData(
            sections: [
              PieChartSectionData(
                showTitle: false,
                radius: 15,
                value: rating,
                color: Colors.grey[800]
              ),
              PieChartSectionData(
                radius: 15,
                showTitle: false,
                value: 5 - rating,
                color: Colors.grey.withOpacity(0.5)
              )
            ]
          )
        ),
      ],
    );
  }
}
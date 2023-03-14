import 'dart:math';

import 'package:charts_vacation/main.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'models/my_data.dart';

// class BarChartSample1 extends StatefulWidget {
//   final String title;
//   final List<MyData> data;
//   BarChartSample1({this.title = '', required this.data, super.key});

//   @override
//   State<BarChartSample1> createState() => _BarChartSample1State();
// }

// class _BarChartSample1State extends State<BarChartSample1> {
//   final Color barBackgroundColor = Colors.white.withOpacity(0.8);

//   final Color barColor = Colors.yellow;

//   final Color touchedBarColor = Colors.green;

//   final Duration animDuration = const Duration(milliseconds: 250);

//   int touchedIndex = -1;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           Text(
//             widget.title,
//             style: TextStyle(
//               color: Colors.green,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(
//             height: 38,
//           ),
//           SizedBox(
//             height: 300,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: BarChart(
//                 mainBarData(),
//                 swapAnimationDuration: animDuration,
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 12,
//           ),
//         ],
//       ),
//     );
//   }

//   BarChartGroupData makeGroupData(
//     int x,
//     double y, {
//     bool isTouched = false,
//     Color? barColor,
//     double width = 22,
//     List<int> showTooltips = const [],
//   }) {
//     barColor ??= barColor;
//     return BarChartGroupData(
//       x: x,
//       barRods: [
//         BarChartRodData(
//           toY: isTouched ? y + 1 : y,
//           color: isTouched ? touchedBarColor : barColor,
//           width: width,
//           borderSide: isTouched
//               ? BorderSide(color: touchedBarColor)
//               : const BorderSide(color: Colors.white, width: 0),
//           // borderRadius: BorderRadius.zero,
//           // backDrawRodData: BackgroundBarChartRodData(
//           //   show: true,
//           //   toY: 20,
//           //   color: Colors.pink,
//           // ),
//         ),
//       ],
//       showingTooltipIndicators: showTooltips,
//     );
//   }

//   List<BarChartGroupData> showingGroups() =>
//       List.generate(widget.data.length, (i) {
//         return makeGroupData(i, widget.data[i].percent.toDouble(),
//             isTouched: i == touchedIndex);
//       });

//   BarChartData mainBarData() {
//     return BarChartData(
//       maxY: 60,
//       barTouchData: BarTouchData(
//         touchTooltipData: BarTouchTooltipData(
//           tooltipBgColor: Colors.blueGrey,
//           tooltipHorizontalAlignment: FLHorizontalAlignment.right,
//           tooltipMargin: -10,
//           getTooltipItem: (group, groupIndex, rod, rodIndex) {
//             return BarTooltipItem(
//               '${widget.data[group.x].category}\n',
//               const TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//               ),
//               children: <TextSpan>[
//                 TextSpan(
//                   text: '${rod.toY.round() - 1}%',
//                   style: TextStyle(
//                     color: touchedBarColor,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//         touchCallback: (FlTouchEvent event, barTouchResponse) {
//           setState(() {
//             if (!event.isInterestedForInteractions ||
//                 barTouchResponse == null ||
//                 barTouchResponse.spot == null) {
//               touchedIndex = -1;
//               return;
//             }
//             touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
//           });
//         },
//       ),
//       titlesData: FlTitlesData(
//         show: true,
//         rightTitles: AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         topTitles: AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         bottomTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             getTitlesWidget: getTitles,
//             reservedSize: 70,
//           ),
//         ),
//         leftTitles: AxisTitles(
//           sideTitles: SideTitles(showTitles: true, reservedSize: 40),
//         ),
//       ),
//       borderData: FlBorderData(
//         show: false,
//       ),
//       barGroups: showingGroups(),
//       gridData: FlGridData(show: false),
//     );
//   }

//   Widget getTitles(double value, TitleMeta meta) {
//     const style = TextStyle(
//       color: Colors.green,
//       // fontWeight: FontWeight.bold,
//       fontSize: 12,
//     );
//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       // space: 16,
//       child: SizedBox(
//         width: MediaQuery.of(context).size.width / (widget.data.length + 2),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 4),
//           child: Text(
//             widget.data[value.toInt()].category.split('(')[0],
//             style: style,
//             maxLines: 3,
//             overflow: TextOverflow.ellipsis,
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ),
//     );
//   }
// }

class BarChartSample1 extends StatefulWidget {
  final String title;
  final List<List<MyData>> data;
  final List<String> categories;
  BarChartSample1(
      {this.title = '',
      required this.data,
      required this.categories,
      super.key});

  @override
  State<BarChartSample1> createState() => _BarChartSample1State();
}

class _BarChartSample1State extends State<BarChartSample1> {
  final Color barBackgroundColor = Colors.white.withOpacity(0.8);

  final Color barColor = Colors.yellow;

  final Color touchedBarColor = Colors.green;

  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            widget.title,
            style: TextStyle(
              color: Colors.green,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 38,
          ),
          SizedBox(
            height: 300,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: BarChart(
                mainBarData(),
                swapAnimationDuration: animDuration,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    List<List<MyData>> dd, {
    bool isTouched = false,
    Color? barColor,
    double width = 8,
    List<int> showTooltips = const [],
  }) {
    barColor ??= barColor;
    return BarChartGroupData(
      x: x,
      barRods: List.generate(
        dd.length,
        (index) => BarChartRodData(
          toY: isTouched
              ? dd[index][x].percent + 1
              : dd[index][x].percent.toDouble(),
          color: isTouched ? touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: touchedBarColor)
              : const BorderSide(color: Colors.white, width: 0),
          // borderRadius: BorderRadius.zero,
          // backDrawRodData: BackgroundBarChartRodData(
          //   show: true,
          //   toY: 20,
          //   color: Colors.pink,
          // ),
        ),
      ),
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() =>
      List.generate(widget.data[0].length, (i) {
        return makeGroupData(
          i,
          widget.data,
          isTouched: i == touchedIndex,
        );
      });

  BarChartData mainBarData() {
    return BarChartData(
      maxY: 60,
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.blueGrey,
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return BarTooltipItem(
              '${widget.categories[rodIndex]}\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '${rod.toY.round() - 1}%',
                  style: TextStyle(
                    color: touchedBarColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 70,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true, reservedSize: 40),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.green,
      // fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      // space: 16,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / (widget.data.length * 3 + 2),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            widget.data[0][value.toInt()].category.split('(')[0],
            style: style,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'models/my_data.dart';

class PieChartSample1 extends StatefulWidget {
  final String title;
  final List<List<MyData>> data;
  final List<String> categories;
  PieChartSample1(
      {this.title = '',
      required this.data,
      required this.categories,
      super.key});

  @override
  State<StatefulWidget> createState() => PieChartSample1State();
}

class PieChartSample1State extends State<PieChartSample1> {
  int touchedIndex = -1;

  List<Color> colors = [
    AppColors.contentColorBlue,
    AppColors.contentColorYellow,
    AppColors.contentColorPink,
    AppColors.contentColorGreen,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 28,
            width: 28,
          ),

          // const SizedBox(
          //   height: 18,
          //   width: 18,
          // ),
          ...widget.data.map(
            (e) => SizedBox(
              height: MediaQuery.of(context).size.width /
                  (widget.categories.length + 1),
              width: MediaQuery.of(context).size.width /
                  (widget.categories.length + 1),
              // flex: 2,
              child: Column(
                children: [
                  Text(widget.categories[widget.data.indexOf(e)]),
                  Expanded(
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                touchedIndex = -1;
                                return;
                              }
                              touchedIndex = pieTouchResponse
                                  .touchedSection!.touchedSectionIndex;
                            });
                          },
                        ),
                        startDegreeOffset: 180,
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 1,
                        centerSpaceRadius: 0,
                        sections: showingSections(e),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            // flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: widget.data[0]
                  .map((e) => Indicator(
                        color:
                            colors[widget.data[0].indexOf(e) % colors.length],
                        text: e.category,
                        isSquare: false,
                        size: touchedIndex == 0 ? 18 : 16,
                        textColor: touchedIndex == widget.data[0].indexOf(e)
                            ? AppColors.contentColorBlue
                            : AppColors.contentColorBlack,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(List<MyData> data) {
    return List.generate(
      data.length,
      (i) {
        final isTouched = i == touchedIndex;

        return PieChartSectionData(
          color: colors[i % colors.length],
          value: data[i].percent.toDouble(),
          title: data[i].percent.round().toString() + '%',
          titleStyle: TextStyle(fontSize: 20),
          titlePositionPercentageOffset: 0.8,
          radius: isTouched
              ? 60
              : MediaQuery.of(context).size.width /
                  (widget.categories.length + 1) /
                  2.5,
          // borderSide: isTouched
          //     ? const BorderSide(color: AppColors.contentColorWhite, width: 6)
          //     : BorderSide(color: AppColors.contentColorWhite.withOpacity(0)),
        );
      },
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          child: Text(
            text,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        )
      ],
    );
  }
}

class AppColors {
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);
}

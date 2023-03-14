import 'package:charts_vacation/models/my_data.dart';
import 'package:flutter/material.dart';

import '../count_people_card.dart';

class LineCircleChart extends StatefulWidget {
  final List<MyData> data;
  LineCircleChart({required this.data, super.key});

  @override
  State<LineCircleChart> createState() => _LineCircleChartState();
}

class _LineCircleChartState extends State<LineCircleChart> {
  List<MyData> dataSort = [];

  @override
  Widget build(BuildContext context) {
    dataSort.clear();
    widget.data.sort((a, b) => a.percent.compareTo(b.percent));
    for (int i = 0; i < widget.data.length; i += 2) {
      dataSort.add(widget.data[i]);
    }

    for (int i = widget.data.length % 2 == 0
            ? widget.data.length - 1
            : widget.data.length - 2;
        i > 0;
        i -= 2) {
      dataSort.add(widget.data[i]);
    }
    return Row(
      children: dataSort.map((e) => CountPeopleCard(data: e)).toList(),
    );
  }
}

import 'package:flutter/material.dart';

import 'bar_chart.dart';
import 'pie_chart.dart';
import 'data.dart';
import 'widgets/line_circle_chart.dart';

void main() {
  return runApp(_ChartApp());
}

class _ChartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: _MyHomePage(),
    );
  }
}

const int peopleCount = 1500;

class _MyHomePage extends StatefulWidget {
  _MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  final excel = ExcelMy();

  @override
  void initState() {
    super.initState();
    print('загрузим');
    excel.getDataForAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Планы на отпуск'),
          actions: [
            IconButton(
                onPressed: () {
                  excel.getDataForAll();
                  setState(() {});
                },
                icon: Icon(Icons.all_out)),
            IconButton(
                onPressed: () {
                  excel.getDataForAge();
                  setState(() {});
                },
                icon: Icon(Icons.airline_seat_legroom_extra_rounded)),
            IconButton(
                onPressed: () {
                  excel.getDataForFed();
                  setState(() {});
                },
                icon: Icon(Icons.location_city)),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            LineCircleChart(
              data: excel.groups,
            ),
            BarChartSample1(
              title: '${excel.exselData[47][0].data.toString().split('?')[0]}?',
              data: excel.location,
              categories: excel.groups.map((e) => e.category).toList(),
            ),
            PieChartSample1(
              data: excel.plan,
              categories: excel.groups.map((e) => e.category).toList(),
            ), // НУЖНОЕ
          ]),
        ));
  }
}

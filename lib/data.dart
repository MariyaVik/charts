import 'dart:io';

import 'package:charts_vacation/models/my_data.dart';
import 'package:excel/excel.dart';

import 'models/exel_item.dart';

class ExcelMy {
  ExcelMy() {
    importFromExcel();
  }
  List<List<ExcelItem>> exselData = [];

  List<MyData> groups = [];
  List<List<MyData>> transport = [[]];
  List<List<MyData>> location = [[]];
  List<List<MyData>> plan = [[]];

  void importFromExcel() async {
    var file = "assets/Plany_na_otpusk_FOM_.xlsx";
    var bytes = File(file).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        exselData.add(row
            .map((e) => ExcelItem(
                data: e?.value, column: e?.colIndex, row: e?.rowIndex))
            .toList());
      }
    }
  }

  void getDataForAll() {
    transport = [[]];
    location = [[]];
    plan = [[]];
    for (int i = 33; i < 38; i++) {
      transport[0].add(MyData(
          category: exselData[i][0].data.toString(),
          percent: exselData[i][1].data));
    }

    for (int i = 48; i < 61; i++) {
      location[0].add(MyData(
          category: exselData[i][0].data.toString(),
          percent: exselData[i][1].data));
    }

    for (int i = 12; i < 18; i++) {
      plan[0].add(MyData(
          category: exselData[i][0].data.toString(),
          percent: exselData[i][1].data));
    }
    groups.clear();
    groups.add(MyData(category: 'Все участники', percent: 100));
  }

  void getDataForAge() {
    groups.clear();
    for (int i = 6; i < 10; i++) {
      groups.add(MyData(
          category: exselData[9][i].data.toString(),
          percent: exselData[10][i].data));
    }

    location = List.generate(groups.length, (_) => []);

    for (int i = 0; i < location.length; i++) {
      for (int j = 48; j < 61; j++) {
        location[i].add(MyData(
            category: exselData[j][0].data.toString(),
            percent: exselData[j][i + 6].data));
      }
    }

    plan = List.generate(groups.length, (_) => []);

    for (int i = 0; i < plan.length; i++) {
      for (int j = 12; j < 18; j++) {
        plan[i].add(MyData(
            category: exselData[j][0].data.toString(),
            percent: exselData[j][i + 6].data));
      }
    }
  }

  void getDataForFed() {
    groups.clear();
    for (int i = 26; i < 34; i++) {
      groups.add(MyData(
          category: exselData[9][i].data.toString(),
          percent: exselData[10][i].data));
    }

    location = List.generate(groups.length, (_) => []);

    for (int i = 0; i < location.length; i++) {
      for (int j = 48; j < 61; j++) {
        location[i].add(MyData(
            category: exselData[j][0].data.toString(),
            percent: exselData[j][i + 26].data));
      }
    }

    plan = List.generate(groups.length, (_) => []);

    for (int i = 0; i < plan.length; i++) {
      for (int j = 12; j < 18; j++) {
        plan[i].add(MyData(
            category: exselData[j][0].data.toString(),
            percent: exselData[j][i + 26].data));
      }
    }
  }
}

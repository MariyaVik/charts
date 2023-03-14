class ExcelItem {
  dynamic data;
  int? column;
  int? row;
  ExcelItem({required this.data, required this.column, required this.row});
  @override
  String toString() {
    return 'значение: $data, строка: $row, столбец $column';
  }
}

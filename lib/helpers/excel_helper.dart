import 'package:excel_community/excel_community.dart';
import 'package:flutter/foundation.dart';

class ExcelHelper {
  static List<Map<String, dynamic>> convertFromBytes(Uint8List bytes) {
    var excel = Excel.decodeBytes(bytes);
    var table = excel.tables.keys.first;
    var rows = excel.tables[table]!.rows;

    if (rows.isEmpty) return [];

    // Assume first row is headers
    var headers = rows.first
        .map((cell) => cell?.value?.toString() ?? '')
        .toList();
    var dataRows = rows.skip(1);

    var list = <Map<String, dynamic>>[];
    for (var row in dataRows) {
      var map = <String, dynamic>{};
      for (var i = 0; i < headers.length && i < row.length; i++) {
        // check if row[i]?.value is bool, int, double, String
        final boolValue = bool.tryParse(row[i]?.value.toString() ?? '');
        final intValue = int.tryParse(row[i]?.value.toString() ?? '');
        final doubleValue = double.tryParse(row[i]?.value.toString() ?? '');

        if (boolValue != null) {
          map[headers[i]] = boolValue;
        } else if (intValue != null) {
          map[headers[i]] = intValue;
        } else if (doubleValue != null) {
          map[headers[i]] = doubleValue;
        } else {
          map[headers[i]] = row[i]?.value.toString() ?? '';
        }
      }
      list.add(map);
    }

    return list;
  }

  static List<int> generateExampleFile() {
    var excel = Excel.createExcel();
    var sheet = excel['Sheet1'];

    // Headers
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0)).value =
        TextCellValue('id');
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0)).value =
        TextCellValue('name');
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0)).value =
        TextCellValue('gender');
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0)).value =
        TextCellValue('is_active');

    // Example row
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 1)).value =
        TextCellValue('abc');
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 1)).value =
        TextCellValue('John Doe');
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 1)).value =
        TextCellValue('male');
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 1)).value =
        BoolCellValue(true);

    return excel.encode() ?? [];
  }
}

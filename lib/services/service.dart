import 'package:borsa/classes/series_data_class.dart';
import 'package:borsa/classes/series_json_class.dart';
import 'package:borsa/constants/constants.dart';
import 'package:borsa/models/database.dart';
import 'package:borsa/models/hive.dart';
import 'package:borsa/models/query_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

getWeeklyData(String code) async {
  DateTime dtnow = DateTime.now();
  DateTime dtweekback = DateTime(dtnow.year, dtnow.month, dtnow.day - 7);
  String startDate = '${dtweekback.day}-${dtweekback.month}-${dtweekback.year}';
  String endDate = '${dtnow.day}-${dtnow.month}-${dtnow.year}';
  var u =
      'https://evds2.tcmb.gov.tr/service/evds/series=TP.DK.$code.S.YTL&startDate=$startDate&endDate=$endDate&type=json&key=$apiKey&aggregationTypes=avg&formulas=0&frequency=1';
  print(u);
  var response = await http.get(Uri.parse(u));
  var map = jsonDecode(response.body);
  int totalCount = map['totalCount'];
  List<SeriesData> listdata = List<SeriesData>();
  for (int i = 0; i < totalCount; i++) {
    listdata.add(SeriesData.format(map, code, 'S', i, '0', 'avg', '5'));
  }
  return listdata;
}

getMonthlyData(String code) async {
  DateTime dtnow = DateTime.now();
  DateTime dtmonthback = DateTime(dtnow.year, dtnow.month - 1, dtnow.day);
  String startDate =
      '${dtmonthback.day}-${dtmonthback.month}-${dtmonthback.year}';
  String endDate = '${dtnow.day}-${dtnow.month}-${dtnow.year}';
  var u =
      'https://evds2.tcmb.gov.tr/service/evds/series=TP.DK.$code.S.YTL&startDate=$startDate&endDate=$endDate&type=json&key=$apiKey&aggregationTypes=avg&formulas=0&frequency=3';
  print(u);
  var response = await http.get(Uri.parse(u));
  var map = jsonDecode(response.body);
  int totalCount = map['totalCount'];
  List<SeriesData> listdata = List<SeriesData>();
  for (int i = 0; i < totalCount; i++) {
    listdata.add(SeriesData.format(map, code, 'S', i, '0', 'avg', '5'));
  }

  return listdata;
}

getYearlyData(String code) async {
  DateTime dtnow = DateTime.now();
  DateTime dtyearback = DateTime(dtnow.year - 1, dtnow.month, dtnow.day);
  String startDate = '${dtyearback.day}-${dtyearback.month}-${dtyearback.year}';
  String endDate = '${dtnow.day}-${dtnow.month}-${dtnow.year}';
  var u =
      'https://evds2.tcmb.gov.tr/service/evds/series=TP.DK.$code.S.YTL&startDate=$startDate&endDate=$endDate&type=json&key=$apiKey&aggregationTypes=avg&formulas=0&frequency=5';
  print(u);
  var response = await http.get(Uri.parse(u));
  var map = jsonDecode(response.body);
  int totalCount = map['totalCount'];
  List<SeriesData> listdata = List<SeriesData>();
  for (int i = 0; i < totalCount; i++) {
    listdata.add(SeriesData.format(map, code, 'S', i, '0', 'avg', '5'));
  }
  return listdata;
}

// Guncel kur bilgileri EVDS uzerinden getirilirken haftasonlari icin null deger donduruluyor
// Bu yuzden haftasonlarini cuma gününe ayarlıyorum
Future<SeriesData> getEVDSUpdatedCurrencies(String code) async {
  DateTime dtnow = DateTime.now();
  String endDate;
  if (dtnow.weekday == 6) {
    endDate = '${dtnow.day - 1}-${dtnow.month}-${dtnow.year}';
  }
  if (dtnow.weekday == 7) {
    endDate = '${dtnow.day - 2}-${dtnow.month}-${dtnow.year}';
  } else {
    endDate = '${dtnow.day}-${dtnow.month}-${dtnow.year}';
  }
  var u =
      'https://evds2.tcmb.gov.tr/service/evds/series=TP.DK.$code.S.YTL&startDate=$endDate&endDate=$endDate&type=json&key=$apiKey&aggregationTypes=avg&formulas=0&frequency=1';
  print(u);
  var response = await http.get(Uri.parse(u));
  var map = jsonDecode(response.body);
  SeriesData data = SeriesData.format(map, code, 'S', 0, '0', 'avg', '1');
  return data;
}

getReport(String code, String formula, String aggregationType, String frequency,
    String startDate, String endDate) async {
  var query = buildQuery(code, 'S', 'YTL');
  var url = 'https://evds2.tcmb.gov.tr/service/evds/series=' +
      query +
      '&startDate=$startDate&endDate=$endDate&type=json&key=$apiKey&aggregationTypes=$aggregationType&formulas=$formula&frequency=$frequency';
  var response = await http.get(Uri.parse(url));
  print(url);
  var map = jsonDecode(response.body);
  int totalCount = map['totalCount'];
  List<SeriesData> listdata = List<SeriesData>();
  for (int i = 0; i < totalCount; i++) {
    SeriesData data = SeriesData.format(
        map, code, 'S', i, formula, aggregationType, frequency);
    listdata.add(data);
  }
  SeriesArrayJson seriesArrayJson = SeriesArrayJson(
    list: listdata,
    totalCount: listdata.length,
  );
  String field = buildSQLCodeField(code, 'S', 'YTL', frequency, formula,
      aggregationType, startDate, endDate);
  setSaved(field);
  insertReport(field, seriesArrayJson.toJson());
}

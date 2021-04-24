import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

import 'package:borsa/constants/constants.dart';
import 'package:borsa/models/query_model.dart';

class SeriesData {
  int id;
  String tarih;
  String code;
  String query;
  String unixtime;
  double value;
  bool isNull;
  int formulas;
  String aggregationTypes;
  int frequency;
  SeriesData({
    this.id,
    this.tarih,
    this.code,
    this.query,
    this.unixtime,
    this.value,
    this.isNull,
    this.formulas,
    this.aggregationTypes,
    this.frequency,
  });

  factory SeriesData.format(
      Map<String, dynamic> map,
      String currencyCode,
      String action,
      int i,
      String formula,
      String aggregationType,
      String frequency) {
    String codeField = buildCodeField(currencyCode, 'S', 'YTL');
    if (map['totalCount'] == 0) {
      return SeriesData(
        isNull: true,
      );
    }
    SeriesData data = SeriesData(
      value: map['items'][i][codeField].runtimeType == String
          ? double.parse(map['items'][i][codeField])
          : map['items'][i][codeField],
      code: currencyCode,
      tarih: map['items'][i]['Tarih'],
      unixtime: map['items'][i]['UNIXTIME']['\$numberLong'],
      frequency: int.parse(frequency),
      formulas: int.parse(formula),
      aggregationTypes: aggregationType,
      isNull: false,
    );
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tarih': tarih,
      'code': code,
      'query': query,
      'unixtime': unixtime,
      'value': value,
      'isNull': isNull,
      'formulas': formulas,
      'aggregationTypes': aggregationTypes,
      'frequency': frequency,
    };
  }

  factory SeriesData.fromMap(Map<String, dynamic> map) {
    return SeriesData(
      id: map['id'],
      tarih: map['tarih'],
      code: map['code'],
      query: map['query'],
      unixtime: map['unixtime'],
      value: map['value'],
      isNull: map['isNull'],
      formulas: map['formulas'],
      aggregationTypes: map['aggregationTypes'],
      frequency: map['frequency'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SeriesData.fromJson(String source) =>
      SeriesData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SeriesData(tarih: $tarih, code: $code, query: $query, unixtime: $unixtime, value: $value, isNull: $isNull, formulas: $formulas, aggregationTypes: $aggregationTypes, frequency: $frequency)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SeriesData &&
        other.tarih == tarih &&
        other.code == code &&
        other.query == query &&
        other.unixtime == unixtime &&
        other.value == value &&
        other.isNull == isNull &&
        other.formulas == formulas &&
        other.aggregationTypes == aggregationTypes &&
        other.frequency == frequency;
  }

  @override
  int get hashCode {
    return tarih.hashCode ^
        code.hashCode ^
        query.hashCode ^
        unixtime.hashCode ^
        value.hashCode ^
        isNull.hashCode ^
        formulas.hashCode ^
        aggregationTypes.hashCode ^
        frequency.hashCode;
  }
}

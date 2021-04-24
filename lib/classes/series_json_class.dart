import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:borsa/classes/series_data_class.dart';

class SeriesArrayJson {
  List<SeriesData> list;
  int totalCount;
  SeriesArrayJson({
    this.list,
    this.totalCount,
  });

  SeriesArrayJson copyWith({
    List<SeriesData> list,
    int totalCount,
  }) {
    return SeriesArrayJson(
      list: list ?? this.list,
      totalCount: totalCount ?? this.totalCount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'list': list?.map((x) => x.toMap())?.toList(),
      'totalCount': totalCount,
    };
  }

  factory SeriesArrayJson.fromMap(Map<String, dynamic> map) {
    return SeriesArrayJson(
      list:
          List<SeriesData>.from(map['list']?.map((x) => SeriesData.fromMap(x))),
      totalCount: map['totalCount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SeriesArrayJson.fromJson(String source) =>
      SeriesArrayJson.fromMap(json.decode(source));

  @override
  String toString() => 'SeriesArrayJson(list: $list, totalCount: $totalCount)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SeriesArrayJson &&
        listEquals(other.list, list) &&
        other.totalCount == totalCount;
  }

  @override
  int get hashCode => list.hashCode ^ totalCount.hashCode;
}

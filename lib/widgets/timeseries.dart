import 'package:borsa/classes/series_data_class.dart';

/// Timeseries chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SimpleTimeSeriesChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleTimeSeriesChart(this.seriesList, {this.animate});

  factory SimpleTimeSeriesChart.withSampleData(List<SeriesData> data) {
    return SimpleTimeSeriesChart(
      _createSampleData(data),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      behaviors: [
        charts.PanAndZoomBehavior(),
        charts.SeriesLegend(),
        charts.SlidingViewport(),
      ],
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeries, DateTime>> _createSampleData(
      List<SeriesData> series) {
    List<TimeSeries> timeseries = [];
    series.forEach((element) {
      print(element.unixtime);
      int time = int.parse(element.unixtime);
      print(time);
      DateTime date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
      print(date);
      timeseries.add(TimeSeries(date, element.value));
    });

    return [
      new charts.Series<TimeSeries, DateTime>(
        id: 'Currency',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeries tseries, _) => tseries.time,
        measureFn: (TimeSeries tseries, _) => tseries.val,
        data: timeseries,
      )
    ];
  }
}

/// Sample time series data type.
class TimeSeries {
  final DateTime time;
  final double val;

  TimeSeries(this.time, this.val);
}

import 'package:borsa/classes/series_json_class.dart';
import 'package:borsa/constants/constants.dart';
import 'package:borsa/models/navigator.dart';
import 'package:borsa/widgets/appbar.dart';
import 'package:borsa/widgets/timeseries.dart';
import 'package:flutter/material.dart';

class ReportResult extends StatelessWidget {
  final SeriesArrayJson data;
  final String code;

  const ReportResult({Key key, this.data, this.code}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(context, '${data.list[0].code}/TRY'),
        body: Container(
          padding: EdgeInsets.all(16.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Text(
                  'Grafik üzerinde iki parmak hareketleriyle büyültme ve küçültme işlemi yapabilirsiniz. Ayrıca sağa veya sola sürükleyerek grafik üzerinde gezebilirsiniz.'),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                child: SimpleTimeSeriesChart.withSampleData(data.list),
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    width: 1.0,
                    color: Colors.brown[200],
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      InformationTable(
                        data: '${data.list[0].code}/TRY',
                        field: 'Döviz kuru',
                      ),
                      HorizontalSeperator(),
                      InformationTable(
                        data: data.list[0].tarih,
                        field: 'Başlangıç tarihi',
                      ),
                      HorizontalSeperator(),
                      InformationTable(
                        data: data.list[data.list.length - 1].tarih,
                        field: 'Bitiş tarihi',
                      ),
                      HorizontalSeperator(),
                      InformationTable(
                        data: formulas.keys.firstWhere(
                            (k) =>
                                formulas[k] == data.list[0].formulas.toString(),
                            orElse: () => null),
                        field: 'Formulas',
                      ),
                      HorizontalSeperator(),
                      InformationTable(
                        data: aggregationTypes.keys.firstWhere((element) =>
                            aggregationTypes[element] ==
                            data.list[0].aggregationTypes),
                        field: 'AggregationType',
                      ),
                      HorizontalSeperator(),
                      InformationTable(
                        data: frequency.keys.firstWhere((element) =>
                            frequency[element] ==
                            data.list[0].frequency.toString()),
                        field: 'Frequency',
                      ),
                      ElevatedButton(
                          onPressed: () {
                            pop(context);
                          },
                          child: Text('Kapat'))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InformationTable extends StatelessWidget {
  final String field;
  final String data;

  const InformationTable({Key key, this.field, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$field'),
        Text('$data'),
      ],
    );
  }
}

class HorizontalSeperator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
      child: Container(
        height: 1.0,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
      ),
    );
  }
}

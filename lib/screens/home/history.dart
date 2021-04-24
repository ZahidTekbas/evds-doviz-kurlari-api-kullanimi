import 'package:borsa/classes/series_json_class.dart';
import 'package:borsa/models/database.dart';
import 'package:borsa/models/hive.dart';
import 'package:borsa/models/navigator.dart';
import 'package:borsa/screens/subscreens/report_result.dart';
import 'package:borsa/widgets/appbar.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<String> titlesOfReports;
  @override
  void initState() {
    titlesOfReports = getSaved();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(context, 'Kaydedilenler'),
        body: Container(
          padding: EdgeInsets.all(16.0),
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: buildSavedReportsList(titlesOfReports),
        ),
      ),
    );
  }

  buildSavedReportsList(List<String> list) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 1.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );
      },
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () async {
            SeriesArrayJson data = await readSingleReport(list[index]);
            push(
              context,
              ReportResult(
                data: data,
                code: list[index],
              ),
            );
          },
          child: Container(
            height: 30.0,
            decoration: BoxDecoration(
              color: Colors.blueGrey[200],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('${list[index]}'),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white70,
                  size: 16.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

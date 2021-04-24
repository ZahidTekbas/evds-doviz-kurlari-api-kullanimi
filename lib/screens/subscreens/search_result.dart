import 'package:borsa/classes/series_data_class.dart';
import 'package:borsa/models/navigator.dart';
import 'package:borsa/services/service.dart';
import 'package:borsa/widgets/appbar.dart';
import 'package:borsa/widgets/timeseries.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatefulWidget {
  final String code;

  const SearchResult({Key key, this.code}) : super(key: key);
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  Color activeColor = Colors.grey;
  Color inactiveColor = Colors.grey[300];
  List<Color> colors = [
    Colors.grey,
    Colors.grey[300],
    Colors.grey[300],
  ];
  PageController pageController = PageController();
  List<Widget> charts = [];

  getChartData() async {
    List<SeriesData> weeklyseries = await getWeeklyData(widget.code);
    List<SeriesData> monthlyseries = await getMonthlyData(widget.code);
    List<SeriesData> annualseries = await getYearlyData(widget.code);

    buildCharts(
      weeklyseries,
      monthlyseries,
      annualseries,
    );
  }

  @override
  void initState() {
    getChartData();
    super.initState();
  }

  toggleButtonColor(int pos) {
    for (int i = 0; i < colors.length; i++) {
      if (i == pos) {
        colors[i] = activeColor;
      } else {
        colors[i] = inactiveColor;
      }
    }
    setState(() {});
  }

  buildCharts(
    List<SeriesData> weeklyseries,
    List<SeriesData> monthlyseries,
    List<SeriesData> annualseries,
  ) {
    charts.add(
      SimpleTimeSeriesChart.withSampleData(weeklyseries),
    );
    charts.add(
      SimpleTimeSeriesChart.withSampleData(monthlyseries),
    );
    charts.add(
      SimpleTimeSeriesChart.withSampleData(annualseries),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(context, '${widget.code} için veriler'),
        body: Container(
          padding: EdgeInsets.all(16.0),
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (pageController.page != 0.0) {
                        pageController.jumpToPage(0);
                      }
                      toggleButtonColor(0);
                    },
                    child: TimeIntervalsContainer(
                      text: 'Haftalık',
                      color: colors[0],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (pageController.page != 1.0) {
                        pageController.jumpToPage(1);
                      }
                      toggleButtonColor(1);
                    },
                    child: TimeIntervalsContainer(
                      text: 'Aylık',
                      color: colors[1],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (pageController.page != 2.0) {
                        pageController.jumpToPage(2);
                      }
                      toggleButtonColor(2);
                    },
                    child: TimeIntervalsContainer(
                      text: 'Yıllık',
                      color: colors[2],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                color: Colors.grey,
                child: PageView(
                  controller: pageController,
                  onPageChanged: (int index) {
                    toggleButtonColor(index);
                  },
                  children: charts.isEmpty == true
                      ? [
                          SizedBox(
                              height: 30.0,
                              width: 30.0,
                              child: CircularProgressIndicator()),
                        ]
                      : charts,
                  physics: NeverScrollableScrollPhysics(),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                onPressed: () {
                  pop(context);
                },
                child: Text('Kapat'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimeIntervalsContainer extends StatelessWidget {
  final String text;
  final Color color;

  const TimeIntervalsContainer({Key key, this.text, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      width: MediaQuery.of(context).size.width / 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: color,
      ),
      child: Center(
        child: Text(
          '$text',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}

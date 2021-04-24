import 'package:borsa/models/hive.dart';
import 'package:borsa/widgets/appbar.dart';
import 'package:borsa/widgets/currency_row.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DailyCurrenciesScreen extends StatefulWidget {
  @override
  _DailyCurrenciesScreenState createState() => _DailyCurrenciesScreenState();
}

class _DailyCurrenciesScreenState extends State<DailyCurrenciesScreen> {
  List<String> watchlistcodes;
  @override
  void initState() {
    watchlistcodes = getWatchlist();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(context, 'Günlük Kurlar'),
        body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              watchlistcodes == null
                  ? SizedBox()
                  : Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(color: Colors.grey),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Döviz',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            'Alış',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            'Satış',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
              SizedBox(
                height: 8.0,
              ),
              watchlistcodes == null
                  ? CircularProgressIndicator()
                  : watchlistcodes.isEmpty
                      ? Text(
                          'İzleme listenizde para birimleri bulunamamıştır. İzleme listesine para birimleri ekleyerek güncel döviz kurlarına ulaşabiirsiniz.')
                      : buildCurrencyList(watchlistcodes),
            ],
          ),
        ),
      ),
    );
  }

  buildCurrencyList(List<String> codes) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.blueGrey[800],
        ),
        child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                height: 1.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
              );
            },
            itemCount: codes.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: CurrencyRow(
                  code: codes[index],
                ),
              );
            }),
      ),
    );
  }
}

import 'package:borsa/classes/series_data_class.dart';
import 'package:borsa/constants/constants.dart';
import 'package:borsa/services/service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CurrencyRow extends StatefulWidget {
  final String code;
  final String text;

  const CurrencyRow({Key key, this.code, this.text}) : super(key: key);
  @override
  _CurrencyRowState createState() => _CurrencyRowState();
}

class _CurrencyRowState extends State<CurrencyRow> {
  SeriesData data;
  getCurrency() async {
    data = await getEVDSUpdatedCurrencies(widget.code);
    setState(() {});
  }

  @override
  void initState() {
    getCurrency();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: Text(
              widget.code,
              style: GoogleFonts.roboto(
                color: Colors.teal[300],
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
            ),
          ),
          data == null
              ? Container(child: Text('Yükleniyor...'))
              : data.isNull
                  ? Text('NaN')
                  : Container(
                      child: Text(
                        data.value.toStringAsFixed(2),
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          color: Colors.indigo[300],
                          fontSize: 16.0,
                        ),
                      ),
                    ),
          data == null
              ? Container(child: Text('Yükleniyor...'))
              : data.isNull
                  ? Text('NaN')
                  : Container(
                      child: Text(
                      data.value.toStringAsFixed(2),
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        color: Colors.deepOrange[300],
                        fontSize: 16.0,
                      ),
                    )),
        ],
      ),
    );
  }
}

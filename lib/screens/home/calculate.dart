import 'package:borsa/classes/series_data_class.dart';
import 'package:borsa/constants/constants.dart';
import 'package:borsa/services/service.dart';
import 'package:borsa/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

class CalculateScreen extends StatefulWidget {
  @override
  _CalculateScreenState createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen>
    with TickerProviderStateMixin {
  TextEditingController textController = TextEditingController();
  TextEditingController symbolController = TextEditingController();
  TextEditingController tryController = TextEditingController();
  FocusNode focusNode = FocusNode();
  FocusNode focusNodeTry = FocusNode();
  SeriesData data;
  AnimationController _firstPickerController;
  Animation<double> _firstPickerAnimation;

  getPairValue(String code) async {
    data = await getEVDSUpdatedCurrencies(code);
    print(data.value);
    print(data.code);
  }

  showPickerDialog(BuildContext context) {
    Picker(
        itemExtent: 32.0,
        cancelText: 'İptal',
        confirmText: 'Onayla',
        adapter: PickerDataAdapter<String>(pickerdata: series),
        hideHeader: true,
        title: Text("Birinci pariteyi seçiniz."),
        onCancel: () {
          _firstPickerController.reverse();
        },
        onConfirm: (Picker picker, List value) {
          symbolController.text = picker
              .getSelectedValues()
              .toString()
              .split('[')
              .elementAt(1)
              .split(']')
              .elementAt(0);
          _firstPickerController.reverse();
          getPairValue(symbolController.text);
        }).showDialog(context);
  }

  @override
  void initState() {
    _firstPickerController = AnimationController(
      lowerBound: 0.0,
      upperBound: 0.25,
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _firstPickerAnimation = CurvedAnimation(
      parent: _firstPickerController,
      curve: Curves.bounceInOut,
    );
    getPairValue('USD');
    symbolController.text = 'USD';
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    symbolController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBar(context, 'Döviz Hesapla'),
        body: Container(
          padding: EdgeInsets.all(16.0),
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Text(
                'Farklı para birimlerinin Türk Lirası karşılığını otomatik olarak hesaplayan çevirici. Kurlar günceldir.',
              ),
              SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 50.0,
                      child: TextField(
                        controller: textController,
                        focusNode: focusNode,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        onChanged: (val) async {
                          if (symbolController.text.isNotEmpty &&
                              textController.text.isNotEmpty) {
                            tryController.clear();
                            await getPairValue(symbolController.text);
                            int number = int.parse(textController.text);
                            tryController.text =
                                (number * (data.value)).toStringAsFixed(2);
                          }
                          if (textController.text.isEmpty) {
                            focusNode.unfocus();
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 50.0,
                      child: TextField(
                        controller: symbolController,
                        readOnly: true,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        onTap: () {
                          _firstPickerController.forward();
                          showPickerDialog(context);
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: RotationTransition(
                            turns: _firstPickerController,
                            child: Transform.rotate(
                              angle: 0,
                              child: Icon(Icons.arrow_forward_ios,
                                  color: Colors.black87, size: 16.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.swap_vert),
                ],
              ),
              Container(
                height: 50,
                child: TextField(
                  controller: tryController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  focusNode: focusNodeTry,
                  onChanged: (val) async {
                    if (symbolController.text.isNotEmpty) {
                      textController.clear();
                      await getPairValue(symbolController.text);
                      int number = int.parse(tryController.text);
                      textController.text =
                          (number / (data.value)).toStringAsFixed(2);
                    }
                    if (tryController.text.isEmpty) {
                      focusNodeTry.unfocus();
                    }
                  },
                  decoration: InputDecoration(
                      suffixText: 'TRY',
                      suffixStyle: TextStyle(color: Colors.black)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

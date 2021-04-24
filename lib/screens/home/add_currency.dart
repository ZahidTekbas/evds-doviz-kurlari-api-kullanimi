import 'package:borsa/constants/constants.dart';
import 'package:borsa/models/hive.dart';
import 'package:borsa/models/navigator.dart';
import 'package:borsa/screens/subscreens/search_result.dart';
import 'package:borsa/services/service.dart';
import 'package:borsa/widgets/appbar.dart';
import 'package:borsa/widgets/custom_animation_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:overlay_support/overlay_support.dart';

class AddCurrency extends StatefulWidget {
  @override
  _AddCurrencyState createState() => _AddCurrencyState();
}

class _AddCurrencyState extends State<AddCurrency>
    with SingleTickerProviderStateMixin {
  //FirstWidget
  TextEditingController firstPicker = TextEditingController();
  bool firstPickerTapped = false;

  AnimationController _firstPickerController;
  Animation<double> _firstPickerAnimation;

  //SecondWidget
  TextEditingController firstDateController = TextEditingController();
  TextEditingController secondDateController = TextEditingController();
  TextEditingController secondPicker = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String selectedAggregationType;
  String selectedAggregationName = 'Seçili Değil';
  String selectedFormula;
  String selectedFormulaName = 'Seçili Değil';
  String selectedFrequency;
  String selectedFrequencyName = 'Seçili Değil';
  //Upper State
  Color activeColor = Colors.grey;
  Color inactiveColor = Colors.grey[300];
  List<Color> colors = [
    Colors.grey,
    Colors.grey[300],
  ];
  PageController pageController = PageController();

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
          firstPicker.text = picker
              .getSelectedValues()
              .toString()
              .split('[')
              .elementAt(1)
              .split(']')
              .elementAt(0);
          _firstPickerController.reverse();
        }).showDialog(context);
  }

  Future<void> selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime(2000, 1),
        firstDate: DateTime(1950, 8),
        lastDate: DateTime(2025));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        controller.text =
            "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      });
    } else {
      // Alert dialog gösterilebilir.
    }
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

  disableOtherCheckboxes() {}

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(context, 'Parite Ekle'),
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
                    child: ButtonContainer(
                      text: 'İzleme Listesine Ekle',
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
                    child: ButtonContainer(
                      text: 'Raporlara Ekle',
                      color: colors[1],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 32.0,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 1.5,
                child: PageView(
                  controller: pageController,
                  onPageChanged: (int index) {
                    toggleButtonColor(index);
                  },
                  children: [
                    //First Widget
                    buildFirstWidget(),
                    // Second Widget
                    buildSecondWidget(),
                  ],
                  physics: ScrollPhysics(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildFirstWidget() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.0),
          child: TextField(
            controller: firstPicker,
            readOnly: true,
            decoration: InputDecoration(
              hintText: 'Birim seçmek için tıklayınız',
              suffixIcon: RotationTransition(
                turns: _firstPickerController,
                child: Transform.rotate(
                  angle: 0,
                  child: Icon(Icons.arrow_forward_ios,
                      color: Colors.black87, size: 16.0),
                ),
              ),
            ),
            onTap: () {
              _firstPickerController.forward();
              showPickerDialog(context);
            },
          ),
        ),
        SizedBox(
          height: 16.0,
        ),
        ElevatedButton(
          onPressed: () {
            if (firstPicker.text.isNotEmpty) {
              setWatchlist(firstPicker.text);
              showOverlay((context, t) {
                return CustomAnimationToast(
                    value: t, text: 'Başarıyla Eklendi');
              }, key: ValueKey('hello'), curve: Curves.decelerate);
            }
          },
          child: Text('İzleme Listesine Ekle'),
        ),
      ],
    );
  }

  buildSecondWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: firstPicker,
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Birim seçmek için tıklayınız',
                suffixIcon: RotationTransition(
                  turns: _firstPickerController,
                  child: Transform.rotate(
                    angle: 0,
                    child: Icon(Icons.arrow_forward_ios,
                        color: Colors.black87, size: 16.0),
                  ),
                ),
              ),
              onTap: () {
                _firstPickerController.forward();
                showPickerDialog(context);
              },
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                child: TextField(
                  controller: firstDateController,
                  readOnly: true,
                  onTap: () {
                    selectDate(context, firstDateController);
                  },
                  decoration: InputDecoration(
                    hintText: '20-05-2000',
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                child: TextField(
                  readOnly: true,
                  controller: secondDateController,
                  onTap: () {
                    selectDate(context, secondDateController);
                  },
                  decoration: InputDecoration(
                    hintText: '11-04-2021',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          ExpansionTile(
            title: Text('Aggregation Type: ${selectedAggregationName}'),
            children: [
              Column(
                children: aggregationTypes.entries.map((e) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${e.key}'),
                      Radio(
                        value: e.value,
                        activeColor: Colors.blue,
                        focusColor: Colors.blue,
                        hoverColor: Colors.blue,
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            selectedAggregationType = e.value;
                            selectedAggregationName = e.key;
                          });
                        },
                        groupValue: selectedAggregationType,
                      ),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          ExpansionTile(
            title: Text('Formula Type: ${selectedFormulaName}'),
            children: [
              Column(
                children: formulas.entries.map((e) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${e.key}'),
                      Radio(
                        value: e.value,
                        activeColor: Colors.blue,
                        focusColor: Colors.blue,
                        hoverColor: Colors.blue,
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            selectedFormula = e.value;
                            selectedFormulaName = e.key;
                          });
                        },
                        groupValue: selectedFormula,
                      ),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          ExpansionTile(
            title: Text('Frequency Type: ${selectedFrequencyName}'),
            children: [
              Column(
                children: frequency.entries.map((e) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${e.key}'),
                      Radio(
                        value: e.value,
                        activeColor: Colors.blue,
                        focusColor: Colors.blue,
                        hoverColor: Colors.blue,
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            selectedFrequency = e.value;
                            selectedFrequencyName = e.key;
                          });
                        },
                        groupValue: selectedFrequency,
                      ),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              if (firstPicker.text.isNotEmpty &&
                  selectedAggregationType != null &&
                  selectedFormula != null &&
                  selectedFrequency != null) {
                // rapora kaydedilecek
                getReport(
                  firstPicker.text,
                  selectedFormula,
                  selectedAggregationType,
                  selectedFrequency,
                  firstDateController.text,
                  secondDateController.text,
                );
                showOverlay((context, t) {
                  return CustomAnimationToast(
                      value: t, text: 'Başarıyla Eklendi');
                }, key: ValueKey('hello'), curve: Curves.decelerate);
              }
            },
            child: Text('Raporlara Ekle'),
          ),
        ],
      ),
    );
  }
}

class ButtonContainer extends StatelessWidget {
  final String text;
  final Color color;

  const ButtonContainer({Key key, this.text, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      width: MediaQuery.of(context).size.width / 2.5,
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

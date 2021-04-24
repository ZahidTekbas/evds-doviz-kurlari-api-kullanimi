import 'package:borsa/constants/constants.dart';
import 'package:borsa/models/navigator.dart';
import 'package:borsa/screens/subscreens/search_result.dart';
import 'package:borsa/widgets/appbar.dart';
import 'package:borsa/widgets/custom_animation_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:overlay_support/overlay_support.dart';

class SearchPairScreen extends StatefulWidget {
  @override
  _SearchPairScreenState createState() => _SearchPairScreenState();
}

class _SearchPairScreenState extends State<SearchPairScreen>
    with TickerProviderStateMixin {
  TextEditingController firstPicker = TextEditingController();

  AnimationController _firstPickerController;
  Animation<double> _firstPickerAnimation;

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

  @override
  void initState() {
    super.initState();
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
  }

  @override
  void dispose() {
    firstPicker.dispose();
    _firstPickerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(context, 'Gözat'),
        body: Container(
          padding: EdgeInsets.all(16.0),
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Text(
                  'Aşağıda seçeceğiniz para biriminin belirli periyotlar içerisinde Türk Lirasına karşı gösterdiği performansı görüntüleyebilirsiniz.'),
              SizedBox(height: 16.0),
              Container(
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
                  showOverlay((context, t) {
                    return CustomAnimationToast(value: t, text: 'Başarılı');
                  }, key: ValueKey('hello'), curve: Curves.decelerate);

                  push(
                    context,
                    SearchResult(code: firstPicker.text),
                  );
                },
                child: Text('Görüntüle'),
              ),
              SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'ios_style_toast.dart';

class CustomAnimationToast extends StatelessWidget {
  final double value;

  final String text;

  static final Tween<Offset> tweenOffset =
      Tween<Offset>(begin: Offset(0, 40), end: Offset(0, 0));

  static final Tween<double> tweenOpacity = Tween<double>(begin: 0, end: 1);

  const CustomAnimationToast({Key key, this.value, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: tweenOffset.transform(value),
      child: Opacity(
        child: IosStyleToast(
          text: text,
        ),
        opacity: tweenOpacity.transform(value),
      ),
    );
  }
}

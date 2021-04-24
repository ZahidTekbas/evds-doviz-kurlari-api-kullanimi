import 'package:borsa/screens/home/navbar.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

pop(BuildContext context) {
  Navigator.pop(context);
}

push(BuildContext context, Widget route) {
  Navigator.push(
    context,
    PageTransition(
      duration: Duration(milliseconds: 500),
      type: PageTransitionType.fade,
      alignment: Alignment.center,
      child: route,
    ),
  );
}

popToHome(BuildContext context) {
  Navigator.pushReplacement(
    context,
    PageTransition(
        duration: Duration(milliseconds: 500),
        child: Navbar(),
        type: PageTransitionType.fade),
  );
}

pushReplace(BuildContext context, Widget route) {
  Navigator.pushReplacement(
    context,
    PageTransition(
      duration: Duration(milliseconds: 500),
      child: route,
      type: PageTransitionType.fade,
    ),
  );
}

import 'package:hive/hive.dart';

setWatchlist(String code) {
  var box = Hive.box('watchlistBox');
  box.add(code);
}

getWatchlist() {
  var box = Hive.box('watchlistBox');
  List<String> list = List();
  box.values.forEach((element) {
    list.add(element.toString());
  });
  return list;
}

setSaved(String code) {
  var box = Hive.box('savedBox');
  box.add(code);
}

getSaved() {
  var box = Hive.box('savedBox');
  List<String> list = List();
  box.values.forEach((element) {
    list.add(element.toString());
  });
  return list;
}

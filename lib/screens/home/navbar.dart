import 'package:borsa/screens/home/add_currency.dart';
import 'package:borsa/screens/home/daily_currencies.dart';
import 'package:borsa/screens/home/history.dart';
import 'package:borsa/screens/home/calculate.dart';
import 'package:borsa/screens/home/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  List<Widget> screens = [
    DailyCurrenciesScreen(),
    SearchPairScreen(),
    AddCurrency(),
    CalculateScreen(),
    HistoryScreen(),
  ];

  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedItem],
      bottomNavigationBar: SnakeNavigationBar.color(
        behaviour: SnakeBarBehaviour.pinned,
        snakeShape: SnakeShape.indicator,
        shape: RoundedRectangleBorder(),
        currentIndex: selectedItem,
        onTap: (index) => setState(() => selectedItem = index),
        snakeViewColor: Colors.grey[300],
        selectedItemColor: Color.fromARGB(255, 255, 79, 132),
        unselectedItemColor: Color.fromARGB(255, 236, 243, 255),
        backgroundColor: Color.fromARGB(255, 19, 28, 67),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
          ),
        ],
      ),
    );
  }
}

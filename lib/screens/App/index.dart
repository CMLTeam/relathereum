import "package:flutter/material.dart";
import 'package:flutter_flat_app/screens/Profile/index.dart';

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  AppState createState() => new AppState();
}

class AppState extends State<App> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Center(child: getNavigationContent(_selectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.assessment), title: Text('Prifile')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.euro_symbol), title: Text('Profile')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_pin), title: Text('Profile')),
            ],
            currentIndex: _selectedIndex,
            fixedColor: Color.fromRGBO(255, 0, 0, 1),
            onTap: _changeScreen));
  }

  Widget getNavigationContent(int navigationIndex) {
    Widget widget;
    switch (navigationIndex) {
      case 0:
        widget = new ExampleScreen();
        break;
      case 1:
        widget = new ExampleScreen();
        break;
      case 2:
        widget = new ExampleScreen();
        break;
    }
    return widget;
  }

  void _changeScreen(int index) {
    this.setState(() {
      _selectedIndex = index;
    });
  }
}

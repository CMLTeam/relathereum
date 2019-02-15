import 'package:flutter/material.dart';
import 'package:flutter_flat_app/screens/App/index.dart';
import 'package:flutter_flat_app/screens/Login/LoginScreenState.dart';
import 'package:flutter_flat_app/theme/style.dart';

class Routes {

  //App - single enter point after user is logged in.
  var routes = <String, WidgetBuilder>{
    "/Login": (BuildContext context) => new LoginScreen(),
    "/App" : (BuildContext context) => new App(),
  };

  Routes() {
    runApp(new MaterialApp(
      title: "Some blockchain app",
      home: new LoginScreen(),
      theme: appTheme,
      routes: routes,
    ));
  }
}

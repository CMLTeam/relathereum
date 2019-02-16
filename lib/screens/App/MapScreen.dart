import "package:flutter/material.dart";
import "../../utils/common.dart";

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  AppState createState() => new AppState();
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    Widget screen = Expanded(
        child: Container(
            alignment: Alignment.center, child: CircularProgressIndicator()));

    screen = Container(
        margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
        padding: EdgeInsets.fromLTRB(150, 250, 150, 50),
        color: Colors.white);
    return Scaffold(
        body: Container(
            color: Colors.white,
            child: Column(children: [buildTitle(), screen])),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//        floatingActionButton: Container(
//          height: 50.0,
//          width: 250.0,
//          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
//          child: FittedBox(
//            fit: BoxFit.cover,
//            child: FloatingActionButton(
//              child: Row(children: <Widget>[
//                Icon(Icons.add_box, ),
//                Text("1111", style: TextStyle(color: Colors.white, fontSize: 6),)
//              ],),
//              onPressed: () {},
//              materialTapTargetSize: MaterialTapTargetSize.padded,
//              shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
//            ),
//          ),
//        ))
    );
  }
}

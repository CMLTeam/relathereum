import "package:flutter/material.dart";
import "../../utils/common.dart";

ExactAssetImage qrCodeLogo = new ExactAssetImage("assets/qr-code.png");

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  AppState createState() => new AppState();
}

class AppState extends State<App> {

  _doSthWithQACodeAndRenameThisFunc(){
    print("SCAN TO RELAX!");
    //do sth
  }
  Widget _buildButton() {
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), border: Border.all(color: Colors.blueAccent, width: 2)),
        padding: EdgeInsets.symmetric(vertical: 3),
        margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
        child: Material(
            color: Colors.white,
            child: InkWell(
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.fromLTRB(35, 0, 0, 0),
                        child: new Image(
                          image: qrCodeLogo,
                          width: 50,
                          height: 50,
                        )),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text(
                        "SCAN TO RELAX",
                        style: TextStyle(

                            color: Colors.blueAccent,
                            fontSize: 23,
                            fontWeight: FontWeight.bold ),
                      ),
                    )
                  ],
                ),
                height: 50,
                width: 350,
              ),
              onTap: () {
                _doSthWithQACodeAndRenameThisFunc();
              },
              splashColor: Colors.black38,
              highlightColor: Colors.black38,
            )));
  }

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
        floatingActionButton: _buildButton());
  }
}

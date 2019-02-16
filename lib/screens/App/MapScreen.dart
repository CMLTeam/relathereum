import "package:flutter/material.dart";
import "../../utils/common.dart";
import "../QrCodeScanner/QrCodeScannerScreen.dart";
import "../../components/Buttons/ScanQrButton.dart";

ExactAssetImage qrCodeLogo = new ExactAssetImage("assets/qr-code.png");

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  AppState createState() => new AppState();
}

class AppState extends State<App> {

  launchQrCodeScanner(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>QrCodeScannerScreen()));
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
        floatingActionButton: ScanQrButton(scanQr: launchQrCodeScanner,));
  }
}

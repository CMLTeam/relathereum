import "package:flutter/material.dart";
import "../../utils/common.dart";
import "../QrCodeScanner/QrCodeScannerScreen.dart";
import "../../components/Buttons/ScanQrButton.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';

ExactAssetImage qrCodeLogo = new ExactAssetImage("assets/qr-code.png");

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  AppState createState() => new AppState();
}

class AppState extends State<App> {
  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  _buildMaps(Size screenSize) {
    return Center(
        child: SizedBox(
      width: screenSize.width,
      height: screenSize.height,
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          bearing: 270.0,
          target: LatLng(51.5160895, -0.1294527),
          tilt: 30.0,
          zoom: 12.0,
        ),
      ),
    ));
  }

  launchQrCodeScanner() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => QrCodeScannerScreen()));
  }

  _mapButton() {
    return RaisedButton(
      child: const Text('Go to London'),
      onPressed: mapController == null
          ? null
          : () {
              mapController.animateCamera(CameraUpdate.newCameraPosition(
                const CameraPosition(
                  bearing: 270.0,
                  target: LatLng(51.5160895, -0.1294527),
                  tilt: 30.0,
                  zoom: 17.0,
                ),
              ));
            },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    Widget screen = Expanded(
        child: Container(
            alignment: Alignment.center, child: CircularProgressIndicator()));
    screen = Scaffold(
        body: Container(
            color: Colors.white,
            child: new Stack(children: [
              Positioned(
                  top: 20,
                  child:
                      Column(children: [_buildMaps(screenSize), _mapButton()])),
              Positioned(
                  right: 50,
                  top: 0,
                  child: Center(child: buildTitle()),
                  width: 300,
                  height: 50)
            ])),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ScanQrButton(
          scanQr: launchQrCodeScanner,
        ));

    return screen;
  }
}

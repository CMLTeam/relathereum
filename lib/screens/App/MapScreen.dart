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
    return Container(
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

  // Maybe we can used it for moving to user's position
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

    return Scaffold(
        body: Container(
            color: Colors.white,
            child: addTitleToScreen(_buildMaps(screenSize))),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ScanQrButton(
          scanQr: launchQrCodeScanner,
        ));
  }
}

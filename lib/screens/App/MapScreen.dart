import "package:flutter/material.dart";
import "../../utils/common.dart";
import "../QrCodeScanner/QrCodeScannerScreen.dart";
import "../../components/Buttons/ScanQrButton.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

ExactAssetImage qrCodeLogo = new ExactAssetImage("assets/qr-code.png");
var location = new Location();

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  AppState createState() => new AppState();
}

class AppState extends State<App> {
  GoogleMapController mapController;
  Future mapReady;

  initState() {
    super.initState();
    locateToCurrentCoors();
//    location.onLocationChanged().listen((Map<String, double> currentLocation) {
//      print(
//          "listener: (${currentLocation["latitude"]} | ${currentLocation["longitude"]}");
//      _goToLocation(currentLocation['latitude'], currentLocation['longitude']);
//    });
  }

  void locateToCurrentCoors() async {
    Map<String, double> coors = await location.getLocation();
    _goToLocation(coors['latitude'], coors['longitude']);
  }

  void _onMapCreated(GoogleMapController controller) {
    controller.addMarker(MarkerOptions(
      position: LatLng(51.5160895, -0.1294527),
      icon: BitmapDescriptor.defaultMarker,
    ));
    controller.addMarker(MarkerOptions(
      position: LatLng(51.4815896, -0.1177538),
      icon: BitmapDescriptor.defaultMarker,
    ));
    controller.addMarker(MarkerOptions(
      position: LatLng(51.4815896, -0.1477538),
      icon: BitmapDescriptor.defaultMarker,
    ));
    controller.addMarker(MarkerOptions(
      position: LatLng(51.5315896, -0.1577538),
      icon: BitmapDescriptor.defaultMarker,
    ));
    controller.addMarker(MarkerOptions(
      position: LatLng(51.534896, -0.1077538),
      icon: BitmapDescriptor.defaultMarker,
    ));
    setState(() {
      mapController = controller;
    });
  }

  // Maybe we can used it for moving to user's position
  _goToLocation(double latitude, double longitude) async {
    print(">>> go to loc: $latitude | $longitude");
    latitude = latitude == null ? latitude : 43.53434;
    longitude = longitude == null ? longitude : 46.5334;
    await mapReady;
    return mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            bearing: 270.0,
            target: LatLng(latitude, longitude),
            tilt: 30.0,
            zoom: 17.0)));
  }

  _buildMaps(Size screenSize) {
    return Container(
        child: SizedBox(
      width: screenSize.width,
      height: screenSize.height,
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
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

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery
        .of(context)
        .size;

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

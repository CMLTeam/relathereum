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
  Future await500 = new Future.delayed(const Duration(milliseconds: 1000));

  initState() {
    super.initState();
  }

  Future<List<double>> locateToCurrentCoors() async {
    await await500;
    Map<String, double> coors = await location.getLocation();
    _goToLocation(coors['latitude'], coors['longitude']);
    return [coors['latitude'], coors['longitude']];
  }

  void _onMapCreated(GoogleMapController controller) async {
    var coors = await locateToCurrentCoors();
    //TODO change hardcode to locations in Штутгарт
    controller.addMarker(MarkerOptions(
      position: LatLng(coors[0] + 0.0002, coors[1] - 0.0003),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    ));
    controller.addMarker(MarkerOptions(
      position: LatLng(coors[0] + 0.0022, coors[1] + 0.0125),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    ));
    controller.addMarker(MarkerOptions(
      position: LatLng(coors[0] - 0.0022, coors[1] - 0.0105),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    ));
    controller.addMarker(MarkerOptions(
      position: LatLng(coors[0] - 0.0022, coors[1] + 0.0045),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    ));
    controller.addMarker(MarkerOptions(
      position: LatLng(coors[0] + 0.0052, coors[1] + 0.0055),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    ));
    setState(() {
      mapController = controller;
    });
  }

  // Maybe we can used it for moving to user's position
  _goToLocation(double latitude, double longitude) async {
    print(">>> go to loc: $latitude | $longitude");
    await await500;
    return mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            bearing: 270.0,
            target: LatLng(latitude, longitude),
            tilt: 30.0,
            zoom: 15.0)));
  }

  _buildMaps(Size screenSize) {
    return Container(
        child: SizedBox(
      width: screenSize.width,
      height: screenSize.height-10,
      child: GoogleMap(
        mapType: MapType.terrain,
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

import 'package:barcode_scan/barcode_scan.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import "../../components/Buttons/ScanQrButton.dart";
import "../../utils/AlertModal.dart";
import "../../utils/common.dart";
import '../Unlock/UnlockScreen.dart';

ExactAssetImage qrCodeLogo = new ExactAssetImage("assets/qr-code.png");
var location = new Location();

class MapScreen extends StatefulWidget {
  const MapScreen({Key key}) : super(key: key);

  @override
  MapScreenState createState() => new MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  GoogleMapController mapController;
  Future await500 = new Future.delayed(const Duration(milliseconds: 500));

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
      height: screenSize.height - 10,
      child: GoogleMap(
        mapType: MapType.terrain,
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
          bearing: 270.0,
          target: LatLng(48.78043685, 9.17303474),
          tilt: 30.0,
          zoom: 12.0,
        ),
      ),
    ));
  }

  scan() async {
    try {
      // FIXME: delete after testing
//      Navigator.of(context).push(MaterialPageRoute(builder: (context) => UnlockScreen(capsulaIdNumber: "QR_code",)),);
      // FIXME: uncomment after testing
      String barcode = await BarcodeScanner.scan();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UnlockScreen(capsulaIdNumber: barcode,)));
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        showDialog(
            context: context,
            builder: (context) =>
                AlertModal(
                  header: "PERMISSIN DENIED",
                  message:
                  "Your app cannot have permission to access to camera",
                  type: AlertType.error,
                  pressButton: () => null,
                ));
      } else {
        showDialog(
            context: context,
            builder: (context) =>
                AlertModal(
                  header: "UNKNOWN ERROR",
                  message: "There is some unknown error",
                  type: AlertType.error,
                  pressButton: () => null,
                ));
      }
    } on FormatException {
      print("User didn't scan any QRcode and press back");
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) =>
              AlertModal(
                header: "UNKNOWN ERROR",
                message: "There is some unknown error",
                type: AlertType.error,
                pressButton: () => null,
              ));
    }
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
          scanQr: scan,
        ));
  }
}

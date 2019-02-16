import 'package:barcode_scan/barcode_scan.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import "../../components/Buttons/ScanQrButton.dart";
import "../../utils/AlertModal.dart";
import "../../utils/common.dart";
import '../Unlock/UnlockScreen.dart';

class QrCodeScannerScreen extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<QrCodeScannerScreen> {
  CameraController controller;

  @override
  initState() {
    super.initState();
    controller = CameraController(
        CameraDescription(
            lensDirection: CameraLensDirection.back, name: "0"),
        ResolutionPreset.high);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  Widget buildCameraScreen() {

  }

  @override
  Widget build(BuildContext context) {

    Widget screen = Container();
    if (controller != null && controller.value.isInitialized) {
      screen = Expanded(child: AspectRatio(
        aspectRatio: 1,
        child: CameraPreview(controller),
      ));
    }


    return Scaffold(
        body: Container(
            color: Colors.white,
            child: Column(children: [buildTitle(), screen])),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ScanQrButton(
          scanQr: scan, isTransparent: true,
        ));
  }

  someWidget() => Scaffold(
          body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  splashColor: Colors.blueGrey,
                  onPressed: scan,
                  child: const Text('START CAMERA SCAN')),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                "dsfdsfd",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ));

  scan() async {
    try {

      // FIXME: delete after testing
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => UnlockScreen(capsulaIdNumber: "QR_code",)),
      // FIXME: uncomment after testing
//      String barcode = await BarcodeScanner.scan();
//      Navigator.of(context).push(MaterialPageRoute(builder: (context) => UnlockScreen(capsulaIdNumber: barcode,)),
      );
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        showDialog(
            context: context,
            builder: (context) => AlertModal(
                  header: "PERMISSIN DENIED",
                  message:
                      "Your app cannot have permission to access to camera",
                  type: AlertType.error,
                  pressButton: () => null,
                ));
      } else {
        showDialog(
            context: context,
            builder: (context) => AlertModal(
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
          builder: (context) => AlertModal(
                header: "UNKNOWN ERROR",
                message: "There is some unknown error",
                type: AlertType.error,
                pressButton: () => null,
              ));
    }
  }
}

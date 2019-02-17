import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

ExactAssetImage qrCodeLogo = new ExactAssetImage("assets/qr-code_1.png");



class ScanQrButton extends StatelessWidget {

  final Function scanQr;
  final bool isTransparent;

  const ScanQrButton({Key key, this.scanQr, this.isTransparent = false}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),
            border: Border.all(color: Colors.blueAccent, width: 2),
            color: isTransparent ? Colors.transparent : Colors.white),
        child: Material(
            color: Colors.transparent,
            child: InkWell(
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.fromLTRB(35, 0, 0, 0),
                        child: Tab(icon: Icon(QrCode.qr_code,
                          color: Color.fromRGBO(0, 128, 255, 1),))),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text(
                        "SCAN TO RELAX",
                        style: TextStyle(
                            color: Color.fromRGBO(0, 128, 255, 1),
                            fontSize: 23,
                            fontWeight: FontWeight.bold ),
                      ),
                    )
                  ],
                ),
                height: 50,
                width: 350,
              ),
              onTap: ()=>
                scanQr(),
              splashColor: Colors.black38,
              highlightColor: Colors.black38,
            )));
  }

}

class QrCode {
  QrCode._();

  static const _kFontFam = 'QrCode';

  static const IconData qr_code = const IconData(0xe800, fontFamily: _kFontFam);
}
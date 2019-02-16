import 'package:flutter/material.dart';

ExactAssetImage qrCodeLogo = new ExactAssetImage("assets/qr-code.png");

class ScanQrButton extends StatelessWidget {

  final Function scanQr;

  const ScanQrButton({Key key, this.scanQr}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), border: Border.all(color: Colors.blueAccent, width: 2)),
        padding: EdgeInsets.symmetric(vertical: 3),
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
              onTap: ()=>
                scanQr(),
              splashColor: Colors.black38,
              highlightColor: Colors.black38,
            )));
  }

}
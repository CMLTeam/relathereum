import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

ExactAssetImage qrCodeLogo = new ExactAssetImage("assets/qr-code_1.png");



class RoundedButton extends StatelessWidget {

  final Function press;
  final bool isTransparent;
  final String title;
  final IconData icon;

  const RoundedButton({Key key, this.press, this.isTransparent = false, this.title, this.icon, }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), border: Border.all(color: Colors.blueAccent, width: 2)),
        padding: EdgeInsets.symmetric(vertical: 3),
        child: Material(
            color: isTransparent ? Colors.transparent : Colors.white,
            child: InkWell(
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        child: Tab(icon: Icon(icon, color: Color.fromRGBO(0, 128, 255, 1),))),
                    Container(
                      padding: EdgeInsets.fromLTRB(7, 0, 0, 0),
                      child: Text(
                        title,
                        style: TextStyle(
                            color: Color.fromRGBO(0, 128, 255, 1),
                            fontSize: 18,
                            fontWeight: FontWeight.bold ),
                      ),
                    )
                  ],
                ),
                height: 43,
                width: 157,
              ),
              onTap: ()=>
                press(),
              splashColor: Colors.black38,
              highlightColor: Colors.black38,
            )));
  }

}

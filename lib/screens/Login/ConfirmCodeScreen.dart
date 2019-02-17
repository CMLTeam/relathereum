import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flat_app/components/Buttons/RoundedButton1.dart';
import 'package:flutter_flat_app/components/Buttons/textButton.dart';
import 'package:flutter_flat_app/components/TextFields/inputField.dart';
import 'package:flutter_flat_app/screens/App/MapScreen.dart';
import 'package:flutter_flat_app/theme/style.dart';
import 'package:flutter_flat_app/utils/common.dart';

class ConfirmCodeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ConfirmCodeState();
  }
}

class ConfirmCodeState extends State<ConfirmCodeScreen> {
  BuildContext context;
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  ScrollController scrollController = new ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _code;

  initState() {
    super.initState();
  }

  verifyCode(String phone) {
    return true;
  }

  void _handleSubmitted() {
    final FormState form = formKey.currentState;
    form.save();
    if (verifyCode(_code)) {
      print("Login Successfull. code: $_code");
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MapScreen()));
    } else {
      print("Login or Password is wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    final Size screenSize = MediaQuery.of(context).size;
    return new Scaffold(
        key: _scaffoldKey,
        body: new SingleChildScrollView(
            controller: scrollController,
            child: new Container(
              padding: new EdgeInsets.all(10.0),
              decoration: new BoxDecoration(color: Colors.white),
              child: new Column(
                children: <Widget>[
                  buildTitle(marginTop: 60.0),
                  new Container(
                    height: screenSize.height / 6,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[],
                    ),
                  ),
                  new Container(
                    child: new Column(
                      children: <Widget>[
                        new Form(
                          key: formKey,
                          child: new Column(
                            children: <Widget>[
                              new InputField(
                                  hintText: "Code ",
                                  obscureText: false,
                                  textInputType: TextInputType.text,
                                  textStyle: inputTextStyle,
                                  textFieldColor: textFieldColor,
                                  icon: null,
                                  iconColor: Colors.white,
                                  bottomMargin: 30.0,
                                  onSaved: (String code) {
                                    _code = code;
                                  }),
                              new RoundedButton(
                                buttonName: "Next",
                                onTap: _handleSubmitted,
                                width: 200,
                                height: 40.0,
                                bottomMargin: 10.0,
                                borderWidth: 0.0,
                                buttonColor: primaryColor,
                              ),
                            ],
                          ),
                        ),
                        new Center(
                          child: (new TextButton(
                              buttonName: "Resend code",
                              onPressed: () => {},
                              buttonTextStyle: buttonTextStyle)),
                        ),
                        Container(padding: EdgeInsets.fromLTRB(0, 0, 0, 60))
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flat_app/screens/Login/ConfirmCodeScreen.dart';
import 'package:flutter_flat_app/screens/Profile/index.dart';
import 'package:flutter_flat_app/theme/style.dart';
import 'package:flutter_flat_app/components/TextFields/inputField.dart';
import 'package:flutter_flat_app/components/Buttons/textButton.dart';
import 'package:flutter_flat_app/components/Buttons/roundedButton.dart';
import 'package:flutter_flat_app/utils/common.dart';

DecorationImage backgroundImage = new DecorationImage(
  image: new ExactAssetImage('assets/login-background.jpg'),
  fit: BoxFit.cover,
);

ExactAssetImage loginImage = new ExactAssetImage("assets/login-image.png");

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  LoginScreenState createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  BuildContext context;
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController scrollController = new ScrollController();
  String _phone;

  initState() {
    super.initState();
    initAuth();
  }

  initAuth() async {}

  _onPressed() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ExampleScreen()));
  }

  onPressed(String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  verifyUser(String phone) {
    return true;
    return true;
  }

  void _handleSubmitted() {
    final FormState form = formKey.currentState;
    form.save();
    if (verifyUser(_phone)) {
      print("Login Successfull. phone: $_phone");
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ConfirmCodeScreen()));
    } else {
      showInSnackBar("Login or Password is wrong");
    }
    //}
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
                  Container(
                    child: Image(
                      image: loginImage,
                    ),
                    height: 250,
                  ),
                  new Container(
                    child: new Column(
                      children: <Widget>[
                        new Form(
                          key: formKey,
                          child: new Column(
                            children: <Widget>[
                              new InputField(
                                  hintText: "Phone number",
                                  obscureText: false,
                                  textInputType: TextInputType.text,
                                  textStyle: inputTextStyle,
                                  textFieldColor: textFieldColor,
                                  icon: null,
                                  iconColor: Colors.white,
                                  bottomMargin: 30.0,
                                  onSaved: (String phone) {
                                    _phone = phone;
                                  }),
                              new RoundedButton(
                                buttonName: "NEXT",
                                onTap: _handleSubmitted,
                                width: screenSize.width,
                                height: 60.0,
                                bottomMargin: 10.0,
                                borderWidth: 0.0,
                                buttonColor: primaryColor,
                              ),
                            ],
                          ),
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new TextButton(
                                buttonName: "Need Help?",
                                onPressed: _onPressed,
                                buttonTextStyle: buttonTextStyle)
                          ],
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

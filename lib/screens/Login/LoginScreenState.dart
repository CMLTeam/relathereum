import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flat_app/theme/style.dart';
import 'style.dart';
import 'package:flutter_flat_app/components/TextFields/inputField.dart';
import 'package:flutter_flat_app/components/Buttons/textButton.dart';
import 'package:flutter_flat_app/components/Buttons/roundedButton.dart';

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
  String _email;

  initState() {
    super.initState();
    initAuth();
  }

  initAuth() async {
//    Navigator.pushNamed(context, "/App");
  }

  _onPressed() {
    print("button clicked");
  }

  onPressed(String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  verifyUser(String email) {
    print(">>> Phone : $email");
    return true;
  }

  void _handleSubmitted() {
    final FormState form = formKey.currentState;
    form.save();
    if (verifyUser(_email)) {
      print("Login Successfull");
      Navigator.pushNamed(context, "/App");
    } else {
      showInSnackBar("Login or Password is wrong");
    }
    //}
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    final Size screenSize = MediaQuery.of(context).size;
    //print(context.widget.toString());
    return new Scaffold(
        key: _scaffoldKey,
        body: new SingleChildScrollView(
            controller: scrollController,
            child: new Container(
              padding: new EdgeInsets.all(16.0),
              decoration: new BoxDecoration(image: backgroundImage),
              child: new Column(
                children: <Widget>[
                  new Container(
                    height: screenSize.height / 3,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
//                        new Center(
//                            child: new Image(
//                          image: logo,
//                          width: screenSize.width / 1.5,
//                          //height: screenSize.height / 4 + 20,
//                        ))
                      ],
                    ),
                  ),
                  new Container(
                    height: screenSize.height / 1.5,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
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
                                  bottomMargin: 20.0,
                                  onSaved: (String email) {
                                    _email = email;
                                  }),
                              new RoundedButton(
                                buttonName: "NEXT",
                                onTap: _handleSubmitted,
                                width: screenSize.width,
                                height: 50.0,
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
                        )
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}

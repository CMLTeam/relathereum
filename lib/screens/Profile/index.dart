import "package:flutter/material.dart";


class ExampleScreen extends StatefulWidget {
  const ExampleScreen({Key key}) : super(key: key);

  @override
  ExampleState createState() => new ExampleState();
}

class ExampleState extends State<ExampleScreen> {
  @override
  Widget build(BuildContext context) {
    return  Text('Example Screen. Feel free to adjust.', style: TextStyle(fontSize: 20));
  }
}

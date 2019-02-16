import 'package:flutter/material.dart';

enum AlertType { success, error }

class AlertModal extends StatelessWidget {
  final AlertType type;
  final String header;
  final String message;
  final Function pressButton;

  AlertModal({Key key, this.type, this.header, this.message, this.pressButton});

  Widget _buildHeader(header) => Container(
          child: Text(
        header,
        style: TextStyle(
            fontSize: 20,
            color: type == AlertType.error ? Colors.red : Colors.black),
      ));

  Widget _buildMessage(message) => Container(
      alignment: Alignment.center,
      height: 90,
      padding: EdgeInsets.all(5),
      child: Text(
        message,
        textAlign: TextAlign.center,
      ));

  Widget _buildButton(BuildContext context, Function action) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 100,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: type == AlertType.error ? Colors.red : Colors.blue,
            borderRadius: BorderRadius.circular(5)),
        child: Text(
          "Ok",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      onTap: () async {
        if (pressButton != null) pressButton();
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        child: Column(children: [
          Column(children: [_buildHeader(header), _buildMessage(message)]),
          _buildButton(context, pressButton)
        ]),
        height: 200,
        width: 400,
        padding: EdgeInsets.all(10),
      ),
    );
  }
}

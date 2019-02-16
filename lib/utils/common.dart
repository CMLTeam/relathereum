import "package:flutter/material.dart";

/// Put it as first element in build() method
buildTitle({marginTop : 10}) {
  return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.fromLTRB(0, 70, 0, 0),
      padding: EdgeInsets.only(
        left: 0,
        bottom: 0,
        top: 0
      ),
      child: Text(
        "RELATHERIUM",
        style: TextStyle(
            fontSize: 36  ,
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold
        ),
      ));
}

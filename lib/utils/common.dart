import "package:flutter/material.dart";

/// Put it as first element in build() method
buildTitle({marginTop: 70.0}) {
  return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.fromLTRB(0, marginTop, 0, 0),

      child: Text(
        "RELATHERIUM",
        style: TextStyle(
            fontSize: 36,
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold),
      ));
}

Widget addTitleToScreen(Widget screenContent) {
  return new Stack(children: [
    Container(
        child:
        Column(children: [screenContent])),
    Container(
      alignment: Alignment.topCenter,
      child: Center(child: buildTitle()),
    )
  ]);
}

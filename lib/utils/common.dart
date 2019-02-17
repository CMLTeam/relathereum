import "package:flutter/material.dart";

/// Put it as first element in build() method
buildTitle({marginTop: 70.0}) {
  return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.fromLTRB(0, marginTop, 0, 0),

      child: Text(
        "RELATHEREUM",
        style: TextStyle(
            fontSize: 36,
            color: Color.fromRGBO(0, 128, 255, 1),
            fontWeight: FontWeight.w900, letterSpacing: 0.2),
      ));
}

Widget addTitleToScreen(Widget screenContent) {
  return new Stack(children: [
    Container(
        child:
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [screenContent])),
    Container(
      alignment: Alignment.topCenter,
      child: Center(child: buildTitle()),
    )
  ]);
}

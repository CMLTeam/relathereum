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

//addGivenTitleToScreenContent(Widget screenContent) {
//  return Stack(children: [
//    Positioned(child: screenContent),
//    Positioned(
////        right: 50,
////        top: 60,
//        child: Center(child: buildTitle(marginTop: 0.0)),
////        width: 300,
////        height: 50)
//    )
//  ]);
//}

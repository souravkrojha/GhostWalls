import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Ghost",
          style: TextStyle(
              color: Color(0xffF50057),
              fontFamily: "Caveat",
              fontWeight: FontWeight.w600,
              fontSize: 50),
        ),
        Text(
          "Walls",
          style: TextStyle(
              color: Color(0xff00B0FF),
              fontFamily: "Caveat",
              fontWeight: FontWeight.w600,
              fontSize: 50),
        )
      ],
    );
  }
}

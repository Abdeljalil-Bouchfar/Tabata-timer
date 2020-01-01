import 'package:flutter/material.dart';
import 'package:workout_timer/constant/const.dart';

class Themes extends StatelessWidget {
  final Function onPressed;
  final int index;
  final double radius;

  Themes({this.onPressed, this.index, this.radius});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        borderRadius: BorderRadius.all(
            Radius.circular(60),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(3.0),
          child: CircleAvatar(
            radius: radius,
            backgroundColor: ThemeColor[index],
          ),
        ),
      ),
    );
  }
}

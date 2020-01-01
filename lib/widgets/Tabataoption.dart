import 'package:flutter/material.dart';
import 'package:workout_timer/constant/const.dart';
import 'package:flutter/cupertino.dart';

class Tabataoption extends StatefulWidget {
  final String text;
  final Widget timerPicker;

  Tabataoption({this.text, this.timerPicker});

  @override
  _TabataoptionState createState() => _TabataoptionState();
}

class _TabataoptionState extends State<Tabataoption> {
  Duration worktimer = Duration();

  @override
  Widget build(BuildContext context) {
    //thee card in bottomshet work / rest / cycle
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF233360),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  widget.text,
                  style: KFirstStyle.copyWith(fontSize: 30),
                ),
              ),
              widget.timerPicker,
            ],
          ),
        ),
      ),
    );
  }
}

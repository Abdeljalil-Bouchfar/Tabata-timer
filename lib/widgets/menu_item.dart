import 'package:flutter/material.dart';
import 'package:workout_timer/constant/const.dart';

class MenuItem extends StatelessWidget {
  final Function onpress;
  final String image;
  final String name;

  MenuItem({this.onpress, this.image, this.name});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onpress,
      child: Column(
        children: <Widget>[
          Image(
            image: AssetImage('images/$image'),
            height: 100,
            color: Colors.white, //Color(0xff6CA7D2)
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 18,top: 2),
            child: Text(
              name,
              style: KFirstStyle.copyWith(
                color: Color(0xffff4050),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:workout_timer/constant/const.dart';

class TimelineIsEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            child: Image(
              image: AssetImage('images/calendar.png'),
              color: Colors.red,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 7),
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: 'Time line is',
                    style: KFirstStyle,
                  ),
                  TextSpan(
                    text: ' empty',
                    style: KFirstStyle.copyWith(color: Colors.redAccent),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 0,
            thickness: 1.5,
            color: Colors.white,
            indent: 170,
            endIndent: 111,
          ),
          Divider(
            height: 0,
            thickness: 1.5,
            color: Colors.white,
            indent: 100,
            endIndent: 200,
          ),
          Divider(
            thickness: 1.5,
            color: Colors.white,
            indent: 150,
            endIndent: 150,
          ),
        ],
      ),
    );
  }
}

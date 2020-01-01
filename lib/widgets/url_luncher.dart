import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:workout_timer/constant/const.dart';
_launchURL({String url}) async {
  try {
    await launch(url);
  } catch (e) {}
}

class Url extends StatelessWidget {
  final String url;
  final String text;
  Url({this.text,this.url});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: FlatButton(
        padding: EdgeInsets.only(left : 20),
        onPressed: () {
          _launchURL(url: url);
        },
        child: Text(
          text,
          style: KFirstStyle.copyWith(color: Colors.blueAccent),
        ),
      ),
    );
  }
}
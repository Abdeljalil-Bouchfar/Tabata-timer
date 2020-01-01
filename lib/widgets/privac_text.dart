import 'package:flutter/material.dart';
import 'package:workout_timer/constant/const.dart';

class TextS extends StatelessWidget {

  final String text;
  final bool isTitle;
  TextS({this.text,this.isTitle});
  @override
  Widget build(BuildContext context) {
    Widget title = Padding(
      padding: const EdgeInsets.all(20),
      child: Text(text,style: KFirstStyle.copyWith(color: Colors.red),),
    );
    Widget longText = Text(text,style: KPrivacy,);
    return isTitle? title : longText;
  }
}

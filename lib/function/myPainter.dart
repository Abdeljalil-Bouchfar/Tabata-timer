import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:workout_timer/function/utils.dart';

class MyPainter extends CustomPainter{
  Color lineColor;
  Color sectorcolor;
  Color completeColor;
  double completePercent;
  int duration;
  MyPainter({this.lineColor,this.completeColor,this.completePercent,this.duration,this.sectorcolor});
  @override
  void paint(Canvas canvas, Size size) {
    Paint line = Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15;
    Paint complete = Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7;
    Paint sector = Paint()
      ..color = sectorcolor
      ..strokeCap = StrokeCap.round
      ..style =  PaintingStyle.stroke
      ..strokeWidth = 2;
    Offset center  = Offset(size.width/2, size.height/2);
    double radius  = min(size.width/2,size.height/2);

    var endSectors =
    getSectionsCoordinatesInCircle(center, radius + 20, 150);
    var initSectors =
    getSectionsCoordinatesInCircle(center, radius - 20, 150);

    canvas.drawCircle(
        center,
        radius,
        line
    );



    paintLines(canvas, initSectors, endSectors, sector);

    canvas.drawCircle(
        center,
        radius,
        line
    );



    double arcAngle = 2*pi* (completePercent/duration);
    canvas.drawArc(
        Rect.fromCircle(center: center,radius: radius),
        pi/2,
        arcAngle,
        false,
        complete
    );
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
import 'dart:math';
import 'dart:ui';

List<Offset> getSectionsCoordinatesInCircle(
    Offset center, double radius, int sections) {
  var intervalAngle = (pi * 2) / sections;
  return List<int>.generate(sections, (int index) => index).map((i) {
    var radians = (pi / 2) + (intervalAngle * i);
    return radiansToCoordinates(center, radians, radius);
  }).toList();
}

Offset radiansToCoordinates(Offset center, double radians, double radius) {
  var dx = center.dx + radius * cos(radians);
  var dy = center.dy + radius * sin(radians);
  return Offset(dx, dy);
}

void paintLines(Canvas canvas, List<Offset> inits, List<Offset> ends,
    Paint section) {
  for (var i = 0; i < inits.length; i++) {
    canvas.drawLine(inits[i], ends[i], section);
  }
}

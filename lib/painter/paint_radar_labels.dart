import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PaintRadarLabels extends CustomPainter {
  List<String> labels;
  double r;
  final int n;
  final double magnitude;
  final double miniOutsideRectangle;
  final double initialAngle;
  final Color color;
  PaintRadarLabels(
    this.r,
    this.labels, {
    this.magnitude = 15,
    this.miniOutsideRectangle = 5,
    this.color = Colors.black,
    this.initialAngle = pi / 2,
  }) : this.n = labels.length;

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();

    for (int k = 0; k < labels.length; k++) {
      double alpha = 2 * k * pi / n;
      var textSpan = TextSpan(
        text: labels[k],// + " (2*$kπ/$n)",
        style: TextStyle(color: color),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      var L = textPainter.width;
      var l = textPainter.height;
      print("l: $l, L = $L");
      var distOutRect =
          miniOutsideRectangle + (magnitude / 2) * (1 - cos(4 * alpha));
      if (alpha > 3 * pi / 2) {
//        alpha = alpha - 2 * pi;
      }
      // if alpha is above the middle of the rectangle: (alpha not between [-pi/2 ; pi/2])
      if (alpha > pi / 2 || alpha < -pi / 2) {
        alpha = alpha - pi;
      }
      // Calculate distance inside rectangle (distInRect)
      double distInRect;
      if (alpha.abs() < atan2(L, l)) {
        // if the incidence point is in the width of the text rectangle (L)
        distInRect = l / (2 * cos(alpha));
      } else {
        // The incidence point is in the height of the text rectangle (l)
        distInRect = L / (2 * sin(alpha));
      }
      final rho = r + distOutRect + distInRect;
      final offset = Offset(size.width / 2 + rho * cos(alpha + initialAngle),
          size.height / 2 + rho * sin(alpha + initialAngle));
      canvas.drawRect(Rect.fromCenter(center: offset, height: l, width: L),
          Paint()..color = Colors.black12);
      if (k == 0) {
        canvas.drawCircle(offset, 6, Paint()..color = Colors.blue);
        path.moveTo(offset.dx, offset.dy);
      } else {
        path.lineTo(offset.dx, offset.dy);
      }
      textPainter.paint(canvas, offset + Offset(-L / 2, -l / 2));
    }
    canvas.drawPath(
        path,
        Paint()
          ..color = color.withOpacity(0.5)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return true;
  }
}

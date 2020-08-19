import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PaintRadarBackground extends CustomPainter {
  final int n;
  final Paint painter = Paint()
    ..color = Colors.amber.withOpacity(0.5)
    ..style = PaintingStyle.fill;
  final Paint paintLines = Paint()
    ..color = Colors.black54
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke;
  final Paint paintAxes = Paint()
    ..color = Colors.black54
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke;
  final bool drawLinesInside;
  final List<double> xs, ys;
  final double initialAngle;
  final bool drawAxes;
  final bool drawBackground;
  PaintRadarBackground(this.n,
      {this.initialAngle = pi / 2,
      this.drawLinesInside = false,
      this.drawBackground = true,
      this.drawAxes = false})
      : xs = [1],
        ys = [0] {
    for (var k = 1; k < n; k++) {
      xs.add(1 + cos(2 * k * pi / n - initialAngle));
      ys.add(1 + sin(2 * k * pi / n - initialAngle));
    }
  }
  @override
  void paint(Canvas canvas, Size size) {
    var r = min(size.width, size.height) / 2;
    final o = Offset(r, r);
    Path path = Path();
    for (var k = 0; k < n; k++) {
      if (k == 0) {
        path.moveTo(r * xs[k], r * ys[k]);
      } else {
        path.lineTo(r * xs[k], r * ys[k]);
      }
      var textSpan =
          TextSpan(text: "$k", style: TextStyle(color: Colors.blueGrey));
      var textPainter =
          TextPainter(text: textSpan, textDirection: TextDirection.ltr);
      textPainter.layout();
      textPainter.paint(canvas, Offset(r * xs[k], r * ys[k]));
      if (drawAxes) {
        canvas.drawLine(Offset(r * xs[k], r * ys[k]), o, paintAxes);
      }
    }
    path.close();
    if (drawBackground) canvas.drawPath(path, painter);
    if (drawLinesInside) {
      for (var k = 0; k < n - 1; k++) {
        for (var j = k + 2; j <= n - 1; j++) {
          if (k == 0 && j == n - 1) continue;
          canvas.drawLine(Offset(r * xs[k], r * ys[k]),
              Offset(r * xs[j], r * ys[j]), paintLines);
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return true;
  }
}

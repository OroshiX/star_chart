import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PaintRadarBackground extends CustomPainter {
  final int n;
  final Paint painter = Paint()
    ..color = Colors.amber
    ..style = PaintingStyle.fill;
  final Paint paintLines = Paint()
    ..color = Colors.black54
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke;
  final List<double> xs, ys;
  final double initialAngle;
  PaintRadarBackground(this.n, {this.initialAngle = pi / 2})
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
    Path path = Path();
    path.moveTo(r * xs.first, r * ys.first);
    for (var k = 1; k < n; k++) {
      path.lineTo(r * xs[k], r * ys[k]);
    }
    path.close();
    canvas.drawPath(path, painter);
    for (var k = 0; k < n - 1; k++) {
      for (var j = k + 2; j <= n - 1; j++) {
        if (k == 0 && j == n - 1) continue;
        canvas.drawLine(Offset(r * xs[k], r * ys[k]),
            Offset(r * xs[j], r * ys[j]), paintLines);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return true;
  }
}
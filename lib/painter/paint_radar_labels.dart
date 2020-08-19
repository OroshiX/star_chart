import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PaintRadarLabels extends CustomPainter {
  List<String> labels;
  double r;
  PaintRadarLabels(this.r, this.labels);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    for (int i = 0; i < labels.length; i++) {
      var textSpan =
          TextSpan(text: labels[i], style: TextStyle(color: Colors.black54));
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      final offset = Offset(50, 100);
      textPainter.layout();
      var L = textPainter.width;
      var l = textPainter.height;
      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return true;
  }
}

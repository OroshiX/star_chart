library star_chart;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:star_chart/painter/paint_radar_background.dart';
import 'package:star_chart/painter/paint_radar_labels.dart';

class StarChart extends StatelessWidget {
  final int sides;
  final Iterable<double> _percent;
  final Color labelColor;

  StarChart(
      {Key key,
      this.sides,
      List<double> percent,
      this.labelColor = Colors.black})
      : _percent = ((percent ?? [0.9, 0.6, 0.3])..sort()).reversed,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double sideLength = min(constraints.maxHeight, constraints.maxWidth);
        return Center(
          child: Container(
            color: Colors.red,
            width: sideLength,
            height: sideLength,
            child: Stack(
              children: [
                for (var p in _percent)
                  Center(
                    child: FractionallySizedBox(
                      heightFactor: p,
                      widthFactor: p,
                      alignment: Alignment.center,
                      child: CustomPaint(
                        painter: PaintRadarBackground(sides),
                      ),
                    ),
                  ),
                Center(
                  child: FractionallySizedBox(
                    heightFactor: 1,
                    widthFactor: 1,
                    child: CustomPaint(
                      painter: PaintRadarBackground(sides,
                          drawAxes: true, drawBackground: false),
                    ),
                  ),
                ),
                Center(
                  child: FractionallySizedBox(
                    heightFactor: 1,
                    widthFactor: 1,
                    child: CustomPaint(
                      painter: PaintRadarLabels(
                        sideLength * _percent.first / 2,
                        List.generate(sides, (index) => "No. $index"),
                        color: labelColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

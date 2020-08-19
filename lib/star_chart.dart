library star_chart;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:star_chart/painter/paint_radar_background.dart';
import 'package:star_chart/painter/paint_radar_labels.dart';

class StarChart extends StatelessWidget {
  final int sides;

  const StarChart({Key key, this.sides}) : super(key: key);
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
                Center(
                  child: FractionallySizedBox(
                    heightFactor: 1,
                    widthFactor: 1,
                    child: CustomPaint(
                      painter: PaintRadarLabels(sideLength,
                          List.generate(sides, (index) => "label $index")),
                    ),
                  ),
                ),
                Center(
                  child: FractionallySizedBox(
                    heightFactor: 0.9,
                    widthFactor: 0.9,
                    alignment: Alignment.center,
                    child: CustomPaint(
                      painter: PaintRadarBackground(sides),
                    ),
                  ),
                ),
                Center(
                  child: FractionallySizedBox(
                    heightFactor: 0.6,
                    widthFactor: 0.6,
                    alignment: Alignment.center,
                    child: CustomPaint(
                      painter: PaintRadarBackground(sides),
                    ),
                  ),
                ),
                Center(
                  child: FractionallySizedBox(
                    alignment: Alignment.center,
                    heightFactor: 0.3,
                    widthFactor: 0.3,
                    child: CustomPaint(
                      painter: PaintRadarBackground(sides),
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

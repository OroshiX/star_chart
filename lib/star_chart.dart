library star_chart;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:star_chart/painter/paint_radar_background.dart';
import 'package:star_chart/painter/paint_radar_labels.dart';

class StarChart extends StatelessWidget {
  final int sides;
  final List<double> _percent;
  final Color labelColor;
  final Color backgroundColor;
  final Color starColor;
  final Color axisColor;

  StarChart(
      {Key key,
      this.sides,
      List<double> percent,
      this.labelColor = Colors.black,
      this.backgroundColor = Colors.transparent,
      this.starColor = Colors.black12, this.axisColor = Colors.black87})
      : _percent = ((percent ?? [0.9, 0.6, 0.3])..sort()).reversed.toList(),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double sideLength = min(constraints.maxHeight, constraints.maxWidth);
        return Center(
          child: Container(
            color: backgroundColor,
            width: sideLength,
            height: sideLength,
            child: Stack(
              children: [
                for (var i = 1; i < _percent.length; i++)
                  Center(
                    child: FractionallySizedBox(
                      heightFactor: _percent[i],
                      widthFactor: _percent[i],
                      alignment: Alignment.center,
                      child: CustomPaint(
                        painter: PaintRadarBackground(sides,
                            backgroundColor: starColor),
                      ),
                    ),
                  ),
                Center(
                  child: FractionallySizedBox(
                    heightFactor: _percent.first,
                    widthFactor: _percent.first,
                    child: CustomPaint(
                      painter: PaintRadarBackground(sides,
                          drawAxes: true,
                          axisColor: axisColor,
                          drawBackground: true,
                          backgroundColor: starColor),
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

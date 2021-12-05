import 'package:fish_flutter/Model/SpeedRange.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class FishRangeSliderPainter extends CustomPainter {
  const FishRangeSliderPainter({
    required this.activeColor,
    required this.inactiveColor,
    required this.backRadius,
    required this.maxBackRadius,
    required this.maxSpeed,
    required this.speedRange,
  });
  final Color activeColor;
  final Color inactiveColor;
  final double backRadius;
  final double maxBackRadius;
  final double maxSpeed;
  final List<SpeedRange> speedRange;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.deepOrange;
    var path = Path();

    speedRange.forEach((val) {
      //速度レンジを横描画値に変換する係数を計算
      var prm = size.width / maxSpeed;
      //描画のスタートX
      var leftStart = (val.justSpeed - val.rangeSpeed) * prm;
      if (leftStart <= size.width) {
        leftStart = (leftStart < 0.0) ? 0.0 : leftStart;
        var leftEnd = (val.justSpeed + val.rangeSpeed) * prm;
        leftEnd = (leftEnd > size.width) ? size.width : leftEnd;
        var topStart = 5.0;
        var topEnd = 15.0;

        // 四角（外線）
        path = Path();
        paint = new Paint()
          ..color =
              Colors.yellow.withOpacity(val.hitSpeedProb * val.hitSpeedProb)
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.fill
          ..strokeWidth = 2;
        path = Path();
        path.moveTo(leftStart, topStart);
        path.lineTo(leftStart, topEnd);
        path.lineTo(leftEnd, topEnd);
        path.lineTo(leftEnd, topStart);
        path.close();
        canvas.drawPath(path, paint);
      }
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

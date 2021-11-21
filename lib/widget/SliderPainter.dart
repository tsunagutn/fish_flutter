import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SliderPainter extends CustomPainter {
  const SliderPainter({
    required this.activeColor,
    required this.value,
    required this.backRadius,
    required this.maxBackRadius,
    required this.dragShaKeX,
    required this.dragShaKeY,
  });
  final Color activeColor;
  final double value;
  final double backRadius;
  final double maxBackRadius;
  final int dragShaKeX;
  final int dragShaKeY;

  //後光の設定
  static const Map<int, Map<String, double>> lightLayers = {
    0: {
      'maxOpacity': 0.9, //後光の濃さ
    },
    1: {
      'maxOpacity': 0.7,
    },
    2: {
      'maxOpacity': 0.5,
    },
    3: {
      'maxOpacity': 0.3,
    },
    4: {
      'maxOpacity': 0.1,
    },
  };

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    // paint.color = Colors.greenAccent;
    // var rect = Rect.fromLTWH(0, 0, size.width, 20);
    // canvas.drawRect(rect, paint);

    paint.color = Colors.deepOrange;
    var path = Path();

    var leftStart = 0.0 + dragShaKeX;
    var leftEnd = size.width + dragShaKeX;
    var topStart = 0.0 + dragShaKeY;
    var topEnd = 20.0 + dragShaKeY;

    if (this.activeColor.red > 150) {
      var radius = 0.0;
      //後光配列ループ
      for (var i = 0; i < lightLayers.length; i++) {
        var row = lightLayers[i]!;
        //後光の透明度の算出
        var opacity =
            this.backRadius * (row['maxOpacity']! / maxBackRadius * -1) +
                row['maxOpacity']!;
        //誤差でmax-min外れないように
        opacity = opacity < 0.0 ? 0.0 : opacity;
        opacity = opacity > 1.0 ? 1.0 : opacity;
        //後光サイズ
        radius += backRadius;

        //var radius = this.backRadius * 2;
        //アニメーション部分
        paint = new Paint()
          ..color = this.activeColor.withOpacity(opacity)
          ..colorFilter
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.fill
          ..strokeWidth = 2;

        path.moveTo(leftStart - radius, topStart - radius);
        path.lineTo(leftStart - radius, topEnd + radius);
        path.lineTo(leftEnd + radius, topEnd + radius);
        path.lineTo(leftEnd + radius, topStart - radius);
        path.close();
        canvas.drawPath(path, paint);
      }
    }

    // 四角（外線）
    path = Path();
    paint = new Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    path = Path();
    path.moveTo(leftStart, topStart);
    path.lineTo(leftStart, topEnd);
    path.lineTo(leftEnd, topEnd);
    path.lineTo(leftEnd, topStart);
    path.close();
    canvas.drawPath(path, paint);

    // 四角（塗りつぶし）
    path = Path();
    paint = new Paint()
      ..color = this.activeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    path.moveTo(leftStart, topStart);
    path.lineTo(leftStart, topEnd);
    path.lineTo(leftEnd * this.value, topEnd);
    path.lineTo(leftEnd * this.value, topStart);
    path.close();
    canvas.drawPath(path, paint);

    path = Path();
    paint = new Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;
    //..strokeWidth = 2;
    path.moveTo((leftEnd * this.value), topStart);
    path.lineTo((leftEnd * this.value), topEnd);
    path.lineTo(leftEnd, topEnd);
    path.lineTo(leftEnd, topStart);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

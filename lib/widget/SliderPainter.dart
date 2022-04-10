import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/rendering.dart';

class SliderPainter extends CustomPainter {
  const SliderPainter({
    required this.height,
    required this.activeColor,
    required this.inactiveColor,
    required this.value,
    required this.maxValue,
    required this.backRadius,
    required this.maxBackRadius,
    required this.flgShaKe,
    required this.flgDispValue,
    required this.flgDispMaxValue,
    this.value2 = 0.0,
    this.value2Color = Colors.white,
  });
  final double height;
  final Color activeColor;
  final Color inactiveColor;
  final double value;
  final double maxValue;
  final double backRadius;
  final double maxBackRadius;
  final bool flgShaKe;
  final bool flgDispValue;
  final bool flgDispMaxValue;
  final double value2;
  final Color value2Color;

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
    var dragShaKeX = 0;
    var dragShaKeY = 0;
    if (flgShaKe) {
      //テンションゲージを揺らす
      dragShaKeX = 5 - (new math.Random()).nextInt(9);
      dragShaKeY = 5 - (new math.Random()).nextInt(9);
    }

    double val = (value > maxValue ? maxValue : value) / this.maxValue;
    if (val < 0.0) val = 0.0;
    if (val > 1.0) val = 1.0;

    //値2の判定
    var flgValue2 = false;
    double val2 = val;
    //if (this.value2 > 0.0 && this.value2 > this.value) {
    if (this.value2 > 0.0) {
      flgValue2 = true;
      val2 = (value2 > maxValue ? maxValue : value2) / this.maxValue;
    }

    var paint = Paint();

    // paint.color = Colors.greenAccent;
    // var rect = Rect.fromLTWH(0, 0, size.width, 20);
    // canvas.drawRect(rect, paint);

    paint.color = Colors.deepOrange;
    var path = Path();

    var leftStart = 0.0 + dragShaKeX;
    var leftEnd = size.width + dragShaKeX;
    var topStart = 0.0 + dragShaKeY;
    var topEnd = this.height + dragShaKeY;

    if (this.activeColor.red > 150 && maxBackRadius > 0.0) {
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

    //値範囲の描画
    path = Path();
    paint = new Paint()
      ..color = this.activeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    path.moveTo(leftStart, topStart);
    path.lineTo(leftStart, topEnd);
    path.lineTo(leftEnd * val, topEnd);
    path.lineTo(leftEnd * val, topStart);
    path.close();
    canvas.drawPath(path, paint);

    if (flgValue2) {
      //値２の描画
      path = Path();
      paint = new Paint()
        ..color = this.value2Color
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.fill
        ..strokeWidth = 2;
      path.moveTo(leftStart, topStart);
      path.lineTo(leftStart, topEnd);
      path.lineTo((leftEnd * val2) - 5, topEnd);
      path.lineTo((leftEnd * val2) - 5, topStart);
      path.close();
      canvas.drawPath(path, paint);

      path = Path();
      paint = new Paint()
        ..color = Colors.yellow
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.fill
        ..strokeWidth = 2;
      path.moveTo((leftEnd * val2) - 5, topStart);
      path.lineTo((leftEnd * val2) - 5, topEnd);
      path.lineTo(leftEnd * val2, topEnd);
      path.lineTo(leftEnd * val2, topStart);
      path.close();
      canvas.drawPath(path, paint);
    }

    //値範囲外の描画
    path = Path();
    paint = new Paint()
      ..color = inactiveColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;
    //..strokeWidth = 2;
    path.moveTo((leftEnd * (val > val2 ? val : val2)), topStart);
    path.lineTo((leftEnd * (val > val2 ? val : val2)), topEnd);
    path.lineTo(leftEnd, topEnd);
    path.lineTo(leftEnd, topStart);
    path.close();
    canvas.drawPath(path, paint);

    if (!flgDispValue) {
      //テキスト表示が無い場合はここで終了
      return;
    }
    // 基本のテキストスタイル
    final fontsize = (height > 10.0 ? height : 10.0);
    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: fontsize,
      fontWeight: FontWeight.w900,
      fontStyle: FontStyle.italic,
      // shadows: <Shadow>[
      //   Shadow(offset: Offset(0.0, 0.0), blurRadius: 0.0, color: Colors.yellow)
      // ],
    );
    final textStyleMain = TextStyle(
      color: Colors.blueGrey,
      fontSize: fontsize,
      fontWeight: FontWeight.w100,
      fontStyle: FontStyle.italic,
    );

    //表示テキストの定義
    String text = value.floor().toString();
    if (flgDispMaxValue) {
      text += '/' + maxValue.floor().toString();
    }

    // final textSpan = TextSpan(style: textStyle, children: <TextSpan>[
    //   TextSpan(text: text.substring(0, 3)),
    //   TextSpan(
    //       text: _text.substring(3, 6), style: TextStyle(color: Colors.red)),
    //   TextSpan(
    //       text: _text.substring(6, _text.length),
    //       style: TextStyle(color: Colors.blue)),
    // ]);
    ;
    // テキスト描画用のペインター
    final textPainter = TextPainter(
      text: TextSpan(
          style: textStyle, children: <TextSpan>[TextSpan(text: " " + text)]),
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width - 5,
    );

    // テキストの描画
    textPainter.paint(canvas, Offset(leftStart, topStart));

    // テキスト描画用のペインター
    final textPainterMain = TextPainter(
      text: TextSpan(
          style: textStyleMain,
          children: <TextSpan>[TextSpan(text: " " + text)]),
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    textPainterMain.layout(
      minWidth: 0,
      maxWidth: size.width - 5,
    );

    // テキストの描画
    textPainterMain.paint(canvas, Offset(leftStart, topStart));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

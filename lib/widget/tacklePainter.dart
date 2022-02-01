import 'package:fish_flutter/View/Fishing.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class tacklePainter extends CustomPainter {
  const tacklePainter({
    //required this.activeColor,
    required this.shoreHeight,
    required this.dispSize,
    required this.takclePositionLeft,
    required this.tackleCenterX,
    required this.rodSizeX,
    required this.rodSizeY,
    required this.reelSizeX,
    required this.reelSizeY,
    required this.reelCenterY,
    required this.clutchBackColor,
    required this.clutchTextSize,
    required this.rodStandUp,
    required this.rodTension,
  });
  final double shoreHeight;
  final Size dispSize;
  final bool takclePositionLeft;
  final double tackleCenterX;
  final double rodSizeX;
  final double rodSizeY;
  final double reelSizeX;
  final double reelSizeY;
  final double reelCenterY;
  final Color clutchBackColor;
  final double clutchTextSize;
  final double rodStandUp;
  final double rodTension;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    //var dispSizeHeight = MediaQuery.of(context).size.height;

    paint.color = Colors.deepOrange;
    var path = Path();
    final Shader _linearGradient = LinearGradient(
        begin: FractionalOffset.topCenter,
        end: FractionalOffset.bottomCenter,
        colors: <Color>[
          Color(0xff4C4C4C),
          Color(0xff4C4C4C),
          Color(0xff4C4C4C),
          Color(0xff4C4C4C),
          Color(0xff4C4C4C),
        ],
        stops: [
          0.08,
          0.25,
          0.5,
          0.75,
          1.0
        ]).createShader(
      Rect.fromLTWH(
        tackleCenterX - 10,
        shoreHeight,
        20,
        rodSizeY,
      ),
    );

    path = Path();
    paint = new Paint()
      ..shader = _linearGradient
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    path = Path();

    var position = 1;
    if (!takclePositionLeft) {
      position = -1;
    }
    const sides = 50; //竿描画の分割数
    const magari = 40; //どこまで曲げるか
    const angle = 0.3; //テンションMAX時の傾き
    const maxZurashiXBottom = 10; //竿の太さ

    //竿先端
    List<Offset> rodPath = [];

    rodPath.add(new Offset(tackleCenterX, shoreHeight));
    for (var i = 1; i <= sides; i++) {
      rodPath.add(new Offset(tackleCenterX - (maxZurashiXBottom * (i / sides)),
          shoreHeight + (rodSizeY * (i / sides))));
    }
    for (var i = sides; i > 0; i--) {
      rodPath.add(new Offset(tackleCenterX + (maxZurashiXBottom * (i / sides)),
          shoreHeight + (rodSizeY * (i / sides))));
    }
    rodPath.add(new Offset(tackleCenterX, shoreHeight));

    //テンション分傾け
    rodPath = rodPath
        .map((o) => _rotate(
            o, angle * rodTension * position, tackleCenterX, reelCenterY))
        .toList();

    var cnt = 0;
    List<Offset> rodPath2 = [];
    rodPath.forEach((item) {
      Offset ofset;
      if (cnt == 0 || cnt == rodPath.length - 1) {
        //頂点
        ofset = new Offset(
            item.dx, item.dy + (rodSizeY * rodTension)); //テンション最大なら竿元まで下がる
      } else if (cnt < magari) {
        ofset = new Offset(
            item.dx,
            item.dy +
                ((shoreHeight + rodSizeY) - item.dy) *
                    (rodTension * math.pow((1.0 - (cnt / magari)), 2)));
      } else if (cnt >= rodPath.length - 1 - magari) {
        ofset = new Offset(
            item.dx,
            item.dy +
                ((shoreHeight + rodSizeY) - item.dy) *
                    (rodTension *
                        math.pow(
                            (1.0 - ((rodPath.length - 1) - cnt) / magari), 2)));
      } else {
        ofset = new Offset(item.dx, item.dy);
      }
      rodPath2.add(ofset);
      cnt++;
    });

    path.addPolygon(rodPath2, true);
    path.close();
    canvas.drawPath(path, paint);

    //リール（仮で6角形)
    List<Offset> reelPath = [];
    reelPath.add(
        new Offset(tackleCenterX - (reelSizeX / 2), reelCenterY - reelSizeY));
    reelPath.add(
        new Offset(tackleCenterX - reelSizeX, reelCenterY - (reelSizeY / 2)));
    reelPath.add(
        new Offset(tackleCenterX - reelSizeX, reelCenterY + (reelSizeY / 2)));
    reelPath.add(
        new Offset(tackleCenterX - (reelSizeX / 2), reelCenterY + reelSizeY));
    reelPath
        .add(new Offset(tackleCenterX - (reelSizeX), reelCenterY + reelSizeY));
    reelPath
        .add(new Offset(tackleCenterX + (reelSizeX), reelCenterY + reelSizeY));
    reelPath.add(
        new Offset(tackleCenterX + (reelSizeX / 2), reelCenterY + reelSizeY));
    reelPath.add(
        new Offset(tackleCenterX + reelSizeX, reelCenterY + (reelSizeY / 2)));
    reelPath.add(
        new Offset(tackleCenterX + reelSizeX, reelCenterY - (reelSizeY / 2)));
    reelPath.add(
        new Offset(tackleCenterX + (reelSizeX / 2), reelCenterY - reelSizeY));
    //テンション分傾け
    reelPath = reelPath
        .map((o) => _rotate(
            o, angle * rodTension * position, tackleCenterX, reelCenterY))
        .toList();

    path = Path();
    paint = new Paint()
      ..color = Colors.black.withOpacity(0.6)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    path.addPolygon(reelPath, false);
    path.close();
    canvas.drawPath(path, paint);

    //糸巻部分
    List<Offset> linePath = [];
    linePath.add(new Offset(
        tackleCenterX - (reelSizeX / 2), reelCenterY - reelSizeY / 2));
    linePath.add(new Offset(
        tackleCenterX - (reelSizeX / 2), reelCenterY + reelSizeY / 2));
    linePath.add(new Offset(
        tackleCenterX + (reelSizeX / 2), reelCenterY + reelSizeY / 2));
    linePath.add(new Offset(
        tackleCenterX + (reelSizeX / 2), reelCenterY - reelSizeY / 2));
    //テンション分傾け
    linePath = linePath
        .map((o) => _rotate(
            o, angle * rodTension * position, tackleCenterX, reelCenterY))
        .toList();

    path = Path();
    paint = new Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    path.addPolygon(linePath, false);
    path.close();
    canvas.drawPath(path, paint);

    //クラッチ
    List<Offset> clutchPath = [];
    clutchPath.add(new Offset(
        tackleCenterX - (reelSizeX / 2), reelCenterY + reelSizeY / 2 + 3));
    clutchPath.add(
        new Offset(tackleCenterX - (reelSizeX / 2), reelCenterY + reelSizeY));
    clutchPath.add(
        new Offset(tackleCenterX + (reelSizeX / 2), reelCenterY + reelSizeY));
    clutchPath.add(new Offset(
        tackleCenterX + (reelSizeX / 2), reelCenterY + reelSizeY / 2 + 3));
    //テンション分傾け
    clutchPath = clutchPath
        .map((o) => _rotate(
            o, angle * rodTension * position, tackleCenterX, reelCenterY))
        .toList();
    path = Path();
    paint = new Paint()
      ..color = clutchBackColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    path.addPolygon(clutchPath, false);
    path.close();
    canvas.drawPath(path, paint);

    //クラッチ内のテキスト
    if (clutchTextSize > 0.0) {
      final fontsize = (clutchTextSize);
      final textStyle = TextStyle(
        color: Colors.black,
        fontSize: fontsize,
        fontWeight: FontWeight.w900,
        fontStyle: FontStyle.italic,
        // shadows: <Shadow>[
        //   Shadow(offset: Offset(0.0, 0.0), blurRadius: 0.0, color: Colors.yellow)
        // ],
      );

      //テキスト描画用のペインター
      final textPainter = TextPainter(
        text: TextSpan(
            style: textStyle, children: <TextSpan>[TextSpan(text: 'PUSH!')]),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: reelSizeX / 2,
        maxWidth: reelSizeX,
      );

      // テキストの描画
      textPainter.paint(
          canvas,
          _rotate(
              Offset(tackleCenterX - clutchTextSize - 10,
                  (reelCenterY + reelSizeY / 2 + 3) - clutchTextSize + 20),
              angle * rodTension * position,
              tackleCenterX,
              reelCenterY));
    }
  }

  /// 回転の公式を利用し、指定したラジアンで回転させた場合のOffsetを返す
  /// Q((−)cos−(−)sin+, (−)sin+(−)cos+)
  Offset _rotate(
      Offset old, double radians, double centerWidth, double centerHeight) {
    final dx = (old.dx * math.cos(radians) - centerWidth * math.cos(radians)) -
        (old.dy * math.sin(radians) - centerHeight * math.sin(radians)) +
        centerWidth;
    final dy = (old.dx * math.sin(radians) - centerWidth * math.sin(radians)) +
        (old.dy * math.cos(radians) - centerHeight * math.cos(radians)) +
        centerHeight;
    return Offset(dx, dy);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

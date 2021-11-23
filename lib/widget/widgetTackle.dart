import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class widgetTackle extends CustomPainter {
  const widgetTackle({
    //required this.activeColor,
    required this.shoreHeight,
    required this.dispSize,
    required this.tackleCenterX,
    required this.rodSizeX,
    required this.rodSizeY,
    required this.reelSizeX,
    required this.reelSizeY,
    required this.reelCenterY,
    required this.onClutch,
    required this.rodStandUp,
    required this.rodTension,
  });
  final double shoreHeight;
  final Size dispSize;
  final double tackleCenterX;
  final double rodSizeX;
  final double rodSizeY;
  final double reelSizeX;
  final double reelSizeY;
  final double reelCenterY;
  final bool onClutch;
  final double rodStandUp;
  final double rodTension;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    //var dispSizeHeight = MediaQuery.of(context).size.height;

    paint.color = Colors.deepOrange;
    var path = Path();
    //var tackleCenterX = 80.0;

    // ロッド
    //var rodSizeX = 20.0;
    //var rodSizeY = dispSize.height - shoreHeight;

    final Shader _linearGradient = LinearGradient(
        begin: FractionalOffset.topCenter,
        end: FractionalOffset.bottomCenter,
        colors: <Color>[
          Color(0xffA33F44),
          Color(0xffA33F44),
          Color(0xffA33F44),
          Color(0xffCC2222),
          Color(0xffDD2222),
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
      //..color = Colors.amber
      ..shader = _linearGradient
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    path = Path();

    //描画原点 竿元左側
    // var gentenX = tackleCenterX;
    // var gentenY = shoreHeight + rodSizeY;
    // const sides = 10; //竿を何分割で表示するか
    // const

    // path.moveTo(gentenX, gentenY);

    // for (var i = 1; i < sides; i++) {
    // path.lineTo(gentenX + (rodSizeY / sides), shoreHeight + rodSizeY);
    // }

    path.moveTo(tackleCenterX + 70, shoreHeight + (rodSizeY * rodTension));
    path.lineTo(tackleCenterX + 50 - (rodSizeX / 6),
        shoreHeight + (rodSizeY / 4) + (rodSizeY / 3 * rodTension));
    path.lineTo(tackleCenterX + 30 - (rodSizeX / 3),
        shoreHeight + (rodSizeY / 2) + (rodSizeY / 10 * rodTension));
    path.lineTo(tackleCenterX - 10 - (rodSizeX / 2), shoreHeight + rodSizeY);
    path.lineTo(tackleCenterX - 10 + (rodSizeX / 2), shoreHeight + rodSizeY);
    path.lineTo(tackleCenterX + 30 + (rodSizeX / 3),
        shoreHeight + (rodSizeY / 2) + (rodSizeY / 10 * rodTension));
    path.lineTo(tackleCenterX + 50 + (rodSizeX / 6),
        shoreHeight + (rodSizeY / 4) + (rodSizeY / 3 * rodTension));

    path.close();
    canvas.drawPath(path, paint);

    //リール（仮で6角形)
    // var reelSizeX = 60;
    // var reelSizeY = 60;
    // var reelCenterY = dispSize.height - reelSizeY - 20;

    path = Path();
    paint = new Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    path.moveTo(tackleCenterX - (reelSizeX / 2), reelCenterY - reelSizeY);
    path.lineTo(tackleCenterX - reelSizeX, reelCenterY - (reelSizeY / 2));
    path.lineTo(tackleCenterX - reelSizeX, reelCenterY + (reelSizeY / 2));
    path.lineTo(tackleCenterX - (reelSizeX / 2), reelCenterY + reelSizeY);
    path.lineTo(tackleCenterX + (reelSizeX / 2), reelCenterY + reelSizeY);
    path.lineTo(tackleCenterX + reelSizeX, reelCenterY + (reelSizeY / 2));
    path.lineTo(tackleCenterX + reelSizeX, reelCenterY - (reelSizeY / 2));
    path.lineTo(tackleCenterX + (reelSizeX / 2), reelCenterY - reelSizeY);
    path.close();
    canvas.drawPath(path, paint);

    //糸巻部分
    path = Path();
    paint = new Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    path.moveTo(tackleCenterX - (reelSizeX / 2), reelCenterY - reelSizeY / 2);
    path.lineTo(tackleCenterX - (reelSizeX / 2), reelCenterY + reelSizeY / 2);
    path.lineTo(tackleCenterX + (reelSizeX / 2), reelCenterY + reelSizeY / 2);
    path.lineTo(tackleCenterX + (reelSizeX / 2), reelCenterY - reelSizeY / 2);
    path.close();
    canvas.drawPath(path, paint);

    //クラッチ
    var dragColor;
    if (onClutch) {
      dragColor = Colors.lightBlue;
    } else {
      dragColor = Colors.red;
    }
    path = Path();
    paint = new Paint()
      ..color = dragColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    path.moveTo(
        tackleCenterX - (reelSizeX / 2), reelCenterY + reelSizeY / 2 + 3);
    path.lineTo(tackleCenterX - (reelSizeX / 2), reelCenterY + reelSizeY);
    path.lineTo(tackleCenterX + (reelSizeX / 2), reelCenterY + reelSizeY);
    path.lineTo(
        tackleCenterX + (reelSizeX / 2), reelCenterY + reelSizeY / 2 + 3);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

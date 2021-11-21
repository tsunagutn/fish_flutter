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
    path = Path();
    paint = new Paint()
      ..color = Colors.amber
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    path = Path();
    path.moveTo(tackleCenterX, shoreHeight);
    path.lineTo(tackleCenterX - (rodSizeX / 3), shoreHeight + (rodSizeY / 2));
    path.lineTo(tackleCenterX - (rodSizeX / 2), shoreHeight + rodSizeY);
    path.lineTo(tackleCenterX + (rodSizeX / 2), shoreHeight + rodSizeY);
    path.lineTo(tackleCenterX + (rodSizeX / 3), shoreHeight + (rodSizeY / 2));
    //path.lineTo(tackleCenterX, shoreHeight);
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

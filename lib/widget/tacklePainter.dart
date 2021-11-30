import 'package:flutter/material.dart';

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
      //..color = Colors.amber
      ..shader = _linearGradient
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    path = Path();

    var position = 1;
    if (!takclePositionLeft) {
      position = -1;
    }
    //描画原点 竿元左側
    // var gentenX = tackleCenterX;
    // var gentenY = shoreHeight + rodSizeY;
    const sides = 5; //竿描画の分割数
    const maxZurashiX = 80; //ナナメ表示するための横軸ズラシ
    const maxZurashiXBottom = 10; //竿元の横軸ズラシ

    //竿先端
    // path.moveTo(tackleCenterX + ((maxZurashiX - maxZurashiXBottom) * position),
    //     shoreHeight + (rodSizeY * rodTension)); //テンション最大なら竿元まで下がる

    // for (var i = 1; i <= sides; i++) {
    //   var zurashiX = ((maxZurashiX / sides) * (sides - i)) - maxZurashiXBottom;
    //   var tensionY = rodSizeY * (rodTension * (i / sides));

    //   path.lineTo(
    //       tackleCenterX + (zurashiX) - (rodSizeX / (sides / i)),
    //       //shoreHeight + (rodSizeY / ((maxZurashiX / sides) * i)) + tensionY);
    //       shoreHeight + tensionY);
    // }

    path.moveTo(tackleCenterX + (70 * position) + (30 * position * rodTension),
        shoreHeight + (rodSizeY * rodTension));

    path.lineTo(tackleCenterX + (50 * position) - (rodSizeX / 6),
        shoreHeight + (rodSizeY / 4) + (rodSizeY / 3 * rodTension));
    path.lineTo(tackleCenterX + (30 * position) - (rodSizeX / 3),
        shoreHeight + (rodSizeY / 2) + (rodSizeY / 10 * rodTension));
    path.lineTo(tackleCenterX + (-10 * position) - (rodSizeX / 2),
        shoreHeight + rodSizeY);

    path.lineTo(tackleCenterX + (-10 * position) + (rodSizeX / 2),
        shoreHeight + rodSizeY);
    path.lineTo(tackleCenterX + (30 * position) + (rodSizeX / 3),
        shoreHeight + (rodSizeY / 2) + (rodSizeY / 10 * rodTension));
    path.lineTo(tackleCenterX + (50 * position) + (rodSizeX / 6),
        shoreHeight + (rodSizeY / 4) + (rodSizeY / 3 * rodTension));

    path.close();
    canvas.drawPath(path, paint);

    //リール（仮で6角形)
    // var reelSizeX = 60;
    // var reelSizeY = 60;
    // var reelCenterY = dispSize.height - reelSizeY - 20;

    path = Path();
    paint = new Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    path.moveTo(tackleCenterX - (reelSizeX / 2), reelCenterY - reelSizeY);
    path.lineTo(tackleCenterX - reelSizeX, reelCenterY - (reelSizeY / 2));
    path.lineTo(tackleCenterX - reelSizeX, reelCenterY + (reelSizeY / 2));
    // path.lineTo(tackleCenterX - (reelSizeX / 2), reelCenterY + reelSizeY);
    // path.lineTo(tackleCenterX + (reelSizeX / 2), reelCenterY + reelSizeY);
    path.lineTo(tackleCenterX - (reelSizeX), reelCenterY + reelSizeY);
    path.lineTo(tackleCenterX + (reelSizeX), reelCenterY + reelSizeY);
    path.lineTo(tackleCenterX + reelSizeX, reelCenterY + (reelSizeY / 2));
    path.lineTo(tackleCenterX + reelSizeX, reelCenterY - (reelSizeY / 2));
    path.lineTo(tackleCenterX + (reelSizeX / 2), reelCenterY - reelSizeY);
    path.close();
    canvas.drawPath(path, paint);

    //糸巻部分
    path = Path();
    paint = new Paint()
      ..color = Colors.white.withOpacity(0.3)
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
    path = Path();
    paint = new Paint()
      ..color = clutchBackColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    // path.moveTo(
    //     tackleCenterX - (reelSizeX / 2), reelCenterY + reelSizeY / 2 + 3);
    // path.lineTo(tackleCenterX - (reelSizeX / 2), reelCenterY + reelSizeY);
    // path.lineTo(tackleCenterX + (reelSizeX / 2), reelCenterY + reelSizeY);
    // path.lineTo(
    //     tackleCenterX + (reelSizeX / 2), reelCenterY + reelSizeY / 2 + 3);
    path.moveTo(
        tackleCenterX - (reelSizeX - 10), reelCenterY + reelSizeY / 2 + 3);
    path.lineTo(tackleCenterX - (reelSizeX - 10), reelCenterY + reelSizeY);
    path.lineTo(tackleCenterX + (reelSizeX - 10), reelCenterY + reelSizeY);
    path.lineTo(
        tackleCenterX + (reelSizeX - 10), reelCenterY + reelSizeY / 2 + 3);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

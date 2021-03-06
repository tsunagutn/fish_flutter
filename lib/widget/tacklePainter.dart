import 'package:fish_flutter/View/Fishing.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

class tacklePainter extends CustomPainter {
  const tacklePainter({
    //required this.activeColor,
    required this.shoreHeight,
    required this.dispSize,
    required this.takclePositionRight,
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
    required this.handleRoll,
    required this.reelwheel,
    required this.depth,
  });
  final double shoreHeight;
  final Size dispSize;
  final bool takclePositionRight;
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
  final double handleRoll;
  final ui.Image reelwheel;
  final double depth;

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
    if (takclePositionRight) {
      position = -1;
    }
    const sides = 30; //?????????????????????
    const magari = 20; //????????????????????????
    const angle = 0.3; //???????????????MAX????????????
    const maxZurashiXBottom = 10; //????????????

    //?????????
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

    //????????????????????????
    rodPath = rodPath
        .map((o) => _rotate(
            o, angle * rodTension * position, tackleCenterX, reelCenterY))
        .toList();

    var cnt = 0;
    List<Offset> rodPath2 = [];
    rodPath.forEach((item) {
      Offset ofset;
      if (cnt == 0 || cnt == rodPath.length - 1) {
        //??????
        ofset = new Offset(
            item.dx, item.dy + (rodSizeY * rodTension)); //????????????????????????????????????????????????
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

    //????????????
    List<Offset> linePath = [];
    linePath.add(new Offset(
        tackleCenterX - (reelSizeX / 2), reelCenterY - reelSizeY / 2));
    linePath.add(new Offset(
        tackleCenterX - (reelSizeX / 2), reelCenterY + reelSizeY / 2));
    linePath.add(new Offset(
        tackleCenterX + (reelSizeX / 2), reelCenterY + reelSizeY / 2));
    linePath.add(new Offset(
        tackleCenterX + (reelSizeX / 2), reelCenterY - reelSizeY / 2));

    //???????????????????????????????????????

    //??????????????????6??????)
    List<Offset> reelPath = [];
    reelPath.add(
        new Offset(tackleCenterX - (reelSizeX / 2), reelCenterY - reelSizeY));
    reelPath.add(
        new Offset(tackleCenterX - reelSizeX, reelCenterY - (reelSizeY / 2)));
    reelPath.add(
        new Offset(tackleCenterX - reelSizeX, reelCenterY + (reelSizeY / 2)));
    reelPath.add(
        new Offset(tackleCenterX - (reelSizeX / 2), reelCenterY + reelSizeY));

    //reelPath.add(linePath[1]);

    reelPath.add(new Offset(linePath[1].dx, reelCenterY + reelSizeY));

    reelPath.add(linePath[0]);
    reelPath.add(linePath[3]);
    //reelPath.add(linePath[2]);
    reelPath.add(new Offset(linePath[2].dx, reelCenterY + reelSizeY));
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
    //????????????????????????
    reelPath = reelPath
        .map((o) => _rotate(
            o, angle * rodTension * position, tackleCenterX, reelCenterY))
        .toList();

    //???????????????????????????????????????
    linePath = linePath
        .map((o) => _rotate(
            o, angle * rodTension * position, tackleCenterX, reelCenterY))
        .toList();
    //???????????????????????????
    path = Path();
    paint = new Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    path.addPolygon(linePath, false);
    path.close();
    canvas.drawPath(path, paint);

    //?????????????????????????????????????????????????????? 5m????????????
    double wheelPosi = (depth % 50) / 50 / 2;
    double reelWheelTop = (reelwheel.height * wheelPosi);
    //??????????????????????????????
    canvas.drawImageRect(
      reelwheel,
      //????????????????????????????????????
      Rect.fromLTWH(0, reelWheelTop, reelwheel.width.toDouble(), reelSizeY / 2),
      //?????????????????????
      Rect.fromLTWH(linePath[0].dx, linePath[0].dy,
          linePath[2].dx - linePath[0].dx, linePath[1].dy - linePath[0].dy),
      new Paint(),
    );

    //????????????????????????
    path = Path();
    paint = new Paint()
      ..color = Colors.black.withOpacity(1.0)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    path.addPolygon(reelPath, false);
    path.close();
    canvas.drawPath(path, paint);

    //????????????
    List<Offset> clutchPath = [];
    clutchPath.add(new Offset(
        tackleCenterX - (reelSizeX / 2), reelCenterY + reelSizeY / 2 + 3));
    clutchPath.add(
        new Offset(tackleCenterX - (reelSizeX / 2), reelCenterY + reelSizeY));
    clutchPath.add(
        new Offset(tackleCenterX + (reelSizeX / 2), reelCenterY + reelSizeY));
    clutchPath.add(new Offset(
        tackleCenterX + (reelSizeX / 2), reelCenterY + reelSizeY / 2 + 3));
    //????????????????????????
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

    //????????????????????????????????????
    List<Offset> handleRootPath = [];
    final handleRootSizeX = reelSizeX / 3;
    final handleRootSizeY = reelSizeY / 1.5;
    //???????????????????????????X
    var handleRootPositionX = tackleCenterX + ((reelSizeX + 1) * position);
    //?????????????????????Y
    var handleRootPositionY = reelCenterY - (handleRootSizeY / 2);
    handleRootPath.add(new Offset(handleRootPositionX, handleRootPositionY));
    handleRootPath.add(
        new Offset(handleRootPositionX, handleRootPositionY + handleRootSizeY));
    handleRootPath.add(new Offset(
        handleRootPositionX + handleRootSizeX * position,
        handleRootPositionY + handleRootSizeY));
    handleRootPath.add(new Offset(
        handleRootPositionX + handleRootSizeX * position, handleRootPositionY));
    //????????????????????????
    handleRootPath = handleRootPath
        .map((o) => _rotate(
            o, angle * rodTension * position, tackleCenterX, reelCenterY))
        .toList();
    path = Path();
    paint = new Paint()
      ..color = Colors.black.withOpacity(0.6)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    path.addPolygon(handleRootPath, false);
    path.close();
    canvas.drawPath(path, paint);

    var rool = handleRoll * 2;
    var flgUp = false;
    //?????????????????????????????????????????????????????????
    if (rool < 1.0) {
      //????????????????????????????????????
      rool = math.pow(rool, 2) as double;
    } else {
      //????????????????????????????????????
      flgUp = true;
      rool = math.pow(rool - 1.0, 2) as double;
      rool = 1.0 - rool;
    }
    var roolY = (reelSizeY * 2 * rool) - reelSizeY / 3;
    //??????????????????????????????
    var sizeKesu = rool / 0.5;
    if (sizeKesu > 1.0) {
      sizeKesu = 2.0 - sizeKesu;
    }
    var handleZoomX = 7 * sizeKesu;
    if (flgUp) handleZoomX = handleZoomX * -1;
    var handleZoomY = handleZoomX * (2 / 1.5);
    if (!takclePositionRight) {
      handleZoomX = handleZoomX * -1;
      //handleZoomY = handleZoomY * -1;
    }

    debugPrint(handleZoomX.toString() + " " + handleZoomY.toString());

    //??????????????????????????????
    List<Offset> handlePath = [];
    final handleMargin = 16.0;
    final handleSizeX = reelSizeX / 2;
    final handleSizeY = reelSizeY / 1.5;

    //?????????????????????X
    var handlePositionX = tackleCenterX +
        ((reelSizeX + handleRootSizeX + handleMargin) * position);
    //?????????????????????Y
    var handlePositionY = reelCenterY - reelSizeY + roolY;

    handlePath.add(new Offset(handlePositionX - handleZoomX, handlePositionY + handleZoomY));
    handlePath.add(new Offset(handlePositionX - handleZoomX, handlePositionY + handleSizeY - handleZoomY));
    handlePath.add(new Offset((handlePositionX + handleSizeX * position) + handleZoomX,
        handlePositionY + handleSizeY - handleZoomY));
    handlePath.add(
        new Offset((handlePositionX + handleSizeX * position) + handleZoomX, handlePositionY + handleZoomY));
    //????????????????????????
    handlePath = handlePath
        .map((o) => _rotate(
            o, angle * rodTension * position, tackleCenterX, reelCenterY))
        .toList();

    path = Path();
    paint = new Paint()
      ..color = Colors.black.withOpacity(0.6)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    path.addPolygon(handlePath, false);
    path.close();
    canvas.drawPath(path, paint);

    // paint = new Paint()
    //   ..color = Colors.black
    //   ..strokeCap = StrokeCap.round
    //   ..style = PaintingStyle.fill
    //   ..strokeWidth = 2;
    // //canvas.rotate(rool);
    // //canvas.translate(dx, dy)
    // canvas.rotate(5 * math.pi / 180);
    // canvas.drawRRect(
    //   RRect.fromLTRBR(
    //     handlePositionX,
    //     handlePositionY,
    //     handlePositionX + handleSizeX * position,
    //     handlePositionY + handleSizeY,
    //     Radius.circular(10),
    //   ),
    //   paint,
    // );

    //????????????????????????????????????
    List<Offset> handleJointPath = [];
    final handleJointSizeY = 4; //???????????????
    //???????????????????????????X
    var handleJointPositionX =
        handleRootPositionX + (handleRootSizeX * position);
    var handleJointPositionY = reelCenterY - handleJointSizeY;
    handleJointPath.add(new Offset(handleJointPositionX, handleJointPositionY));

    // handleJointPositionX += ((handleMargin / 2) - handleJointSizeY) * position;
    // handleJointPath.add(new Offset(handleJointPositionX, handleJointPositionY));

    handleJointPositionY = handlePositionY + (handleSizeY / 2);
    handleJointPath.add(new Offset(handleJointPositionX, handleJointPositionY));

    handleJointPositionX += (handleMargin + handleJointSizeY) * position;
    handleJointPath.add(new Offset(handleJointPositionX, handleJointPositionY));

    handleJointPositionY += handleJointSizeY;
    handleJointPath.add(new Offset(handleJointPositionX, handleJointPositionY));

    handleJointPositionX -= (handleMargin - handleJointSizeY) * position;
    handleJointPath.add(new Offset(handleJointPositionX, handleJointPositionY));

    handleJointPositionY = reelCenterY - handleJointSizeY + handleJointSizeY;
    handleJointPath.add(new Offset(handleJointPositionX, handleJointPositionY));

    handleJointPositionX = handleRootPositionX + (handleRootSizeX * position);
    handleJointPath.add(new Offset(handleJointPositionX, handleJointPositionY));

    //????????????????????????
    handleJointPath = handleJointPath
        .map((o) => _rotate(
            o, angle * rodTension * position, tackleCenterX, reelCenterY))
        .toList();

    path = Path();
    paint = new Paint()
      ..color = Colors.black.withOpacity(0.6)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    path.addPolygon(handleJointPath, false);

    path.close();
    canvas.drawPath(
      path,
      paint,
    );

    //??????????????????????????????
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

      //???????????????????????????????????????
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

      // ?????????????????????
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

  /// ?????????????????????????????????????????????????????????????????????????????????Offset?????????
  /// Q((???)cos???(???)sin+, (???)sin+(???)cos+)
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

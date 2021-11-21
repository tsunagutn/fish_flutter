import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'dart:math' as math;

class FishPointer extends StatefulWidget {
  const FishPointer({
    Key? key,
    required this.dispsizeX,
    required this.offsetY,
    required this.duration,
    required this.fishsize,
    required this.takclePositionLeft,
  }) : super(key: key);
  final double dispsizeX;
  final double offsetY;
  final Duration duration;
  final int fishsize;
  final bool takclePositionLeft;
  @override
  _FishPointerState createState() => _FishPointerState();
}

class _FishPointerState extends State<FishPointer>
    with SingleTickerProviderStateMixin {
  // これを忘れずに

  @override
  Widget build(BuildContext context) {
    var rnd = (new math.Random()).nextDouble();
    var offsetX = (widget.dispsizeX / 4) +
        (widget.dispsizeX / 2) * (rnd * rnd); //真ん中に集約するように累乗する
    if (widget.takclePositionLeft) {
      offsetX += widget.dispsizeX / 4;
    } else {
      offsetX -= widget.dispsizeX / 4;
    }
    offsetX = (offsetX < 0) ? 0 : offsetX;
    offsetX = (offsetX > widget.dispsizeX) ? widget.dispsizeX : offsetX;

    return CustomPaint(
      painter: FishPainter(
          controller: controller,
          offsetX: offsetX,
          offsetY: widget.offsetY,
          fishsize: widget.fishsize),
    );
  }

  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    // SingleTickerProviderStateMixin を使うことで, vsync に this で渡せる。
    // これによりアニメーションの変化に合わせて画面が再描画されていく。
    controller = AnimationController(vsync: this, duration: widget.duration);
    controller.forward(); // アニメーションをスタート
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class FishPainter extends CustomPainter {
  FishPainter(
      {required this.controller,
      required this.offsetX,
      required this.offsetY,
      required this.fishsize})
      : super(repaint: controller); // repaint に controller を渡さないと再描画されない
  final double offsetX;
  final double offsetY;
  final Animation<double> controller;

  final fishsize; //サカナ大きさ？？？可変にするべき

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    // final ByteData data = await rootBundle.load('assets/images/fish.png');
    // uiimage = await loadImage(new Uint8List.view(data.buffer));

    /// Tween<T>(begin: ,end: ) // はじめとおわりの値を指定できる
    /// CurveTween(curve: ) // Curves. でアニメーションカーブを指定できる
    final opacityValue = Tween<double>(begin: 1, end: 0)
        .animate(controller.drive(CurveTween(curve: Curves.easeInOut)))
        .value;

    //Image.asset('assets/images/fish.png')
//var ui.Image uiimage = uiimage.toByteData();

    //if (uiimage != null) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2
      ..color = Colors.white.withOpacity(opacityValue);
    //canvas.drawImage(uiimage, Offset(200, offset_y), paint);
    //canvas.drawCircle(Offset(200, offset_y), 10, paint);
    canvas.drawArc(
        Offset(offsetX, offsetY) & Size(fishsize, fishsize),
        210 * math.pi / 180, //startAngle
        140 * math.pi / 180, //sweepAngle
        false, //中心からの切り出し？trueならピザ形状
        paint);
    canvas.drawArc(
        Offset(offsetX, offsetY - (fishsize * 0.5834)) &
            Size(fishsize, fishsize),
        10 * math.pi / 180, //startAngle
        140 * math.pi / 180, //sweepAngle
        false, //中心からの切り出し？trueならピザ形状
        paint);

    //}
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

import 'dart:async';
import 'dart:html';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class FishPointer extends StatefulWidget {
  FishPointer({
    Key? key,
    required this.dispSizeX,
    required this.offsetX,
    required this.offsetY,
    required this.duration,
    required this.fishPointerSize,
    required this.takclePositionLeft,
    required this.painterKey,
    required this.randMove,
  }) : super(key: key);
  final double dispSizeX;
  final double offsetX;
  final double offsetY;
  final Duration duration;
  final double fishPointerSize;
  final bool takclePositionLeft;
  final GlobalKey painterKey;
  final double randMove;

  @override
  _FishPointerState createState() => _FishPointerState();
}

class _FishPointerState extends State<FishPointer>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      key: widget.painterKey,
      painter: FishPainter(
          controller: controller,
          offsetX: widget.offsetX,
          offsetY: widget.offsetY,
          dispSizeX: widget.dispSizeX,
          fishPointerSize: widget.fishPointerSize,
          randMove: widget.randMove),
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
  FishPainter({
    required this.controller,
    required this.offsetX,
    required this.offsetY,
    required this.dispSizeX,
    required this.fishPointerSize,
    required this.randMove,
  }) : super(repaint: controller); // repaint に controller を渡さないと再描画されない
  final double offsetX;
  final double offsetY;
  final double dispSizeX;
  final Animation<double> controller;
  final double randMove;

  final fishPointerSize; //サカナ大きさ？？？可変にするべき

  double addX = 0.0; //船の動きに合わせて横動き

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    // final ByteData data = await rootBundle.load('assets/images/fish.png');
    // uiimage = await loadImage(new Uint8List.view(data.buffer));
    if (offsetX + addX < 0.0 || offsetX + addX > dispSizeX) {
      //画面範囲から外れている場合は描画しない
    } else {
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
          Offset(offsetX + addX, offsetY) &
              Size(fishPointerSize, fishPointerSize),
          210 * math.pi / 180, //startAngle
          140 * math.pi / 180, //sweepAngle
          false, //中心からの切り出し？trueならピザ形状
          paint);
      canvas.drawArc(
          Offset(offsetX + addX, offsetY - (fishPointerSize * 0.5834)) &
              Size(fishPointerSize, fishPointerSize),
          10 * math.pi / 180, //startAngle
          140 * math.pi / 180, //sweepAngle
          false, //中心からの切り出し？trueならピザ形状
          paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

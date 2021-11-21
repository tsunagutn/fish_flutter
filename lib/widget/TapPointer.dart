import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TapPointer extends StatefulWidget {
  const TapPointer({Key? key, required this.offset, required this.duration})
      : super(key: key);
  final Offset offset;
  final Duration duration;
  @override
  _TapPointerState createState() => _TapPointerState();
}

class _TapPointerState extends State<TapPointer>
    with SingleTickerProviderStateMixin {
  // これを忘れずに

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TapPainter(controller: controller, offset: widget.offset),
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

class TapPainter extends CustomPainter {
  TapPainter({required this.controller, required this.offset})
      : super(repaint: controller); // repaint に controller を渡さないと再描画されない
  final Offset offset;
  final Animation<double> controller;

  @override
  void paint(Canvas canvas, Size size) {
    final Map<int, Map<String, double>> lightLayers = {
      0: {
        'maxOpacity': 0.7, //後光の濃さ
      },
      1: {
        'maxOpacity': 0.5,
      },
      2: {
        'maxOpacity': 0.3,
      },
      3: {
        'maxOpacity': 0.2,
      },
      4: {
        'maxOpacity': 0.1,
      },
    };
    final Color _lightColor = Colors.cyan; //光点の色
    final basicRadius = 6.0; //基本円のサイズ
    final maxBackRadius = 10.0; //基本円のサイズ
    /// Tween<T>(begin: ,end: ) // はじめとおわりの値を指定できる
    /// CurveTween(curve: ) // Curves. でアニメーションカーブを指定できる
    final animateRadius = Tween<double>(begin: 0, end: maxBackRadius)
        .animate(controller.drive(CurveTween(curve: Curves.linear)))
        .value;
    final widthValue = Tween<double>(begin: 3, end: 0)
        .animate(controller.drive(CurveTween(curve: Curves.easeInOut)))
        .value;
    // final opacityValue = Tween<double>(begin: 1, end: 0)
    //     .animate(controller.drive(CurveTween(curve: Curves.easeInOut)))
    //     .value;

    // final paint = Paint()
    //   ..style = PaintingStyle.stroke
    //   ..color = Colors.cyan.withOpacity(opacityValue)
    //   ..strokeWidth = widthValue;
    // canvas.drawCircle(offset, circleValue, paint);

    var size = basicRadius;

    //後光配列ループ
    for (var i = 0; i < lightLayers.length; i++) {
      var row = lightLayers[i]!;
      //後光の透明度の算出
      var opacity = animateRadius * (row['maxOpacity']! / maxBackRadius * -1) +
          row['maxOpacity']!;
      //誤差でmax-min外れないように
      opacity = opacity < 0.0 ? 0.0 : opacity;
      opacity = opacity > 1.0 ? 1.0 : opacity;
      //後光サイズ
      size += animateRadius;
      //後光描画
      canvas.drawCircle(
        offset,
        size,
        Paint()
          ..style = PaintingStyle.stroke //塗り潰さないの円
          ..strokeWidth = widthValue
          ..color = _lightColor.withOpacity(opacity),
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

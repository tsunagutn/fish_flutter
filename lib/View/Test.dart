import 'package:flutter/material.dart';
import 'package:fish_flutter/Model/SettingsModel.dart';
import 'package:fish_flutter/View/DrawerItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'dart:math' as math;

class Test extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Test();
  }
}

class _Test extends State<Test> with SingleTickerProviderStateMixin {
  late Animation<double> _animationValue;
  late AnimationController _animationController;
  late Animation<double> _animationTop;

  var _nowTop = 10.0; //移動先
  var _nextTop = 10.0; //移動先

  @override
  void initState() {
    _animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _animationValue =
        Tween(begin: 10.0, end: 100.0).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CustomPaint Test'),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        //画面タップ時
        onPanDown: (DragDownDetails details) {
          _nowTop = _nextTop;
          _nextTop = details.localPosition.dy; //Y座標
        },

        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              child: ElevatedButton(
                child: Text('Start/Stop'),
                onPressed: () {
                  if (_animationController.isAnimating) {
                    _animationController.reset();
                  } else {
                    _animationController.repeat();
                  }
                },
              ),
            ),
            Opacity(
              opacity: _animationController.isAnimating ? 1.0 : 0.00,
              child: CustomPaint(
                painter: _CirclePainter(_animationValue.value, 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CirclePainter extends CustomPainter {
  double radius;
  double locax;

  _CirclePainter(this.radius, this.locax);

  @override
  void paint(Canvas canvas, Size size) {
    var c = Offset(0, locax);
    var circlepaint = Paint()
      ..isAntiAlias = true
      ..color = Colors.blue
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(
      c,
      radius,
      circlepaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    //再描画が必要（状態が変わる）
    return true;
  }
}

class ShakeCurve extends Curve {
  @override
  double transform(double t) {
    return 64 * math.sin(2 * math.pi * t);
  }
}

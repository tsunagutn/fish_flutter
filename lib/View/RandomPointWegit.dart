import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RandomPointWegit extends StatefulWidget {
  RandomPointWegit({Key? key}) : super(key: key);

  @override
  _RandomPointWegit createState() => _RandomPointWegit();
}

class _RandomPointWegit extends State<RandomPointWegit>
    with TickerProviderStateMixin {
  final _radius = 10.0; //基本光点のサイズ
  final _backRadius = 20.0; //後光のサイズ
  late AnimationController _animationController;
  late Animation<double> _animationRadius;

  @override
  void initState() {
    //
    ligntSpotAnimation(1500);
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: EdgeInsets.all(200),
            child: Column(
              children: <Widget>[
                Row(children: <Widget>[
                  ElevatedButton(
                      child: const Text('早く点滅'),
                      onPressed: () {
                        ligntSpotAnimation(300);
                      }),
                  ElevatedButton(
                      child: const Text('遅く点滅'),
                      onPressed: () {
                        ligntSpotAnimation(1500);
                      }),
                ]),
                Container(
                    margin: EdgeInsets.only(top: 100),
                    child: CustomPaint(
                      painter: _CirclePainter(
                        _radius,
                        _backRadius,
                        _animationRadius.value,
                      ),
                    )),
              ],
            )));
  }

  void ligntSpotAnimation(int duration_msec) {
    //アニメーションの定義
    _animationController = AnimationController(
        duration: Duration(milliseconds: duration_msec), vsync: this);
    _animationRadius =
        Tween(begin: 0.0, end: _backRadius).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
    _animationController.repeat(reverse: false);
  }
}

//美しい光点クラス
class _CirclePainter extends CustomPainter {
  final lightColor = Colors.yellow; //光点の色
  //後光の設定
  final Map<int, Map<String, double>> lightLayers = {
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

  double _basicRadius; //光点の基本サイズ
  double _maxBackRadius; //後光の最大サイズ
  double _animationRadius; //後光アニメーションサイズ

  _CirclePainter(this._basicRadius, this._maxBackRadius, this._animationRadius);

  @override
  void paint(Canvas canvas, Size size) {
    var c = Offset(0, 0); //光点の表示位置x,y
    //光点の実体を配置
    canvas.drawCircle(
      c,
      _basicRadius,
      Paint()
        ..color = lightColor
        ..style = PaintingStyle.fill, //塗り潰しの円
    );

    var size = _basicRadius;

    //後光配列ループ
    for (var i = 0; i < lightLayers.length; i++) {
      var row = lightLayers[i]!;
      //後光の透明度の算出
      var opacity =
          _animationRadius * (row['maxOpacity']! / _maxBackRadius * -1) +
              row['maxOpacity']!;
      //誤差でmax-min外れないように
      opacity = opacity < 0.0 ? 0.0 : opacity;
      opacity = opacity > 1.0 ? 1.0 : opacity;
      //後光サイズ
      size += _animationRadius;
      //後光描画
      canvas.drawCircle(
        c,
        size,
        Paint()
          ..style = PaintingStyle.fill //塗り潰しの円
          ..color = lightColor.withOpacity(opacity),
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

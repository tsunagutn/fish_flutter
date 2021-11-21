import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

//美しい光点クラス
class LightSpot extends CustomPainter {
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

  late double _basicRadius; //光点の基本サイズ
  late double _maxBackRadius; //後光の最大サイズ
  late double _animationRadius; //後光アニメーションサイズ
  late Color _lightColor; //光点の色
  late double _offset_x;
  late double _offset_y;

  LightSpot(this._basicRadius, this._maxBackRadius, this._animationRadius,
      this._lightColor, this._offset_x, this._offset_y);

  @override
  void paint(Canvas canvas, Size size) {
    var c = Offset(_offset_x, _offset_y); //光点の表示位置x,y
    //光点の実体を配置
    canvas.drawCircle(
      c,
      _basicRadius,
      Paint()
        ..color = _lightColor
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
          ..color = _lightColor.withOpacity(opacity),
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

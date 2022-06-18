import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

//美しい光点クラス
class LightSpot extends CustomPainter {
  @override
  const LightSpot({
    required this.basicRadius,
    required this.maxBackRadius,
    required this.animationRadius,
    required this.lightColor,
    required this.offsetX,
    required this.offsetY,
    required this.diffOffsetY,
  });

  final double basicRadius; //光点の基本サイズ
  final double maxBackRadius; //後光の最大サイズ
  final double animationRadius; //後光アニメーションサイズ
  final Color lightColor; //光点の色
  final double offsetX;
  final double offsetY;
  final double diffOffsetY; //スキャン毎のdepth差分

  //後光の設定
  static const Map<int, Map<String, double>> lightLayers = {
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

  @override
  void paint(Canvas canvas, Size size) {
    var c = Offset(offsetX, offsetY); //光点の表示位置x,y
    //光点の実体を配置
    canvas.drawCircle(
      c,
      basicRadius,
      Paint()
        ..color = lightColor
        ..style = PaintingStyle.fill, //塗り潰しの円
    );

    var size = basicRadius;

    //後光配列ループ
    for (var i = 0; i < lightLayers.length; i++) {
      var row = lightLayers[i]!;
      //後光の透明度の算出
      var opacity =
          animationRadius * (row['maxOpacity']! / maxBackRadius * -1) +
              row['maxOpacity']!;
      //誤差でmax-min外れないように
      opacity = opacity < 0.0 ? 0.0 : opacity;
      opacity = opacity > 1.0 ? 1.0 : opacity;
      //後光サイズ
      size += animationRadius;

      //上下のズレ
      var y = offsetY + (diffOffsetY * (i + 1 / lightLayers.length));
      c = Offset(offsetX, y); //光点の表示位置x,y
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

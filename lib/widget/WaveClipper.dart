import 'package:flutter/material.dart';
import 'dart:math' as math;

class WaveClipper extends CustomClipper<Path> {
  final BuildContext context;
  final double waveControllerValue; // waveController.valueの値
  final double offset; // 波のずれ
  final double windLevel; // 風レベル
  final List<Offset> coordinateList = []; // 波の座標のリスト

  static const MAX_WAVE_HEIGHT = 10;

  late double WaveHeight = 0; //波の高さ
  late double WaveHindo = 3; //波の頻度 低いほど多い

  WaveClipper(this.context, this.waveControllerValue, this.offset, this.windLevel) {
    final width = MediaQuery.of(context).size.width; // 画面の横幅
    //final height = MediaQuery.of(context).size.height; // 画面の高さ
    final height = 31; //波描画の最低座標
    WaveHeight = MAX_WAVE_HEIGHT * windLevel;

    // coordinateListに波の座標を追加
    for (var i = 0; i <= width / WaveHindo; i++) {
      final step = (i / width) - waveControllerValue;
      coordinateList.add(
        Offset(
          i.toDouble() * WaveHindo, // X座標
          //math.sin(step * 2 * math.pi - offset) * 45 + height * 0.5, // Y座標
          math.sin(step * 2 * math.pi - offset) * WaveHeight + height, // Y座標
        ),
      );
    }
  }
  // 2
  @override
  Path getClip(Size size) {
    final path = Path()
      // addPolygon: coordinateListに入っている座標を直線で結ぶ。
      //             false -> 最後に始点に戻らない
      ..addPolygon(coordinateList, false)
      ..lineTo(size.width, 40) // 画面右下へ
      ..lineTo(0, 40) // 画面左下へ
      ..close(); // 始点に戻る
    return path;
  }

  // 3
  // 再クリップするタイミング -> animationValueが更新されていたとき
  @override
  bool shouldReclip(WaveClipper oldClipper) =>
      waveControllerValue != oldClipper.waveControllerValue;
}

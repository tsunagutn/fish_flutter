import 'package:flutter/material.dart';
import 'dart:math' as math;

class WaveClipper extends CustomClipper<Path> {
  // 1
  static const WaveHeight = 3; //波の高さ

  WaveClipper(this.context, this.waveControllerValue, this.offset) {
    final width = MediaQuery.of(context).size.width; // 画面の横幅
    final height = MediaQuery.of(context).size.height; // 画面の高さ
    //final height = 50; // 画面の高さ

    // coordinateListに波の座標を追加
    for (var i = 0; i <= width / 3; i++) {
      final step = (i / width) - waveControllerValue;
      coordinateList.add(
        Offset(
          i.toDouble() * 3, // X座標
          //math.sin(step * 2 * math.pi - offset) * 45 + height * 0.5, // Y座標
          math.sin(step * 2 * math.pi - offset) * WaveHeight + 33, // Y座標
        ),
      );
    }
  }

  final BuildContext context;
  final double waveControllerValue; // waveController.valueの値
  final double offset; // 波のずれ
  final List<Offset> coordinateList = []; // 波の座標のリスト

  // 2
  @override
  Path getClip(Size size) {
    final path = Path()
      // addPolygon: coordinateListに入っている座標を直線で結ぶ。
      //             false -> 最後に始点に戻らない
      ..addPolygon(coordinateList, false)
      ..lineTo(size.width, size.height) // 画面右下へ
      ..lineTo(0, size.height) // 画面左下へ
      ..close(); // 始点に戻る
    return path;
  }

  // 3
  // 再クリップするタイミング -> animationValueが更新されていたとき
  @override
  bool shouldReclip(WaveClipper oldClipper) =>
      waveControllerValue != oldClipper.waveControllerValue;
}

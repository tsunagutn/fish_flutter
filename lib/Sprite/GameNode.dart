import 'dart:ui';

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:spritewidget/spritewidget.dart';

// //レイヤ
// class GameNode extends NodeWithSize {
//   GameNode(Size size) : super(size) {
//     userInteractionEnabled = true; // タッチを有効にする.
//   }

//   @override
//   void update(double dt) {
//     // TOOD: 更新処理.
//   }

//   @override
//   bool handleEvent(SpriteBoxEvent event) {
//     switch (event.type) {
//       case PointerDownEvent:
//         debugPrint("PointerDownEvent");
//         break;
//       case PointerMoveEvent:
//         debugPrint("PointerMoveEvent");
//         break;
//       case PointerUpEvent:
//         debugPrint("PointerUpEvent");
//         break;
//       case PointerCancelEvent:
//         debugPrint("PointerCancelEvent");
//         break;
//     }

//     return true;
//   }
// }

class GameNode extends NodeWithSize {
  GameNode({
    Size size = Size.zero,
    required Color color,
    required double length,
    bool reverse = false,
  })  : this.color = color,
        this.length = length,
        this.reverse = reverse,
        super(size);
  final Color color;
  final double length;
  final bool reverse;

  @override
  void paint(Canvas canvas) {
    // パスの作成
    final path = Path();
    path.moveTo(length * 2, 0);
    if (reverse) {
      path.lineTo(length * 3, -length);
      path.lineTo(0, -length);
      path.lineTo(0, 0);
    } else {
      path.lineTo(length * 3, length);
      path.lineTo(0, length);
      path.lineTo(0, 0);
    }
    // 図形の描画
    canvas.drawPath(
      path,
      Paint()..color = color,
    );
  }
}

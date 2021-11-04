import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';
import 'BaseNode.dart';

class RootNode extends NodeWithSize {
  var move1;
  var move2;
  var rotate1;
  var rotate2;
  var delay;
  RootNode(Size size) : super(size) {
    move1 = MotionTween<Offset>(
      (animation) => baseNode.position = animation,
      Offset(size.width / 2, size.height),
      Offset(size.width / 2, size.height / 3),
      1.0,
    );
    move2 = MotionTween<Offset>(
      (animation) => baseNode.position = animation,
      Offset(size.width / 2, size.height / 3),
      Offset(size.width / 2, size.height),
      0.75,
    );
    rotate1 = MotionTween<double>(
      (animation) => baseNode.rotation = animation,
      0,
      -45.0,
      1.0,
    );
    rotate2 = MotionTween<double>(
      (animation) => baseNode.rotation = animation,
      -45.0,
      0,
      0.75,
    );
    delay = MotionDelay(2.0);

    final sequence = MotionSequence([
      move1,
      rotate1,
      delay,
      rotate2,
      move2,
    ]);

    debugPrint("あえあえええええ");
    // スプライトにモーションを追加
    baseNode.motions.run(MotionRepeatForever(sequence));

    // 子スプライトを追加
    this.addChild(baseNode);
    userInteractionEnabled = true; // タッチを有効にする.
  }
  final baseNode = BaseNode(Size.zero);

  @override
  void update(double dt) {
    // TOOD: 更新処理.
  }

  @override
  bool handleEvent(SpriteBoxEvent event) {
    switch (event.type) {
      case PointerDownEvent:
        debugPrint("PointerDownEvent");
        final sequence = MotionSequence([
          move1,
          rotate1,
          delay,
          rotate2,
          move2,
        ]);
        baseNode.motions.run(MotionRepeatForever(sequence));
        break;
      case PointerMoveEvent:
        debugPrint("PointerMoveEvent");
        break;
      case PointerUpEvent:
        debugPrint("PointerUpEvent");
        break;
      case PointerCancelEvent:
        debugPrint("PointerCancelEvent");
        break;
    }

    return true;
  }
}

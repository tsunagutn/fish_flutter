import 'dart:ui';

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:spritewidget/spritewidget.dart';

//レイヤ
class MainNode extends NodeWithSize {
  //Sprite _sprite;

  MainNode(Size size) : super(size) {
    userInteractionEnabled = true; // タッチを有効にする.
    //   Image image = new Image(image:AssetImage('Assets/Images/player.png'));
    //       _sprite = Sprite.fromImage(Image* image);
    //     ..position = position
    //     ..zPosition = 0;
    //   addChild(_sprite);
  }

  @override
  void update(double dt) {
    // TOOD: 更新処理.
  }

  @override
  bool handleEvent(SpriteBoxEvent event) {
    switch (event.type) {
      case PointerDownEvent:
        debugPrint("PointerDownEvent");
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

//装備しているタックルのモデル
import 'dart:ui';

enum enumImageDispType {
  sky,
  surface,
  Under,
  Bottom,
}

//画面に不定期で描画する画像のクラス
class ImageModel {
  int id;
  Image image;
  enumImageDispType type;
  double width;
  double height;
  double top;
  double left;
  double startDepth; //MAX水深がこの値の時右から描画開始
  double endDepth; //MAX水深がこの値の時左に描画終了
  bool flgDisp;

  //コンストラクタ
  ImageModel({
    required this.id,
    required this.image,
    required this.type,
    required this.width,
    required this.height,
    required this.top,
    required this.left,
    required this.startDepth,
    required this.endDepth,
    required this.flgDisp,
  });
}

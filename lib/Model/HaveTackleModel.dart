//装備しているタックルのモデル
import 'package:fish_flutter/Model/LuresModel.dart';

class HaveTackleModel {
  late List<HaveLuresModel> haveLures = [];

  //コンストラクタ
  HaveTackleModel() {
    haveLures = [];
    //テスト用 初期所持ルアーを登録
    haveLures.add(new HaveLuresModel(lureId: 0, lureHp: 700, flgUse: true));

  }

  // //使用中ルアーを返す
  // HaveLuresModel getUseLure() {
  //   HaveLuresModel ret;
  //   Iterable<HaveLuresModel> useLure =
  //       haveLures.where((HaveLuresModel value) => value.flgUse == true);
  //   if (useLure.length > 0) {
  //     ret = haveLures[0];
  //   }
  //   return ret;
  // }

  //ルアー追加
  addLure(LureModel lure) {
    haveLures.add(
        new HaveLuresModel(lureId: lure.id, lureHp: lure.hp, flgUse: false));
  }

  //ルアーチェンジ
  changeLure(int lureId) {
    //haveLures全てのレコードのflgUseをfalseにする
    //引数のレコードのflgUseをtrueにする
  }
}

class HaveLuresModel {
  int lureId;
  int lureHp;
  bool flgUse;

  //コンストラクタ
  HaveLuresModel({
    required this.lureId,
    required this.lureHp,
    required this.flgUse,
  });
}
